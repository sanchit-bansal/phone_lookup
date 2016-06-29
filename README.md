## Spider Wasp JR

Spiderwasp is a great microservice, but because it's in Java, it increases the barrier to extending and properly testing it with tools we are familiar with, such as RSpec.

This is an experimental rewrite of spiderwasp using:

- JRuby to provide bindings to `libphonenumber`
- Sinatra (we can change it to anythin else, just something simple to start off)
- RSpec
- Trinidad for serving production requests
- Puma for development (for working with pry)
