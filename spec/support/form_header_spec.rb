require 'spec_helper'

describe Frontier::FormHeader do

  let(:form_header) { Frontier::FormHeader.new(model_configuration) }
  let(:model_configuration) { ModelConfiguration.new(attributes) }

  describe "#to_s" do
    subject { form_header.to_s }
    let(:attributes) do
      {
        model: {namespaces: namespaces}
      }
    end

    context "when there are no namespaces" do
      let(:namespaces) { nil }
      it { should eq("simple_form_for @model, wrapper: \"horizontal\", html: {class: \"form-horizontal\"} do |f|") }
    end

    context "when there are namespaces" do
      let(:namespaces) { [:namespace] }
      it { should eq("simple_form_for [:namespace, @model], wrapper: \"horizontal\", html: {class: \"form-horizontal\"} do |f|") }
    end

  end

end