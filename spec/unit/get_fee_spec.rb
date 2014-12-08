require 'spec_helper'
require 'unit/response_stubs/get_fee_stubs'

describe NFGClient::Client do
  let(:nfg_client) { NFGClient.new('aiduuad', 'aooaid', 'sosois', 'ksidi', true) }
  subject { nfg_client.get_fee(get_fee_params) }

  describe "#get_fee" do
    context "with a successful response" do
      it "should return a hash with a new TotalChargeAmount" do
        nfg_client.expects(:ssl_post).returns(nfg_response('200',successful_get_fee_response))
        expect(subject['StatusCode']).to eq('Success')
        expect(subject['TotalChargeAmount']).to eq("110.00")
        expect(subject['TotalAddFee']).to eq('9.00')
        expect(subject['TotalDeductFee']).to eq('0')
        expect(subject['TipAmount']).to eq('1.00')
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
        nfg_client.expects(:ssl_post).returns(nfg_response('200',unsuccessful_get_fee_response))
        expect(subject['StatusCode']).to eq('ValidationFailed')
        expect(subject['TotalChargeAmount']).to eq('0.0')
      end
    end
  end
end