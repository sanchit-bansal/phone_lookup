require "pry"
require "sinatra"
require "sinatra/json"

require "./services/phone_number_extractor"
require "sinatra/reloader" if development?

post "/matches" do
  json(
    PhoneNumberExtractor.new(params[:text])
      .matches
      .map(&:to_h)
  )
end
