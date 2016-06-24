require "rails_helper"

RSpec.describe "term routes" do
  let(:campus_ids) { %w(UMNTC UMNCR UMNRO UMNMO UMNDL) }
  describe "/campuses/:campus_id/terms" do
    it "uses JSON API" do
      get "/campuses/#{campus_ids.sample}/terms"
      expect(response.content_type).to eq("application/vnd.api+json")
    end
  end
end
