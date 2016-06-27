require "java"
require "./jars/libphonenumber-7.4.3.jar"

java_import com.google.i18n.phonenumbers.PhoneNumberUtil

class PhoneNumberWrapper
  # Wrapper for the weirdness of using the Java libphonenumber library
  def initialize(match)
    @match = match
  end

  def to_h
    {
      international_format: international_format,
      e164_format: e164_format,
      number_type: number_type
    }
  end

  def e164_format
    @e164_format ||= phone_util.format(match.number, PhoneNumberUtil::PhoneNumberFormat::E164)
  end

  def international_format
    @international_format ||= phone_util.format(match.number, PhoneNumberUtil::PhoneNumberFormat::INTERNATIONAL)
  end

  def number_type
    @number_type||= phone_util.getNumberType(match.number).toString
  end

private
  attr_reader :match

  def phone_util
    # Java class
    @phone_util ||= PhoneNumberUtil.getInstance()
  end
end
