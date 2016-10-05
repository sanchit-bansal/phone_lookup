require "java"
require "./jars/libphonenumber-7.4.3.jar"
require "./jars/prefixmapper-2.45.jar"
require "./jars/carrier-1.35.jar"

java_import java.util.Locale
java_import com.google.i18n.phonenumbers.prefixmapper.PrefixFileReader
java_import com.google.i18n.phonenumbers.PhoneNumberUtil
java_import com.google.i18n.phonenumbers.PhoneNumberToCarrierMapper

class PhoneNumberWrapper
  # Wrapper for the weirdness of using the Java libphonenumber library
  def initialize(number)
    @number = number
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
      name = carrier_mapper.getNameForNumber(number, Locale::ENGLISH)
      name.empty? ? nil : name
    end
  end

  def e164_format
    @e164_format ||= phone_util.format(number, PhoneNumberUtil::PhoneNumberFormat::E164)
  end

  def international_format
    @international_format ||= phone_util.format(number, PhoneNumberUtil::PhoneNumberFormat::INTERNATIONAL)
  end

  def valid?
    phone_util.isValidNumber(number)
  end

  def number_type
    @number_type ||= phone_util.getNumberType(number).to_string
  end

private
  attr_reader :number

  def carrier_mapper
    # Java class
    @carrier_mapper||= PhoneNumberToCarrierMapper.get_instance
  end

  def phone_util
    # Java class
    @phone_util ||= PhoneNumberUtil.get_instance
  end
end
