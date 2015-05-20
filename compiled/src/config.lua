local config = require("lapis.config")
config("development", function()
  port(8081)
  redis({
    host = "127.0.0.1",
    port = 6379
  })
  return postgres(function()
    host("127.0.0.1")
    user("bomboze")
    password("")
    return database("italian")
  end)
end)
return config("production", function()
  port(8081)
  num_workers(30)
  code_cache("on")
  redis({
    host = "127.0.0.1",
    port = 6379
  })
  return postgres(function()
    host("127.0.0.1")
    user("bomboze")
    password("")
    return database("italian")
  end)
end)
