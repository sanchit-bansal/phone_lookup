require "graphql"

require "./graph/query_type"

module Graph
  Schema = GraphQL::Schema.define do
    query QueryType
    max_depth 3
  end
end
