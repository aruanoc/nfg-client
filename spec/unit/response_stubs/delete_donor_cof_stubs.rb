require 'unit/response_stubs/spec_response_helpers'

def successful_delete_donor_cof_response
  <<-XML
    <?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <DeleteDonorCOFResponse xmlns="http://api.networkforgood.org/partnerdonationservice">
          <DeleteDonorCOFResult>
            <StatusCode>Success</StatusCode>
            <Message></Message>
            <ErrorDetails></ErrorDetails>
            <CallDuration>0.051235</CallDuration>
          </DeleteDonorCOFResult>
        </DeleteDonorCOFResponse>
      </soap:Body>
    </soap:Envelope>
  XML
end

def unsuccessful_delete_donor_cof_response
  <<-XML
    <?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <DeleteDonorCOFResponse xmlns="http://api.networkforgood.org/partnerdonationservice">
          <DeleteDonorCOFResult>
            <StatusCode>ValidationFailed</StatusCode>
            <Message>COFAlreadyDeleted - Attempt made to delete a Card on File that has already been deleted</Message>
            <ErrorDetails>
              <ErrorInfo>
                <ErrCode>COFAlreadyDeleted</ErrCode>
                <ErrData></ErrData>
              </ErrorInfo>
            </ErrorDetails>
            <CallDuration>0.051235</CallDuration>
          </DeleteDonorCOFResult>
        </DeleteDonorCOFResponse>
      </soap:Body>
    </soap:Envelope>
  XML
end

def delete_donor_cof_params
  {
    DonorToken: 'AIH3939',
    COFId: '1111111',
  }
end