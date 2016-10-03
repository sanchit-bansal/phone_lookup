require "java"
require "./jars/libphonenumber-7.4.3.jar"

require "./models/phone_number_wrapper"

java_import com.google.i18n.phonenumbers.PhoneNumberUtil

class PhoneNumberExtractor
  def self.matches(text)
    phone_util.find_numbers(text, nil).map do |number|
      PhoneNumberWrapper.new(number)
    end
  end

  def self.parse(number, region = "US")
    phone_util.parse(number, region)
  end

  def self.phone_util
    @phone_util ||= PhoneNumberUtil.get_instance
  end
  private_class_method :phone_util
end
