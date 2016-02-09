require 'spec_helper'

RSpec.describe Frontier::RubyRenderer do

  describe "#render" do
    subject { Frontier::RubyRenderer.new(string).render(number_of_indents) }

    context "with a single line of text" do
      let(:string) { "Jordan rules!" }

      context "with no indents" do
        let(:number_of_indents) { 0 }
        it { should eq("Jordan rules!") }
      end

      context "with some indents" do
        let(:number_of_indents) { 1 }
        it { should eq("  Jordan rules!") }
      end
    end

    context "with a multiline string" do
      let(:string) do
        <<-STRING
Jordan rules
  again!
still!
STRING
      end

      context "with no indents" do
        let(:expected) do
          raw = <<-STRING
Jordan rules
  again!
still!
STRING
          raw.rstrip
        end
        let(:number_of_indents) { 0 }
        it { should eq(expected) }
      end

      context "with some indents" do
        let(:expected) do
          raw = <<-STRING
  Jordan rules
    again!
  still!
STRING
          raw.rstrip
        end
        let(:number_of_indents) { 1 }
        it { should eq(expected) }
      end
    end
  end

end
