require "graphql/object_type"

require "./graph/phone_number_type.rb"
require "./services/phone_number_extractor.rb"

module Graph
  QueryType = GraphQL::ObjectType.define do
    name "Query"
    description "Query root of Spider Wasp"

    field :phone_number_matches do
      type types[PhoneNumberType]
      argument :text, !types.String

      resolve -> (object, arguments, context) do
        PhoneNumberExtractor.matches(arguments[:text])
      end
    end

    field :parse_phone_number do
      type PhoneNumberType
      argument :number, !types.String, "The phone number"
      argument :region, types.String, "Two digit ISO Alpha-2 region code"

      resolve -> (object, arguments, context) do
        PhoneNumberExtractor.parse(arguments[:number], arguments[:region])
      end
    end
  end
end
