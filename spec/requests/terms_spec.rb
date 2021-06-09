require "rails_helper"

RSpec.describe "term routes" do
  let(:term_id) { Term.pluck(:id).sample }

  describe "/terms/:term_id" do
    it "uses JSON API" do
      get "/terms/#{term_id}"
      expect(response.content_type).to eq("application/vnd.api+json")
    end
  end
end
