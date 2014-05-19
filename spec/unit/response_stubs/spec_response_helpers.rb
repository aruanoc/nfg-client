require 'ostruct'

def server_error_response
  <<-XML  
    <?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        Unauthorized Client IP Address ERR ID: 163556345
      </soap:Body>
    </soap:Envelope>
  XML
end

def nfg_response(code, body)
  OpenStruct.new(code: code, body: body)
end