require "rails_helper"

RSpec.describe "campus routes" do
  let(:campus_ids) { %w(UMNTC UMNCR UMNRO UMNMO UMNDL) }

  describe "/campuses" do
    it "uses JSON API" do
      get "/campuses"
      expect(response.content_type).to eq("application/vnd.api+json")
    end
  end

  describe "/campuses/:campus_id" do
    it "uses JSON API" do
      get "/campuses/#{campus_ids.sample}"
      expect(response.content_type).to eq("application/vnd.api+json")
    end
  end

  describe "/campuses/:campus_id?include=terms" do
    it "sideloads in term data" do
      get "/campuses/#{campus_ids.sample}?include=terms"
      expect(response.content_type).to eq("application/vnd.api+json")
    end
  end
end
