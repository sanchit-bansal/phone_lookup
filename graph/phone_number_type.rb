require "graphql/object_type"

module Graph
  PhoneNumberType = GraphQL::ObjectType.define do
    name "PhoneNumber"
    description "An E164 validated phone number"

    field :e164_format, !types.String, "Internationally recognized E164 format, no whitespaces. Example: +19179032036"

    field :international_format, !types.String, "The colloquial country format. Example: +1 917 903 2036"

    field :number_type, !types.String, "Mobile, landline etc"

    field :carrier, !types.String, <<~TEXT
      Offline attempt to identify the carrier.

      This seems to work well except for numbers that have been ported to other carriers.
    TEXT
  end
end
