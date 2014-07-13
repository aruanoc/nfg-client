require 'net/http'
require 'rexml/document'

module NFGClient
  module Utils
    @@nfg_urls = {
      'sandbox' => {
        'host' => 'api-sandbox.networkforgood.org',
        'url' => 'https://api-sandbox.networkforgood.org/PartnerDonationService/DonationServices.asmx',
        'wsdl' => 'https://api-sandbox.networkforgood.org/PartnerDonationService/DonationServices.asmx?wsdl'
      },
      'production' => {
        'host' => 'api.networkforgood.org',
        'url' => 'https://api.networkforgood.org/PartnerDonationService/DonationServices.asmx',
        'wsdl' => 'https://api.networkforgood.org/PartnerDonationService/DonationServices.asmx?wsdl'
      }
    }

    # Makes HTTP POST request to NFG server (sandbox or production) and returns parsed XML response.
    #
    # Arguments:
    #   nfg_method: (String)
    #   params: (Hash)
    def nfg_soap_request(nfg_method, params)
      @logger = defined?(Rails) ? Rails.logger : Logger.new(STDOUT)
      if (nfg_method.is_a? String) && (params.is_a? Hash)

        # Build SOAP 1.2 request
        soap_request = build_nfg_soap_request(nfg_method, params)

        headers = format_headers(nfg_method, soap_request)

        # Being HTTP Post
        begin
          response = ssl_post(soap_request, headers)
          @logger.info response
          return_value = parse_result(response.code, response.body, response.message, nfg_method)
        rescue StandardError => e
          @logger.error " nfg_soap_request failed: #{ e.message }"
          @logger.error e.backtrace.join(' ')

          return_value = Hash.new
          return_value['StatusCode'] = 'UnexpectedError'
          return_value['Message'] = e
          return_value['ErrorDetails'] = e.backtrace.join(' ')
        end

        return_value
      else
        raise ArgumentError.new('http_post requires a nfg_method and a hash of params')
      end
    end

    # Returns a complete NFG SOAP request based on the provided target method and params
    def build_nfg_soap_request(nfg_method, params)
      get_nfg_soap_request_template.gsub('|body|',"<#{nfg_method} xmlns=\"http://api.networkforgood.org/partnerdonationservice\">#{hash_to_xml(params)}</#{nfg_method}>")
    end

    # Parses the response code and body and returns and appropriate result hash
    #
    # Arguments:
    #   code: (String)
    #   body: (XML string)
    #   message: string
    #   nfg_method: string
    def parse_result(code, body, message, nfg_method)
      return_value = Hash.new
      if code == '200'
        parsed = REXML::Document.new(body)
        # Build return hash parsing XML response
        if parsed.root.nil?
          return_value['StatusCode'] = 'MissingParameter'
          return_value['Message'] = body
          return_value['ErrorDetails'] = nil
        else
          return_value = parsed.root.elements['soap:Body'].elements["#{nfg_method}Response"].elements["#{nfg_method}Result"]
        end
      else
        return_value['StatusCode'] = 'UnexpectedError'
        return_value['Message'] = message
        return_value['ErrorDetails'] = body
      end
      return_value
    end

    # Returns a SOAP template with no body
    def get_nfg_soap_request_template
      "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap12:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\"><soap12:Body>|body|</soap12:Body></soap12:Envelope>"
    end

    # Makes HTTPS post request with given body (soap_request) and headers
    #
    # Arguments:
    #   soap_request: (String)
    #   headers: (Hash)
    def ssl_post(soap_request, headers)
       uri = URI.parse(url)
       https_conn = Net::HTTP.new(uri.host, uri.port)
       https_conn.use_ssl = true
       https_conn.post(uri.path, soap_request, headers)
    end

    # Returns NFG friendly headers hash for HTTPS post
    #
    # Arguments:
    #   nfg_method: (String)
    #   soap_request: (String)
    def format_headers(nfg_method, soap_request)
      {
        'Host' => host,
        'Content-Type' => 'application/soap+xml; charset=utf-8',
        'Content-Length' => soap_request.length.to_s,
        'SOAPAction' => "#{url}/#{nfg_method}".gsub('.asmx','')
      }
    end

    # Returns NFG target host
    def host
      return @@nfg_urls['sandbox']['host'] if @use_sandbox
      @@nfg_urls['production']['host']
    end

    # Returns NFG target URL
    def url
      return @@nfg_urls['sandbox']['url'] if @use_sandbox
      @@nfg_urls['production']['url']
    end

    # Returns a string containing an XML representation of the given hash
    #
    # Arguments:
    #   hash: (Hash)
    def hash_to_xml(hash)
      hash.map do |k, v|
        text = (v.is_a? Hash) ? hash_to_xml(v) : v
        # It removes the digits at the end of each "DonationItem" hash key
        xml_elem = (v.is_a? Hash) ? k.to_s.gsub(/(\d)/, "") : k
        "<%s>%s</%s>" % [xml_elem, text, xml_elem]
      end.join
    end

    # Raises an exception if the required params are not part of the given hash
    #
    # Arguments:
    #   hash: (Hash)
    #   *params: (Array or Symbol)
    def requires!(hash, *params)
      params.each do |param|
        if param.is_a?(Array)
          raise ArgumentError.new("Missing required parameter: #{param.first}") unless hash.has_key?(param.first) || hash.has_key?(param.first.to_s)

          valid_options = param[1..-1]
          raise ArgumentError.new("Parameter: #{param.first} must be one of #{valid_options.to_sentence(:words_connector => 'or')}") unless valid_options.include?(hash[param.first]) || valid_options.include?(hash[param.first.to_s])
        else
          raise ArgumentError.new("Missing required parameter: #{param}") unless hash.has_key?(param) || hash.has_key?(param.to_s)
        end
      end
    end
  end
end