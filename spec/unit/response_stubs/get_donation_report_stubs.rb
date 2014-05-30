require 'unit/response_stubs/spec_response_helpers'

def successful_get_donation_report_response
  <<-XML
    <?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
      <GetDonationReportResponse xmlns="http://api.networkforgood.org/partnerdonationservice">
        <GetDonationReportResult>
          <ReportResults>
            <DonationReportResult>
              <Source>GiveCorps</Source>
              <Campaign>GivingDay</Campaign>
              <ChargeId>123587</ChargeId>
              <ShareWithCharity>Yes</ShareWithCharity>
              <DonorEmail>jimmy@smith.com</DonorEmail>
              <DonorFirstName>Jimmy</DonorFirstName>
              <DonorLastName>Smith</DonorLastName>
              <DonorAddress1>123 This Street</DonorAddress1>
              <DonorAddress2></DonorAddress2>
              <DonorCity>Baltimore</DonorCity>
              <DonorState>MD</DonorState>
              <DonorZip>21210</DonorZip>
              <DonorCountry>US</DonorCountry>
              <DonorPhone>410-555-5555</DonorPhone>
              <Designation>Annual Giving</Designation>
              <DonateInName></DonateInName>
              <RecurringPeriod></RecurringPeriod>
              <EventDate></EventDate>
              <NpoEIN>45-454545</NpoEIN>
              <NpoName>My Charity</NpoName>
              <ChargeStatus>Accepted</ChargeStatus>
              <ChargeAmount>100.00</ChargeAmount>
              <NpoTPC>0.00</NpoTPC>
              <DonationItemAmount>100.00</DonationItemAmount>
              <TotalDonationAmount>100.00</TotalDonationAmount>
              <HistoryRecordId>132588</HistoryRecordId>
            </DonationReportResult>
            <DonationReportResult>
              <Source>GiveCorps</Source>
              <Campaign>Christmas</Campaign>
              <ChargeId>5555846</ChargeId>
              <ShareWithCharity>No</ShareWithCharity>
              <DonorEmail>janet@smith.com</DonorEmail>
              <DonorFirstName>Janet</DonorFirstName>
              <DonorLastName>Smith</DonorLastName>
              <DonorAddress1>456 That Street</DonorAddress1>
              <DonorAddress2></DonorAddress2>
              <DonorCity>Glen Burnie</DonorCity>
              <DonorState>MD</DonorState>
              <DonorZip>21564</DonorZip>
              <DonorCountry>US</DonorCountry>
              <DonorPhone>410-444-5585</DonorPhone>
              <Designation>Boat Race</Designation>
              <DonateInName>Doris Smith</DonateInName>
              <RecurringPeriod>Monthly</RecurringPeriod>
              <EventDate></EventDate>
              <NpoEIN>56-89898</NpoEIN>
              <NpoName>Great Foundation</NpoName>
              <ChargeStatus>Accepted</ChargeStatus>
              <ChargeAmount>50.00</ChargeAmount>
              <NpoTPC>2.50</NpoTPC>
              <DonationItemAmount>50.00</DonationItemAmount>
              <TotalDonationAmount>50.00</TotalDonationAmount>
              <HistoryRecordId>12355</HistoryRecordId>
            </DonationReportResult>
          </ReportResults>
          <ReturnCount>2</ReturnCount>
          <ErrorDetails/>
          <Message/>
          <CallDuration>0.0312504</CallDuration>
          <StatusCode>Success</StatusCode>
        </GetDonationReportResult>
      </GetDonationReportResponse>
      </soap:Body>
    </soap:Envelope>
  XML
end

def unsuccessful_get_donation_report_response
  <<-XML
    <?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <GetDonationReportResponse xmlns="http://api.networkforgood.org/partnerdonationservice">
          <GetDonationReportResult>
            <Message>Report query range is greater than 24 hours.</Message>
            <CallDuration>0.0312504</CallDuration>
            <StatusCode>ValidationFailed</StatusCode>
            <ReportResults/>
            <ReturnCount>0</ReturnCount>
            <ErrorDetails/>
          </GetDonationReportResult>
        </GetDonationReportResponse>
      </soap:Body>
    </soap:Envelope>
  XML
end

def get_donation_report_params
  {
    StartDate: '2014-01-01 00:00:00',
    EndDate: '2014-01-01 12:00:00',
    DonationReportType: 'All'
  }
end
