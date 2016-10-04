require "rspec"
require "./graph/schema"

module Graph
  describe Schema do
    describe ".execute" do
      it "executes a valid GraphQL introspection query" do
        expect(
          Graph::Schema.execute(GraphQL::Introspection::INTROSPECTION_QUERY).fetch("data")
        ).to have_key("__schema")
      end
    end
  end
end
