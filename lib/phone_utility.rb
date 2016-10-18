require "./jars/libphonenumber-7.4.3.jar"
java_import com.google.i18n.phonenumbers.PhoneNumberUtil

class PhoneUtility
  INSTANCE = PhoneNumberUtil.get_instance

  FORMATS = {
    e164: PhoneNumberUtil::PhoneNumberFormat::E164,
    international: PhoneNumberUtil::PhoneNumberFormat::INTERNATIONAL,
    national: PhoneNumberUtil::PhoneNumberFormat::NATIONAL
  }.freeze

  def self.instance
    INSTANCE
  end

  def self.parse(number, region)
    instance.parse(number, region)
  end

  def self.find_numbers(text, default_region)
    instance.find_numbers(text, default_region)
  end

  def self.valid?(number)
    instance.is_valid_number(number)
  end

  def self.number_type(number)
    instance.get_number_type(number).to_string
  end

  def self.format(number, format)
    instance.format(number, FORMATS[format.to_sym])
  end
end
