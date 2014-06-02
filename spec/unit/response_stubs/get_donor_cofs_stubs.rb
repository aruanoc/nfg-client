require 'unit/response_stubs/spec_response_helpers'

def successful_get_donor_cofs_response(donor_token)
  <<-XML
    <?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <GetDonorCOFsResponse xmlns="http://api.networkforgood.org/partnerdonationservice">
          <GetDonorCOFsResult>
            <DonorToken>#{donor_token}</DonorToken>
            <Cards>
              <COFRecord>
                <COFId>33333333</COFId>
                <CardType>Visa</CardType>
                <CCSuffix>4236</CCSuffix>
                <CCExpMonth>05</CCExpMonth>
                <CCExpYear>16</CCExpYear>
                <bInUseByLiveRD>true</bInUseByLiveRD>
                <COFEmailAddress></COFEmailAddress>
              </COFRecord>
              <COFRecord>
                <COFId>44444444</COFId>
                <CardType>Mastercard</CardType>
                <CCSuffix>5647</CCSuffix>
                <CCExpMonth>06</CCExpMonth>
                <CCExpYear>18</CCExpYear>
                <bInUseByLiveRD></bInUseByLiveRD>
                <COFEmailAddress></COFEmailAddress>
              </COFRecord>
            </Cards>
            <StatusCode>Success</StatusCode>
            <Message></Message>
            <ErrorDetails></ErrorDetails>
            <CallDuration>0.051235</CallDuration>
          </GetDonorCOFsResult>
        </GetDonorCOFsResponse>
      </soap:Body>
    </soap:Envelope>
  XML
end

def unsuccessful_get_donor_cofs_response(donor_token)
  <<-XML
    <?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <GetDonorCOFsResponse xmlns="http://api.networkforgood.org/partnerdonationservice">
          <GetDonorCOFsResult>
            <DonorToken>#{donor_token}</DonorToken>
            <StatusCode>ValidationFailed</StatusCode>
            <Cards>
            </Cards>
            <Message>UserNotFound - No existing NFG user record associated with the specified DonorToken</Message>
            <ErrorDetails>
              <ErrorInfo>
                <ErrCode>UserNotFound</ErrCode>
                <ErrData></ErrData>
              </ErrorInfo>
            </ErrorDetails>
            <CallDuration>0.051235</CallDuration>
          </GetDonorCOFsResult>
        </GetDonorCOFsResponse>
      </soap:Body>
    </soap:Envelope>
  XML
end