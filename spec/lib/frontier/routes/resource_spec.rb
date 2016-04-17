require 'spec_helper'

describe Frontier::Routes::Resource do

  describe '#exists_in_routes_file?' do
    subject { resource.exists_in_routes_file?(routes_file_content) }
    let(:model_configuration) { Frontier::ModelConfiguration.new({"user" => {}}) }

    context "without namespaces" do
      let(:resource) { Frontier::Routes::Resource.new(model_configuration, []) }

      context "when the resource exists with brackets" do
        let(:routes_file_content) do
          raw = <<STRING
RailsTemplate::Application.routes.draw do
  resources(:users)
end
STRING
        end

        it { should eq(true) }
      end

      context "when the resource exists WITHOUT brackets" do
        let(:routes_file_content) do
          raw = <<STRING
RailsTemplate::Application.routes.draw do
  resources :users
end
STRING
        end

        it { should eq(true) }
      end

      context "when the resource doesn't exist" do
        let(:routes_file_content) do
          raw = <<STRING
RailsTemplate::Application.routes.draw do
  resources :cats
end
STRING
        end

        it { should eq(false) }
      end
    end

    context "with namespaces" do
      let(:resource) { Frontier::Routes::Resource.new(model_configuration, [namespace]) }

      let(:namespace) { Frontier::Routes::Namespace.new(name, depth) }
      let(:name)  { "admin" }
      let(:depth) { 0 }

      context "when the resource exists with brackets" do
        let(:routes_file_content) do
          raw = <<STRING
RailsTemplate::Application.routes.draw do
  namespace(:admin) do
    resources(:users)
  end
end
STRING
        end

        it { should eq(true) }
      end

      context "when the resource exists WITHOUT brackets" do
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

      context "when the resource doesn't exist" do
        let(:routes_file_content) do
          raw = <<STRING
RailsTemplate::Application.routes.draw do
  namespace :dongle do
    resources :cats
  end
end
STRING
        end

        it { should eq(false) }
      end
    end
  end

  describe "#route_string" do
    subject { resource.route_string }
    let(:resource) { Frontier::Routes::Resource.new(model_configuration, [namespace]) }
    let(:model_configuration) { Frontier::ModelConfiguration.new({"user" => {}}) }

    let(:namespace) { Frontier::Routes::Namespace.new(name, depth) }
    let(:name)  { "admin" }
    let(:depth) { 0 }

    it { should eq("    resources :users") }
  end

end
