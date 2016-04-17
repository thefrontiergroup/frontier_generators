require 'spec_helper'

describe Frontier::Routes::Namespace do

  describe "#exists_in_routes_file?" do
    subject { namespace.exists_in_routes_file?(routes_file_content) }
    let(:namespace) { Frontier::Routes::Namespace.new(name, depth) }
    let(:name)  { "admin" }
    let(:depth) { 0 }

    context "when the namespace exists with brackets" do
      let(:routes_file_content) do
        raw = <<STRING
RailsTemplate::Application.routes.draw do

  namespace(:admin) do
    resources :users
  end
end
STRING
      end

      it { should eq(true) }
    end

    context "when the namespace exists WITHOUT brackets" do
      let(:routes_file_content) do
        raw = <<STRING
RailsTemplate::Application.routes.draw do

  namespace :admin do
    resources :users
  end
end
STRING
      end

      it { should eq(true) }
    end

    context "when the namespace doesn't exist" do
      let(:routes_file_content) do
        raw = <<STRING
RailsTemplate::Application.routes.draw do

  namespace :dongle do
    resources :users
  end
end
STRING
      end

      it { should eq(false) }
    end
  end

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
