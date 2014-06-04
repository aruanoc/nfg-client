require 'unit/response_stubs/spec_response_helpers'

def successful_make_cof_donation_response
  <<-XML
    <?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <MakeCOFDonationResponse xmlns="http://api.networkforgood.org/partnerdonationservice">
          <MakeCOFDonationResult>
            <ChargeId>3333333</ChargeId>
            <CofId>1111111</CofId>
            <StatusCode>Success</StatusCode>
            <Message></Message>
            <ErrorDetails></ErrorDetails>
            <CallDuration>0.051235</CallDuration>
          </MakeCOFDonationResult>
        </MakeCOFDonationResponse>
      </soap:Body>
    </soap:Envelope>
  XML
end

def unsuccessful_make_cof_donation_response
  <<-XML
    <?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <MakeCOFDonationResponse xmlns="http://api.networkforgood.org/partnerdonationservice">
          <MakeCOFDonationResult>
            <ChargeId></ChargeId>
            <CofId></CofId>
            <StatusCode>ChargeFailed</StatusCode>
            <Message>InvalidCardOnFile - Specified Card on File could not be found or has been cancelled</Message>
            <ErrorDetails>
              <ErrorInfo>
                <ErrCode>InvalidCardOnFile</ErrCode>
                <ErrData></ErrData>
              </ErrorInfo>
            </ErrorDetails>
            <CallDuration>0.051235</CallDuration>
          </MakeCOFDonationResult>
        </MakeCOFDonationResponse>
      </soap:Body>
    </soap:Envelope>
  XML
end
