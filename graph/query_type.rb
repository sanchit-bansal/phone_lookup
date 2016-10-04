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
  end
end
