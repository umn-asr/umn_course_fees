require "rails_helper"

RSpec.describe "course routes" do
  let(:course_id) { Course.pluck(:id).sample }

  describe "/courses/:id" do
    it "uses JSON API" do
      get "/courses/#{course_id}"
      expect(response.content_type).to eq("application/vnd.api+json")
    end

    it "returns a course object with the expected json structure" do
      get "/courses/#{course_id}"

      json = JSON.parse(response.body)

      expect(json["data"].keys).to match_array(%w[id type links attributes])
      expect(json["data"]["attributes"].keys).to match_array(%w[class-name catalog-number subject fees term])
      expect(json["data"]["attributes"]["subject"].keys).to match_array(%w[id term_id abbreviation name])
      expect(json["data"]["attributes"]["fees"].sample.keys).to match_array(%w[id course_id amount fee_type fee_description section])
      expect(json["data"]["attributes"]["term"].keys).to match_array(%w[id campus_id strm name begin_date end_date current_term])
    end
  end
end
