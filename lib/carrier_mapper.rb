require "./jars/prefixmapper-2.45.jar"
require "./jars/carrier-1.35.jar"

java_import com.google.i18n.phonenumbers.PhoneNumberToCarrierMapper
java_import java.util.Locale
java_import com.google.i18n.phonenumbers.prefixmapper.PrefixFileReader

class CarrierMapper
  INSTANCE = PhoneNumberToCarrierMapper.get_instance

  def self.instance
    INSTANCE
  end

  def self.name(number)
    name = instance.getNameForNumber(number, Locale::ENGLISH)
    name.empty? ? nil : name
  end
end
