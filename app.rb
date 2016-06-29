require "sinatra"
require "sinatra/json"

require "pry" if development?
require "sinatra/reloader" if development?

require "./services/phone_number_extractor"

post "/matches" do
  json(PhoneNumberExtractor.matches(params[:text]).map(&:to_h))
end
