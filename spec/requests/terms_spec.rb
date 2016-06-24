require "rails_helper"

RSpec.describe "term routes" do
  let(:term_id) { Term.pluck(:id).sample }

  describe "/terms/:term_id/subjects" do
    it "uses JSON API" do
      get "/terms/#{term_id}/subjects"
      expect(response.content_type).to eq("application/vnd.api+json")
    end
  end
end
