require 'spec_helper'
require 'unit/response_stubs/make_cof_donation_stubs'

describe NFGClient::Client do
  let(:nfg_client) { NFGClient.new('aiduuad', 'aooaid', 'sosois', 'ksidi', true) }
  subject { nfg_client.make_cof_donation(make_cof_donation_params) }

  describe "#make_cof_donation" do
    context "with a successful response" do
      it "should return a hash with a new COFId" do
        nfg_client.expects(:ssl_post).returns(nfg_response('200',successful_make_cof_donation_response))
        expect(subject['StatusCode']).to eq('Success')
        expect(subject['COFId']).to eq('1111111')
      end

      it "should return a hash with a transaction Id" do
        nfg_client.expects(:ssl_post).returns(nfg_response('200',successful_make_cof_donation_response))
        expect(subject['StatusCode']).to eq('Success')
        expect(subject['ChargeId']).to eq('3333333')
      end
    end

    context "with a server error" do
      it "should return an UnexpectedError" do
        nfg_client.expects(:ssl_post).returns(nfg_response('500',server_error_response))
        expect(subject['StatusCode']).to eq('UnexpectedError')
      end
    end

    context "with an unsuccessful response" do
      it "should return the appropriate error with new COFid" do
        nfg_client.expects(:ssl_post).returns(nfg_response('200',unsuccessful_make_cof_donation_response))
        expect(subject['StatusCode']).to eq('ChargeFailed')
        expect(subject['DonorToken']).to_not be

      end
    end
  end
end