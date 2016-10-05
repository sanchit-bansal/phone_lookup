require "java"
require "./jars/libphonenumber-7.4.3.jar"

require "./models/phone_number_wrapper"

java_import com.google.i18n.phonenumbers.PhoneNumberUtil

class PhoneNumberExtractor
  def self.matches(text)
    phone_util.find_numbers(text, nil).map do |match|
      PhoneNumberWrapper.new(match.number)
    end
  end

  def self.phone_util
    @phone_util ||= PhoneNumberUtil.get_instance
  end

  def self.parse(number, region = nil)
    match = phone_util.parse(number, region)
    match ? PhoneNumberWrapper.new(match) : nil
  end
  private_class_method :phone_util
end
