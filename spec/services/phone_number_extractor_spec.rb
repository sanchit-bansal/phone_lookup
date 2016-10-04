require "rspec"
require "./services/phone_number_extractor"

describe PhoneNumberExtractor do
  let(:service) { described_class }

  describe "#matches" do
    it "matches phone numbers from text" do
      matches = service.matches("+65 8 1234805")

      singapore_number = matches.first

      expect(matches.size).to eq(1)
      expect(singapore_number.e164_format).to eq("+6581234805")
      expect(singapore_number.international_format).to eq("+65 8123 4805")
    end

    it "matches valid numbers in text passages" do
      contact_details = <<~contact_details
        Hello my name is elder Price and my number is +44 7 907 709 720 and +1 929 244 2432.

        Just for fun an invalid number => +65812348059.
      contact_details

      matches = service.matches(contact_details)

      expect(matches.map(&:e164_format)).to match_array(["+447907709720", "+19292442432"])
    end

    it "matches numbers in challenging formats" do
      number = service.matches("Hello + 6 5 8 1 2 3 4 8 0 5").first

      expect(number.e164_format).to eq("+6581234805")
    end
  end
end
