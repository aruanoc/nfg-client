require 'spec_helper'
require 'nfg-client/utils'

describe NFGClient::Utils do

  class TestClass
    include ::NFGClient::Utils

  end

  let(:test_class) { TestClass.new }

  describe "#build_nfg_soap_request" do
    subject { test_class.build_nfg_soap_request('CreateCOF', new_cof_params) }
    context "when a text field contains a non-standard character" do
      let(:new_cof_params) { create_cof_params.merge({first_name: 'Janet & Peter'}) }

      it "should encode them" do
        expect(subject).to match(/Janet &amp; Peter/)
      end
    end

  end
end
