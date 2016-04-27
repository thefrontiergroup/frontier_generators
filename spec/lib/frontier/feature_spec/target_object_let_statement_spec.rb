require 'spec_helper'

describe Frontier::FeatureSpec::TargetObjectLetStatement do

  describe "#to_s" do
    let(:let_statement) { Frontier::FeatureSpec::TargetObjectLetStatement.new(model_configuration) }

    describe "with include_resource: true" do
      subject { let_statement.to_s }

      context "with no nested models" do
        let(:model_configuration) { Frontier::ModelConfiguration.new({model_name: {}}) }
        it { should eq("let!(:model_name) { FactoryGirl.create(:model_name) }") }
      end

      context "with a nested model" do
        let(:model_configuration) do
          Frontier::ModelConfiguration.new({
            model_name: {
              controller_prefixes: ["@cat"]
            }
          })
        end
        let(:params) { {user: "attributes"} }

        let(:expected) do
          raw = <<STRING
let!(:model_name) { FactoryGirl.create(:model_name, cat: cat) }
let(:cat) { FactoryGirl.create(:cat) }
STRING
          raw.rstrip
        end

        it { should eq(expected) }
      end

      context "with some nested models" do
        let(:model_configuration) do
          Frontier::ModelConfiguration.new({
            model_name: {
              controller_prefixes: ["@user", "@cat"]
            }
          })
        end
        let(:params) { {user: "attributes"} }

        let(:expected) do
          raw = <<STRING
let!(:model_name) { FactoryGirl.create(:model_name, cat: cat) }
let(:cat) { FactoryGirl.create(:cat, user: user) }
let(:user) { FactoryGirl.create(:user) }
STRING
          raw.rstrip
        end

        it { should eq(expected) }
      end
    end

    describe "with include_resource: false" do
      subject { let_statement.to_s(include_resource: false) }

      context "with no nested models" do
        let(:model_configuration) { Frontier::ModelConfiguration.new({model_name: {}}) }
        it { should eq("") }
      end

      context "with a nested model" do
        let(:model_configuration) do
          Frontier::ModelConfiguration.new({
            model_name: {
              controller_prefixes: ["@cat"]
            }
          })
        end
        let(:params) { {user: "attributes"} }

        let(:expected) do
          raw = <<STRING
let(:cat) { FactoryGirl.create(:cat) }
STRING
          raw.rstrip
        end

        it { should eq(expected) }
      end

      context "with some nested models" do
        let(:model_configuration) do
          Frontier::ModelConfiguration.new({
            model_name: {
              controller_prefixes: ["@user", "@cat"]
            }
          })
        end
        let(:params) { {user: "attributes"} }

        let(:expected) do
          raw = <<STRING
let(:cat) { FactoryGirl.create(:cat, user: user) }
let(:user) { FactoryGirl.create(:user) }
STRING
          raw.rstrip
        end

        it { should eq(expected) }
      end
    end
  end

end
