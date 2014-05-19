require 'spec_helper'
require 'unit/response_stubs/create_cof'

describe NFGClient::Client do
  let(:nfg_client) { NFGClient.new('aiduuad', 'aooaid', 'sosois', 'ksidi', true) }
  subject { nfg_client.create_cof(create_cof_params) }
  describe "#create_cof" do
    context "with a successful response" do
      it "should return a hash with a new COFId" do
        nfg_client.expects(:ssl_post).returns(nfg_response('200',successful_create_cof_response('ISUDUD')))
        expect(subject['StatusCode']).to eq('Success')
        expect(subject['DonorToken']).to eq('ISUDUD')
        expect(subject['COFId']).to eq('282883')
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
        nfg_client.expects(:ssl_post).returns(nfg_response('200',unsuccessful_create_cof_response('ISUDUD')))
        expect(subject['StatusCode']).to eq('ValidationFailed')   
        expect(subject['DonorToken']).to eq('ISUDUD')

      end
    end
  end
end

