## PhoneLookup JR

PhoneLookup is a great microservice, but because it's in Java, it increases the barrier to extending and properly testing it with tools we are familiar with, such as RSpec.

This is an experimental rewrite of spiderwasp using:

- JRuby to provide bindings to `libphonenumber`
- Sinatra (we can change it to anythin else, just something simple to start off)
- RSpec
- Puma for development (for working with pry)

## Using PhoneLookup

To run PhoneLookup locally:
1. Run the server with the following command: `ruby app.rb`. Make a note of the port the server is running on (example localhost:4567)
2. Use a REST Client like [Postman](https://www.getpostman.com/) to hit the PhoneLookup API.
3. Make a POST request in the REST Client to the graph endpoint `localhost:4567/graph` or to the respective port PhoneLookup is running on.

An example of a POST request body:
```
{
    "query": "query($text: String!, $region: String) { parse_phone_number(number: $text, region: $region) {e164_format valid country_code national_number}}",
    "variables": { "text": "+3392252520", "region": "US" }
}
```
which will respond with:

```
{
  "data": {
    "parse_phone_number": {
      "e164_format": "+13392252520",
      "valid": true,
      "country_code": "1",
      "national_number": "3392252520"
    }
  }
}
```
## Running Tests

The testing tool used is [RSpec](http://rspec.info/documentation/)
Run all tests using the command `bundle exec rspec spec`
