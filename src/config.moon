config = require "lapis.config"

config "development", ->
  port 8081
  redis {
    host: "127.0.0.1"
    port: 6379
  }
  postgres ->
    host "127.0.0.1"
    user "bomboze"
    password ""
    database "italian"

config "production", ->
  port 8081
  num_workers 30
  code_cache "on"
  redis {
    host: "127.0.0.1"
    port: 6379
  }
  postgres ->
    host "127.0.0.1"
    user "bomboze"
    password ""
    database "italian"
