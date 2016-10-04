require "./spec/spec_helper"

RSpec.describe "Posting to the GraphQL endpoint", type: :request do
  it "matches valid phone numbers" do
    query = <<~GQL
      query($text: String!) {
        phone_number_matches(text: $text) {
          e164_format
          number_type
          carrier
          international_format
        }
      }
    GQL

    post "/graph", { query: query, variables: { text: "My number is +65 81234805" } }.to_json, { "Content-Type" => "application/json" }

    matches = JSON.parse(last_response.body).dig("data", "phone_number_matches")

    expect(matches.first).to eq({
      "e164_format" => "+6581234805",
      "number_type" => "MOBILE",
      "carrier" => "SingTel", # I am a M1 subscriber actually
      "international_format" => "+65 8123 4805"
    })
  end
end
