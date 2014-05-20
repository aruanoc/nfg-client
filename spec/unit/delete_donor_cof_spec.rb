require 'spec_helper'
require 'unit/response_stubs/delete_donor_cof_stubs'

describe NFGClient::Client do
  let(:nfg_client) { NFGClient.new('aiduuad', 'aooaid', 'sosois', 'ksidi', true) }
  subject { nfg_client.delete_donor_cof(delete_donor_cof_params) }
  describe "#delete_donor_cof" do
    context "with a successful response" do
      it "should return a hash with a status code of success" do
        nfg_client.expects(:ssl_post).returns(nfg_response('200',successful_delete_donor_cof_response('ISUDUD')))
        expect(subject['StatusCode']).to eq('Success')
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
        nfg_client.expects(:ssl_post).returns(nfg_response('200',unsuccessful_delete_donor_cof_response('ISUDUD')))
        expect(subject['StatusCode']).to eq('ValidationFailed')   
        expect(subject['Message']).to eq('COFAlreadyDeleted - Attempt made to delete a Card on File that has already been deleted')

      end
    end
  end
end

