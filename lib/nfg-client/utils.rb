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
    def nfg_soap_request(nfg_method, params, use_sandbox = false)
      if (nfg_method.is_a? String) && (params.is_a? Hash)
        # Build SOAP 1.2 request
        soap_request = build_nfg_soap_request(nfg_method,params)  
        
        headers = format_headers(nfg_method, soap_request)

        return_value = Hash.new

        # Being HTTP Post
        begin
          response = ssl_post(soap_request, headers)         
          if response.code == '200'
            parsed = REXML::Document.new(response.body)
            #return response.body
            # Build return hash parsing XML response
            if parsed.root.nil?
              return_value['StatusCode'] = 'MissingParameter'
              return_value['Message'] = response.body
              return_value['ErrorDetails'] = nil
            else
              return_value = parsed.root.elements['soap:Body'].elements["#{nfg_method}Response"].elements["#{nfg_method}Result"]
            end
          else
            return_value['StatusCode'] = 'UnexpectedError'
            return_value['Message'] = response.message
            return_value['ErrorDetails'] = response.body
          end
        rescue StandardError => e
          return_value['StatusCode'] = 'UnexpectedError'
          return_value['Message'] = e
          return_value['ErrorDetails'] = e.backtrace.join(' ')
        end

        return_value
      else
        raise ArgumentError.new('http_post requires a nfg_method and a hash of params')
      end
    end   

    def build_nfg_soap_request(nfg_method, params)
      get_nfg_soap_request_template.gsub('|body|',"<#{nfg_method} xmlns=\"http://api.networkforgood.org/partnerdonationservice\">#{hash_to_xml(params)}</#{nfg_method}>")
    end

    def get_nfg_soap_request_template
      "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap12:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\"><soap12:Body>|body|</soap12:Body></soap12:Envelope>"
    end

    def ssl_post(soap_request, headers)
       uri = URI.parse(url)
       https_conn = Net::HTTP.new(uri.host, uri.port)
       https_conn.use_ssl = true
       https_conn.post(uri.path, soap_request, headers)           
    end

    def format_headers(nfg_method, soap_request)
      {
        'Host' => host,
        'Content-Type' => 'application/soap+xml; charset=utf-8',
        'Content-Length' => soap_request.length.to_s,
        'SOAPAction' => "#{url}/#{nfg_method}".gsub('.asmx','')
      }
    end

    def host
      return @@nfg_urls['sandbox']['host'] if @use_sandbox
      @@nfg_urls['production']['host']
    end

    def url
      return @@nfg_urls['sandbox']['url'] if @use_sandbox
      @@nfg_urls['production']['url']
    end

    def hash_to_xml(hash)
      hash.map do |k, v|
        text = (v.is_a? Hash) ? hash_to_xml(v) : v
        "<%s>%s</%s>" % [k, text, k]
      end.join
    end
  end
end