require 'unit/response_stubs/spec_response_helpers'

def successful_get_fee_response
  <<-XML
    <?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <GetFeeResponse xmlns="http://api.networkforgood.org/partnerdonationservice">
          <GetFeeResult>
            <TotalChargeAmount>110.00</TotalChargeAmount>
            <TotalAddFee>9.00</TotalAddFee>
            <TotalDeductFee>0</TotalDeductFee>
            <TipAmount>1.00</TipAmount>
            <StatusCode>Success</StatusCode>
            <Message></Message>
            <ErrorDetails></ErrorDetails>
            <CallDuration>0.051235</CallDuration>
          </GetFeeResult>
        </GetFeeResponse>
      </soap:Body>
    </soap:Envelope>
  XML
end

def unsuccessful_get_fee_response
  <<-XML
    <?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <GetFeeResponse xmlns="http://api.networkforgood.org/partnerdonationservice">
          <GetFeeResult>
            <ErrorDetails>
              <ErrorInfo>
                <ErrCode>NpoNotFound</ErrCode>
                <ErrData>The NPO EIN "54-545454" is invalid.</ErrData>
              </ErrorInfo>
            </ErrorDetails>
            <Message></Message>
            <CallDuration>0</CallDuration>
            <TotalChargeAmount>0.0</TotalChargeAmount>
            <TotalAddFee>0.0</TotalAddFee>
            <TotalDeductFee>0.0</TotalDeductFee>
            <TipAmount>0.0</TipAmount>
          </GetFeeResult>
        </GetFeeResponse>
      </soap:Body>
    </soap:Envelope>
  XML
end
