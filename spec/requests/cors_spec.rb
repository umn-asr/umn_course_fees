require "rails_helper"

RSpec.describe "CORS headers", type: :request do
  it "returns Access-Control-Allow-Origin header" do
    origin = "http://example.com"

    get "/campuses", headers: {"Origin": origin}
    expect(response.headers["Access-Control-Allow-Origin"]).to eq("*")
    expect(response.headers["Access-Control-Allow-Methods"]).to eq("GET")
  end
end
