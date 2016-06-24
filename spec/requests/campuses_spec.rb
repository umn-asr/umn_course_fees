require "rails_helper"

RSpec.describe "campus routes" do
  let(:campus_ids) { %w(UMNTC UMNCR UMNRO UMNMO UMNDL) }
  let(:small_campus_id) { "UMNCR" }

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

  describe "/campuses/:campus_id/terms" do
    it "uses JSON API" do
      get "/campuses/#{campus_ids.sample}/terms"
      expect(response.content_type).to eq("application/vnd.api+json")
    end
  end

  describe "/campuses/:campus_id?include=terms" do
    it "sideloads in term data" do
      get "/campuses/#{small_campus_id}?include=terms"
      expect(response.content_type).to eq("application/vnd.api+json")
    end
  end

  describe "/campuses/:campus_id?include=terms.subjects" do
    it "sideloads in term and subject data" do
      get "/campuses/#{small_campus_id}?include=terms.subjects"
      expect(response.content_type).to eq("application/vnd.api+json")
    end
  end

  describe "/campuses/:campus_id?include=terms.subjects.courses" do
    it "sideloads in term, subject and course data" do
      get "/campuses/#{small_campus_id}?include=terms.subjects.courses"
      expect(response.content_type).to eq("application/vnd.api+json")
    end
  end
end
