-- Imports

package.path = package.path .. ";vendor/lua-resty-http-simple/lib/?.lua"
package.path = package.path .. ";vendor/lapis-redis/?.lua"
import json_params from require "lapis.application"
import get_redis from require "lapis.redis"

lapis = require "lapis"
util = require "lapis.util"
http = require "resty.http.simple"


-- Models

import Model from require "lapis.db.model"
class Lines extends Model

db = require "lapis.db"


-- Application

class App extends lapis.Application
  "/http_request": =>
    res, err = http.request("httpbin.org", 80, {'path':'/ip'})
    json: "#{util.from_json(res.body).origin}"


  -- curl -XPOST -d'{"test":1}' -H 'Content-Type: application/json' http://localhost:8081/post
  "/post": json_params =>
    json: "the value of param test = #{@params.test}"


  "/redis_counter": =>
    redis = get_redis!
    counter = redis\incr "counter"
    json: counter


  "/postgresql": =>
    line = db.select "* from lines where id = ?", 1574489
    json: line


  "/postgresql/model": =>
    line = Lines\find 1574489
    json: line
