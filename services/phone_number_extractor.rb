require "java"
require "./jars/libphonenumber-7.4.3.jar"

require "./models/phone_number"

java_import com.google.i18n.phonenumbers.PhoneNumberUtil

class PhoneNumberExtractor
  def initialize(text)
    @text = text
  end

  def matches
    results = []
    iterator = PhoneNumberUtil.getInstance.findNumbers(text, nil).iterator()

    while iterator.hasNext()
      results.push(
        PhoneNumberWrapper.new(iterator.next)
      )
    end

    results
  end

private
  attr_reader :text
end
