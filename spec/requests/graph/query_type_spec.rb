require "rspec"
require "./graph/schema"

describe Graph::QueryType do
  let(:query) { create(:query) }

  describe "parse_phone_number" do
    let(:parse_phone_number) { create(:parse_phone_number) }

    it "returns the valid parsed phone number" do
      query =  <<~QUERY
        query {
          parse_phone_number(number: "+1-339-225-2520", region: "US")
            {
               valid
            }
          }
      QUERY

      response = ::Graph::Schema.execute(query)
      result = response.fetch("data")

      expect(result["parse_phone_number"]["valid"]).to eq(true);
    end

    it "returns an invalid parsed phone number" do
      query =  <<~QUERY
        query {
          parse_phone_number(number: "+93-339-225-2520", region: "US")
            {
               valid
            }
          }
      QUERY

      response = ::Graph::Schema.execute(query)
      result = response.fetch("data")

      expect(result["parse_phone_number"]["valid"]).to eq(false);
    end

    it "returns the country code and valid formats of a parsed phone number" do
      query =  <<~QUERY
        query {
          parse_phone_number(number: "+1-339-225-2520", region: "US")
            {
               country_code
               e164_format
               international_format
               national_format
               national_number
            }
          }
      QUERY

      response = ::Graph::Schema.execute(query)
      result = response.fetch("data")

      expect(result["parse_phone_number"]).to eql(
        {
          "country_code"=>"1",
          "e164_format"=>"+13392252520",
          "international_format"=>"+1 339-225-2520",
          "national_format"=>"(339) 225-2520",
          "national_number"=>"3392252520"
        })
    end
  end
end
