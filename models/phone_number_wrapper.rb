require "./lib/phone_utility"
require "./lib/carrier_mapper"

class PhoneNumberWrapper
  def initialize(number, phone_util: PhoneUtility, carrier_mapper: CarrierMapper)
    @number = number
    @phone_util = phone_util
    @carrier_mapper = carrier_mapper
  end

  def to_h
    {
      international_format: international_format,
      e164_format: e164_format,
      number_type: number_type,
      carrier: carrier,
      valid: valid?
    }
  end

  def carrier
    @carrier ||= begin
      carrier_mapper.name(number)
    end
  end

  def e164_format
    @e164_format ||= phone_util.format(number, :e164)
  end

  def international_format
    @international_format ||= phone_util.format(number, :international)
  end

  def valid?
    phone_util.valid?(number)
  end

  def number_type
    @number_type ||= phone_util.number_type(number)
  end

private
  attr_reader :number, :phone_util, :carrier_mapper
end
