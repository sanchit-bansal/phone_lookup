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

  describe '#parse' do
    let(:valid_numbers) do
      {
        uk_number:      "+44 7 907709720",
        us_number:      "+1 971 344 8692",
        china_number:   "+86 1380 173 1778",
        hk_number:      "+852 6938 9820",
        germany_number: "+49 160 2879 563",
        uae_number:     "+971 4 360 2121",
        russia_number:  "+7 701 736 2612",
        indian_number:  "+91 9158 8851 81" # Reported by James Lewek
      }
    end

    let(:invalid_numbers) do
      {
        us_number: "+1 777 777 777"
      }
    end

    context "given a set of correctly formatted phone numbers from major countries" do
      it 'returns true' do
        valid_numbers.values.each do |number|
          number = service.parse(number)
          expect(number.valid?).to eq(true)
        end
      end
    end

    context "given a set of incorrectly formatted phone numbers" do
      it 'returns false' do
        invalid_numbers.values.each do |number|
          invalid_number = service.parse(number)
          expect(invalid_number.valid?).to eq(false)
        end
      end
    end

    context "given a string that is not a number" do
      it "returns nil" do
        expect(service.parse("thisisnotaphonenumber")).to be_nil
      end
    end
  end
end
