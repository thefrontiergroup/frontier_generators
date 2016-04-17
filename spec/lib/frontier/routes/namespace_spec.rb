require 'spec_helper'

describe Frontier::Routes::Namespace do

  describe "#namespace_string" do
    subject { namespace.namespace_string }
    let(:namespace) { Frontier::Routes::Namespace.new(name, depth) }
    let(:name)  { "admin" }
    let(:depth) { 0 }

    it { should eq("namespace :admin do") }
  end

  describe "#denormalized_namespace_string" do
    subject { namespace.denormalized_namespace_string }
    let(:namespace) { Frontier::Routes::Namespace.new(name, depth) }
    let(:name)  { "admin" }
    let(:depth) { 0 }

    it { should eq("namespace(:admin) do") }
  end

end
