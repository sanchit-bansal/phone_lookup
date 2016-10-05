ENV['RACK_ENV'] ||= 'development'

require 'bundler'
Bundler.require :default, ENV['RACK_ENV'].to_sym

require "./graph/schema"
require "sinatra/json"
require "sinatra/reloader" if development?

post "/graph" do
  payload = JSON.parse(request.body.read)

  json(Graph::Schema.execute(payload["query"], variables: payload["variables"] || {}))
end
