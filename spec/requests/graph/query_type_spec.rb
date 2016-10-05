require "rspec"
require "./graph/schema"

describe Graph::QueryType do
  let(:query) { create(:query) }

  describe "parse_phone_number" do
    let(:parse_phone_number) { create(:parse_phone_number) }

    it "returns the valid parsed phone number" do
      query =  <<~QUERY
        query {
          parse_phone_number(number: "+1-339-225-2530", region: "US")
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
          parse_phone_number(number: "+93-339-225-2530", region: "US")
            {
               valid
            }
          }
      QUERY

      response = ::Graph::Schema.execute(query)
      result = response.fetch("data")

      expect(result["parse_phone_number"]["valid"]).to eq(false);
    end
  end
end
