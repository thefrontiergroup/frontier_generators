require 'spec_helper'

describe Frontier::StringAligner do

  describe "#aligned" do
    subject { aligner.aligned }
    let(:aligner) { Frontier::StringAligner.new(strings, token) }
    let(:token) { "{" }

    context "when the token appears multiple times" do
      let(:strings) do
        [
          "first_name { {} }",
          "surname { 'Maguire' }",
          "association :address",
        ]
      end

      it do
        should eq([
          "first_name { {} }",
          "surname    { 'Maguire' }",
          "association :address",
        ])
      end
    end

    context "when the token is the only match" do
      let(:strings) do
        [
          "first_name nil",
          "surname nil",
        ]
      end
      let(:token) { "nil" }

      it do
        should eq([
          "first_name nil",
          "surname    nil",
        ])
      end
    end

    context "when there is at least one match" do
      let(:strings) do
        [
          "first_name { 'Jordan' }",
          "surname { 'Maguire' }",
          "association :address",
        ]
      end

      it do
        should eq([
          "first_name { 'Jordan' }",
          "surname    { 'Maguire' }",
          "association :address",
        ])
      end
    end

    context "when there are no matches" do
      let(:strings) { ["jordan!"] }
      it { should eq(["jordan!"]) }
    end

  end

end
