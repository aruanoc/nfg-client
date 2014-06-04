require 'unit/response_stubs/spec_response_helpers'

def successful_create_cof_response(donor_token)
  <<-XML
    <?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <CreateCOFResponse xmlns="http://api.networkforgood.org/partnerdonationservice">
          <CreateCOFResult>
            <DonorToken>#{donor_token}</DonorToken>
            <CofId>1111111</CofId>
            <StatusCode>Success</StatusCode>
            <Message></Message>
            <ErrorDetails></ErrorDetails>
            <CallDuration>0.051235</CallDuration>
          </CreateCOFResult>
        </CreateCOFResponse>
      </soap:Body>
    </soap:Envelope>
  XML
end

def unsuccessful_create_cof_response(donor_token)
  <<-XML
    <?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <CreateCOFResponse xmlns="http://api.networkforgood.org/partnerdonationservice">
          <CreateCOFResult>
            <DonorToken>#{donor_token}</DonorToken>
            <StatusCode>ChargeFailed</StatusCode>
            <CofId></CofId>
            <Message>InvalidCreditCardNumber - Credit Card Number failed validation</Message>
            <ErrorDetails>
              <ErrorInfo>
                <ErrCode>InvalidCreditCardNumber</ErrCode>
                <ErrData></ErrData>
              </ErrorInfo>
            </ErrorDetails>
            <CallDuration>0.051235</CallDuration>
          </CreateCOFResult>
        </CreateCOFResponse>
      </soap:Body>
    </soap:Envelope>
  XML
end