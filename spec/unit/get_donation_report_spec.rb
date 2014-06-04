require 'spec_helper'
require 'unit/response_stubs/get_donation_report_stubs'

describe NFGClient::Client do
  let(:nfg_client) { NFGClient.new('aiduuad', 'aooaid', 'sosois', 'ksidi', true) }
  subject { nfg_client.get_donation_report(get_donation_report_params) }

  describe "#get_donation_report" do
    context "with a successful response" do
      it "should return a hash with a new TotalChargeAmount" do
        nfg_client.expects(:ssl_post).returns(nfg_response('200',successful_get_donation_report_response))
        expect(subject['StatusCode']).to eq('Success')
        expect(subject['ReturnCount']).to eq("2")
        expect(subject['ReportResults'].length).to eq(2)
        expect(subject['ReportResults'].first['ChargeId']).to eq('123587')
        expect(subject['ReportResults'].last['ChargeId']).to eq('5555846')
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
        nfg_client.expects(:ssl_post).returns(nfg_response('200',unsuccessful_get_donation_report_response))
        expect(subject['StatusCode']).to eq('ValidationFailed')
        expect(subject['ReportResults'].length).to eq(0)
      end
    end
  end
end