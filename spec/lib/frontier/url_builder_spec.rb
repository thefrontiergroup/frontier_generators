require 'spec_helper'

describe Frontier::UrlBuilder do

  let(:url_builder) { Frontier::UrlBuilder.new(model_configuration) }
  let(:model_configuration) do
    Frontier::ModelConfiguration.new({
      "user" => {controller_prefixes: controller_prefixes}
    })
  end

  def self.expect_route(path_method, to_eq:)
    specify { expect(url_builder.public_send(path_method)).to eq(to_eq) }
  end

  describe "model with no namespaces or nested models" do
    let(:controller_prefixes) { nil }

    expect_route(:index_path,  to_eq: "users_path")
    expect_route(:new_path,    to_eq: "new_user_path")
    expect_route(:edit_path,   to_eq: "edit_user_path(user)")
    expect_route(:delete_path, to_eq: "user_path(user)")
  end

  describe "model with a namespace" do
    let(:controller_prefixes) { ["admin"] }

    expect_route(:index_path,  to_eq: "admin_users_path")
    expect_route(:new_path,    to_eq: "new_admin_user_path")
    expect_route(:edit_path,   to_eq: "edit_admin_user_path(user)")
    expect_route(:delete_path, to_eq: "admin_user_path(user)")
  end

  describe "model with a nested model" do
    let(:controller_prefixes) { ["@client"] }

    expect_route(:index_path,  to_eq: "client_users_path(@client)")
    expect_route(:new_path,    to_eq: "new_client_user_path(@client)")
    expect_route(:edit_path,   to_eq: "edit_client_user_path(@client, user)")
    expect_route(:delete_path, to_eq: "client_user_path(@client, user)")
  end

  describe "model with a namespace and nested model" do
    let(:controller_prefixes) { ["admin", "@client"] }

    expect_route(:index_path,  to_eq: "admin_client_users_path(@client)")
    expect_route(:new_path,    to_eq: "new_admin_client_user_path(@client)")
    expect_route(:edit_path,   to_eq: "edit_admin_client_user_path(@client, user)")
    expect_route(:delete_path, to_eq: "admin_client_user_path(@client, user)")
  end

  describe "model with a nested model and a namespace" do
    let(:controller_prefixes) { ["@client", "admin"] }

    expect_route(:index_path,  to_eq: "client_admin_users_path(@client)")
    expect_route(:new_path,    to_eq: "new_client_admin_user_path(@client)")
    expect_route(:edit_path,   to_eq: "edit_client_admin_user_path(@client, user)")
    expect_route(:delete_path, to_eq: "client_admin_user_path(@client, user)")
  end

  describe "model with multiple nested model" do
    let(:controller_prefixes) { ["@client", "@doge"] }

    expect_route(:index_path,  to_eq: "client_doge_users_path(@client, @doge)")
    expect_route(:new_path,    to_eq: "new_client_doge_user_path(@client, @doge)")
    expect_route(:edit_path,   to_eq: "edit_client_doge_user_path(@client, @doge, user)")
    expect_route(:delete_path, to_eq: "client_doge_user_path(@client, @doge, user)")
  end

end
