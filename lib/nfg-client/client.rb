module NFGClient

  def self.new(partner_id, partner_password, partner_source, partner_campaign, use_sandbox = false)
    NFGClient::Client.new(partner_id, partner_password, partner_source, partner_campaign, use_sandbox)
  end

  class Client
    include NFGClient::Utils

    def initialize(partner_id, partner_password, partner_source, partner_campaign, use_sandbox)
      @partner_id = partner_id
      @partner_password = partner_password
      @partner_source = partner_source
      @partner_campaign = partner_campaign
      @use_sandbox = use_sandbox
    end

    # Creates a card on file for the given donor token
    #
    # Arguments:
    #   params: (Hash)
    def create_cof(params)
      call_params = add_credentials_to_params(params)
      response = nfg_soap_request('CreateCOF', call_params, @use_sandbox)
      if response.is_a? REXML::Element
        {
          'StatusCode' => response.elements['StatusCode'].get_text.to_s,
          'Message' => response.elements['Message'].get_text.to_s,
          'ErrorDetails' => response.elements['ErrorDetails'].get_text.to_s,
          'CallDuration' => response.elements['CallDuration'].get_text.to_s,
          'DonorToken' => response.elements['DonorToken'].get_text.to_s,
          'COFId' => response.elements['CofId'].get_text.to_s
        }
      else
        response
      end
    end

    # Deletes a card on file for the given donor token
    #
    # Arguments:
    #   params: (Hash)
    def delete_donor_cof(params)
      call_params = add_credentials_to_params(params)
      response = nfg_soap_request('DeleteDonorCOF', call_params, @use_sandbox)
      if response.is_a? REXML::Element
        if response.elements['StatusCode'].get_text.to_s == 'Success'
          {
            'StatusCode' => response.elements['StatusCode'].get_text.to_s,
            'Message' => response.elements['Message'].get_text.to_s,
            'ErrorDetails' => response.elements['ErrorDetails'].get_text.to_s,
            'CallDuration' => response.elements['CallDuration'].get_text.to_s
          }
        else
          {
            'StatusCode' => response.elements['StatusCode'].get_text.to_s,
            'Message' => response.elements['Message'].get_text.to_s,
            'ErrorDetails' => {
              'ErrorInfo' => {
                'ErrCode' => response.elements['ErrorDetails'].andand.elements.andand['ErrorInfo'].andand.elements.andand['ErrCode'].andand.get_text.andand.to_s,
                'ErrData' => response.elements['ErrorDetails'].andand.elements.andand['ErrorInfo'].andand.elements.andand['ErrData'].andand.get_text.andand.to_s
              }
            },
            'CallDuration' => response.elements['CallDuration'].get_text.to_s
          }
        end
      else
        response
      end
    end

    # Gets a list of the given donor token's cards on file
    #
    # Arguments:
    #   params: (Hash)
    def get_donor_cofs(params)
      call_params = add_credentials_to_params(params)
      response = nfg_soap_request('GetDonorCOFs', call_params, @use_sandbox)
      if response.is_a? REXML::Element
        response_hash = {
          'StatusCode' => response.elements['StatusCode'].get_text.to_s,
          'Message' => response.elements['Message'].get_text.to_s,
          'ErrorDetails' => response.elements['ErrorDetails'].get_text.to_s,
          'CallDuration' => response.elements['CallDuration'].get_text.to_s,
          'DonorToken' => response.elements['DonorToken'].get_text.to_s
        }
        response_hash['Cards'] = Array.new
        response.elements.each('Cards/COFRecord') do |card|
          response_hash['Cards'] << {
            'COFId' => card.elements['COFId'].get_text.to_s,
            'CardType' => card.elements['CardType'].get_text.to_s,
            'CCSuffix' => card.elements['CCSuffix'].get_text.to_s,
            'CCExpMonth' => card.elements['CCExpMonth'].get_text.to_s,
            'CCExpYear' => card.elements['CCExpYear'].get_text.to_s,
            'bInUseByLiveRD' => card.elements['bInUseByLiveRD'].get_text.to_s,
            'COFEmailAddress' => card.elements['COFEmailAddress'].get_text.to_s
          }
        end
        response_hash
      else
        response
      end
    end

    # Calculates fee tied to transaction
    #
    # Arguments:
    #   params: (Hash)
    def get_fee(params)
      call_params = add_credentials_to_params(params)
      response = nfg_soap_request('GetFee', call_params, @use_sandbox)
      if response.is_a? REXML::Element
        if response.elements['ErrorDetails'].elements['ErrorInfo'].nil?
          {
            'Message' => response.elements['Message'].get_text.to_s,
            'ErrorDetails' => response.elements['ErrorDetails'].get_text.to_s,
            'CallDuration' => response.elements['CallDuration'].get_text.to_s,
            'TotalChargeAmount' => response.elements['TotalChargeAmount'].get_text.to_s,
            'TotalAddFee' => response.elements['TotalAddFee'].get_text.to_s,
            'TotalDeductFee' => response.elements['TotalChargeAmount'].get_text.to_s,
            'TipAmount' => response.elements['TotalAddFee'].get_text.to_s
          }
        else
          {
            'Message' => response.elements['Message'].get_text.to_s,
            'ErrorDetails' => {
              'ErrorInfo' => {
                'ErrCode' => response.elements['ErrorDetails'].andand.elements.andand['ErrorInfo'].andand.elements.andand['ErrCode'].andand.get_text.andand.to_s,
                'ErrData' => response.elements['ErrorDetails'].andand.elements.andand['ErrorInfo'].andand.elements.andand['ErrData'].andand.get_text.andand.to_s
              }
            },
            'CallDuration' => response.elements['CallDuration'].get_text.to_s,
            'TotalChargeAmount' => response.elements['TotalChargeAmount'].get_text.to_s,
            'TotalAddFee' => response.elements['TotalAddFee'].get_text.to_s,
            'TotalDeductFee' => response.elements['TotalChargeAmount'].get_text.to_s,
            'TipAmount' => response.elements['TotalAddFee'].get_text.to_s
          }
        end
      else
        response
      end
    end

    # Makes a donation using the given COF
    #
    # Arguments:
    #   params: (Hash)
    def make_cof_donation(params)
      call_params = add_credentials_to_params(params)
      response = nfg_soap_request('MakeCOFDonation', call_params, @use_sandbox)
      if response.is_a? REXML::Element
        if response.elements['StatusCode'].get_text.to_s == 'Success'
          {
            'StatusCode' => response.elements['StatusCode'].get_text.to_s,
            'Message' => response.elements['Message'].get_text.to_s,
            'ErrorDetails' => response.elements['ErrorDetails'].get_text.to_s,
            'CallDuration' => response.elements['CallDuration'].get_text.to_s,
            'ChargeId' => response.elements['ChargeId'].get_text.to_s,
            'COFId' => response.elements['CofId'].get_text.to_s
          }
        else
          {
            'StatusCode' => response.elements['StatusCode'].get_text.to_s,
            'Message' => response.elements['Message'].get_text.to_s,
            'ErrorDetails' => {
              'ErrorInfo' => {
                'ErrCode' => response.elements['ErrorDetails'].andand.elements.andand['ErrorInfo'].andand.elements.andand['ErrCode'].andand.get_text.andand.to_s,
                'ErrData' => response.elements['ErrorDetails'].andand.elements.andand['ErrorInfo'].andand.elements.andand['ErrData'].andand.get_text.andand.to_s
              }
            },
            'CallDuration' => response.elements['CallDuration'].get_text.to_s,
            'ChargeId' => response.elements['ChargeId'].get_text.to_s,
            'COFId' => response.elements['CofId'].get_text.to_s
          }
        end
      else
        response
      end
    end

    # Makes a donation and stores a COF for the given donor token
    #
    # Arguments:
    #   params: (Hash)
    def make_donation_add_cof(params)
      call_params = add_credentials_to_params(params)
      response = nfg_soap_request('MakeDonationAddCOF', call_params, @use_sandbox)
      if response.is_a? REXML::Element
        if (response.elements['StatusCode'].get_text.to_s == 'Success') || ((response.elements['StatusCode'].get_text.to_s != 'Success') && response.elements['ErrorDetails'].elements['ErrorInfo'].nil?)
          {
            'StatusCode' => response.elements['StatusCode'].get_text.to_s,
            'Message' => response.elements['Message'].get_text.to_s,
            'ErrorDetails' => response.elements['ErrorDetails'].get_text.to_s,
            'CallDuration' => response.elements['CallDuration'].get_text.to_s,
            'ChargeId' => response.elements['ChargeId'].get_text.to_s,
            'COFId' => response.elements['CofId'].get_text.to_s
          }
        else
          {
            'StatusCode' => response.elements['StatusCode'].get_text.to_s,
            'Message' => response.elements['Message'].get_text.to_s,
            'ErrorDetails' => {
              'ErrorInfo' => {
                'ErrCode' => response.elements['ErrorDetails'].andand.elements.andand['ErrorInfo'].andand.elements.andand['ErrCode'].andand.get_text.andand.to_s,
                'ErrData' => response.elements['ErrorDetails'].andand.elements.andand['ErrorInfo'].andand.elements.andand['ErrData'].andand.get_text.andand.to_s
              }
            },
            'CallDuration' => response.elements['CallDuration'].get_text.to_s,
            'ChargeId' => response.elements['ChargeId'].get_text.to_s,
            'COFId' => response.elements['CofId'].get_text.to_s
          }
        end
      else
        response
      end
    end

    # Retrieves the donation history for a specified donor token
    #
    # Arguments:
    #   params: (Hash)
    def get_donor_donation_history(params)
      call_params = add_credentials_to_params(params)
      response = nfg_soap_request('GetDonorDonationHistory', call_params, @use_sandbox)
      if response.is_a? REXML::Element
        response_hash = {
          'StatusCode' => response.elements['StatusCode'].get_text.to_s,
          'Message' => response.elements['Message'].get_text.to_s,
          'ErrorDetails' => response.elements['ErrorDetails'].get_text.to_s,
          'CallDuration' => response.elements['CallDuration'].get_text.to_s,
          'DonorToken' => response.elements['DonorToken'].get_text.to_s
        }
        response_hash['Donations'] = Array.new
        response.elements.each('Donations/DonationItemData') do |donation|
          response_hash['Donations'] << {
            'DonationDate' => donation.elements['DonationDate'].get_text.to_s,
            'RecurType' => donation.elements['RecurType'].get_text.to_s,
            'IsTpcAddOnFee' => donation.elements['IsTpcAddOnFee'].get_text.to_s,
            'NpoName' => donation.elements['NpoName'].get_text.to_s,
            'Designation' => donation.elements['Designation'].get_text.to_s,
            'Dedication' => donation.elements['Dedication'].get_text.to_s,
            'Amount' => donation.elements['Amount'].get_text.to_s,
            'ChargeId' => donation.elements['ChargeId'].get_text.to_s,
          }
        end
        response_hash
      else
        response
      end
    end

    # Retrieves the donation history by date
    #
    # Arguments:
    #   params: (Hash)
    def get_donation_report(params)
      call_params = add_credentials_to_params(params)
      response = nfg_soap_request('GetDonationReport', call_params, @use_sandbox)
      if response.is_a? REXML::Element
        response_hash = {
          'StatusCode' => response.elements['StatusCode'].get_text.to_s,
          'Message' => response.elements['Message'].get_text.to_s,
          'ErrorDetails' => response.elements['ErrorDetails'].get_text.to_s,
          'CallDuration' => response.elements['CallDuration'].get_text.to_s,
          'ReturnCount' => response.elements['ReturnCount'].get_text.to_s
        }
        response_hash['ReportResults'] = Array.new
        response.elements.each('ReportResults/DonationReportResult') do |donation|
          response_hash['ReportResults'] << {
            'Source' => donation.elements['Source'].get_text.to_s,
            'Campaign' => donation.elements['Campaign'].get_text.to_s,
            'ChargeId' => donation.elements['ChargeId'].get_text.to_s,
            'ShareWithCharity' => donation.elements['ShareWithCharity'].get_text.to_s,
            'DonorEmail' => donation.elements['DonorEmail'].get_text.to_s,
            'DonorFirstName' => donation.elements['DonorFirstName'].get_text.to_s,
            'DonorLastName' => donation.elements['DonorLastName'].get_text.to_s,
            'DonorAddress1' => donation.elements['DonorAddress1'].get_text.to_s,
            'DonorAddress2' => donation.elements['DonorAddress2'].get_text.to_s,
            'DonorCity' => donation.elements['DonorCity'].get_text.to_s,
            'DonorState' => donation.elements['DonorState'].get_text.to_s,
            'DonorZip' => donation.elements['DonorZip'].get_text.to_s,
            'DonorCountry' => donation.elements['DonorCountry'].get_text.to_s,
            'DonorPhone' => donation.elements['DonorPhone'].get_text.to_s,
            'Designation' => donation.elements['Designation'].get_text.to_s,
            'DonateInName' => donation.elements['DonateInName'].get_text.to_s,
            'RecurringPeriod' => donation.elements['RecurringPeriod'].get_text.to_s,
            'EventDate' => donation.elements['EventDate'].get_text.to_s,
            'NpoEIN' => donation.elements['NpoEIN'].get_text.to_s,
            'NpoName' => donation.elements['NpoName'].get_text.to_s,
            'ChargeStatus' => donation.elements['ChargeStatus'].get_text.to_s,
            'ChargeAmount' => donation.elements['ChargeAmount'].get_text.to_s,
            'NpoTPC' => donation.elements['NpoTPC'].get_text.to_s,
            'DonationItemAmount' => donation.elements['DonationItemAmount'].get_text.to_s,
            'TotalDonationAmount' => donation.elements['TotalDonationAmount'].get_text.to_s,
            'HistoryRecordId' => donation.elements['HistoryRecordId'].get_text.to_s
          }
        end
        response_hash
      else
        response
      end
    end

    private

    # Adds client credentials to hash of parameters
    #
    # Arguments:
    #   params: (Hash)
    def add_credentials_to_params(params)
      return params unless params.is_a? Hash
      credentials = {
        'PartnerID' => @partner_id,
        'PartnerPW' => @partner_password,
        'PartnerSource' => @partner_source,
        'PartnerCampaign' => @partner_campaign
      }
      credentials.merge(params)
    end
  end
end