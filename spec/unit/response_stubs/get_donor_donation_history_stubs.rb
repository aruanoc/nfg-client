require 'unit/response_stubs/spec_response_helpers'

def successful_get_donor_donation_history_response
  <<-XML
    <?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <GetDonorDonationHistoryResponse xmlns="http://api.networkforgood.org/partnerdonationservice">
          <GetDonorDonationHistoryResult>
            <Donations>
              <DonationItemData>
                <DonationDate>2014-05-22 04:35:00:00</DonationDate>
                <RecurType>Monthly</RecurType>
                <IsTpcAddOnFee>0</IsTpcAddOnFee>
                <NpoName>Red Cross</NpoName>
                <Designation>Famine Relief</Designation>
                <Dedication></Dedication>
                <Amount>50.00</Amount>
                <ChargeId>292929</ChargeId>
              </DonationItemData>
              <DonationItemData>
                <DonationDate>2014-02-22 04:35:00:00</DonationDate>
                <RecurType>NotRecurring</RecurType>
                <IsTpcAddOnFee>1</IsTpcAddOnFee>
                <NpoName>Save The Children</NpoName>
                <Designation>Ethopia Fund</Designation>
                <Dedication>For my mother</Dedication>
                <Amount>250.00</Amount>
                <ChargeId>8939399</ChargeId>
              </DonationItemData>
            </Donations>
            <DonorToken>1828282</DonorToken>
            <StatusCode>Success</StatusCode>
            <Message></Message>
            <ErrorDetails></ErrorDetails>
            <CallDuration>0.051235</CallDuration>
          </GetDonorDonationHistoryResult>
        </GetDonorDonationHistoryResponse>
      </soap:Body>
    </soap:Envelope>
  XML
end

def unsuccessful_get_donor_donation_history_response
  <<-XML
    <?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <GetDonorDonationHistoryResponse xmlns="http://api.networkforgood.org/partnerdonationservice">
          <GetDonorDonationHistoryResult>
            <Message></Message>
            <CallDuration>0</CallDuration>
            <StatusCode>Success</StatusCode>
            <Donations/>
            <ErrorDetails/>
            <DonorToken>1828282</DonorToken>
          </GetDonorDonationHistoryResult>
        </GetDonorDonationHistoryResponse>
      </soap:Body>
    </soap:Envelope>
  XML
end
