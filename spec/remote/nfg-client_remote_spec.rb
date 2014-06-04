require 'spec_helper'

# Your ip address must be whitelisted at NFG for these tests to work


describe NFGClient do
  let(:nfg_client) { NFGClient.new(PartnerID, PartnerPW, PartnerSource, PartnerCampaign, true) }
  describe "create_cof" do
    context 'with valid information' do
      it "should create a card on file" do
        result = nfg_client.create_cof(create_cof_params)
        expect(result["StatusCode"]).to eql('Success')
        expect(result["DonorToken"]).to eql(create_cof_params[:DonorToken])
        expect(result["COFId"]).to_not eq('0')
      end
    end

    context "with invalid information" do
      it "should not create a card on file" do
        result = nfg_client.create_cof(create_cof_params.merge({ ExpYear: '14' }))
        expect(result["StatusCode"]).to eql('ValidationFailed')
        expect(result["DonorToken"]).to eql(create_cof_params[:DonorToken])
        expect(result["COFId"]).to eql('0')
      end
    end
  end

  describe "get_fee" do
    context 'with valid information' do
      it "should be successful" do
        result = nfg_client.get_fee(get_fee_params)
        expect(result["StatusCode"]).to eql('Success')
        expect(result["TotalChargeAmount"]).to eql("100.0")
      end
    end

    context 'with invalid information' do
      it "should not be successful" do
        result = nfg_client.get_fee(get_fee_params('12-1212121'))
        expect(result["StatusCode"]).to eql('ValidationFailed')
        expect(result["ErrorDetails"]["ErrorInfo"]["ErrCode"]).to eql('NpoNotFound')
      end
    end
  end

  describe "delete_donor_cof" do
    context "with valid information" do
      it "should remove the cof" do
        result = nfg_client.create_cof(create_cof_params)
        result = nfg_client.delete_donor_cof(  { DonorToken: result['DonorToken'], COFId: result['COFId']})
        expect(result["StatusCode"]).to eql('Success')
      end
    end

    context "with invalid COFId" do
      it "should return an error" do
        result = nfg_client.delete_donor_cof( delete_donor_cof_params )
        expect(result["StatusCode"]).to eql('OtherError')
      end
    end
  end

  describe "make_cof_donation" do
    context "with valid information" do
      it "should make the donation" do
        result = nfg_client.create_cof(create_cof_params)
        result = nfg_client.make_cof_donation(make_cof_donation_params(result['COFId']))
        expect(result["StatusCode"]).to eql('Success')
        expect(result["ChargeId"]).to_not eq('0')
      end
    end

    context "with invalid information" do
      it "should not make the donation" do
        result = nfg_client.make_cof_donation(make_cof_donation_params)
        expect(result["StatusCode"]).to eql('ValidationFailed')
        expect(result["ChargeId"]).to eq('0')
        expect(result["ErrorDetails"]["ErrorInfo"]["ErrCode"]).to eql('COFNotFound')
      end
    end
  end

  describe "make_donation_add_cof" do
    context "with valid information" do
      it "should make the donation" do
        result = nfg_client.make_donation_add_cof(make_donation_add_cof_params)
        expect(result["StatusCode"]).to eql('Success')
        expect(result["ChargeId"]).to_not eq('0')
        expect(result["COFId"]).to_not eq('0')
      end
    end

    context "with invalid information" do
      it "should not make the donation" do
        result = nfg_client.make_donation_add_cof(make_donation_add_cof_params('444'))
        expect(result["StatusCode"]).to eql('ChargeFailed')
        expect(result["ChargeId"]).to_not eq('0')
        expect(result["COFId"]).to eq('0')
      end
    end
  end

  describe "get_donor_donation_history" do
    it "should return something" do
      result = nfg_client.create_cof(create_cof_params)
      params = make_donation_add_cof_params
      result = nfg_client.make_donation_add_cof(params)
      result =  nfg_client.get_donor_donation_history(DonorToken: params[:DonorToken])

      expect(result["StatusCode"]).to eql('Success')
      expect(result["Donations"]).to eql('Success')
    end
  end
end

