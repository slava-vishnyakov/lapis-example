package.path = package.path .. ";vendor/lua-resty-http-simple/lib/?.lua"
package.path = package.path .. ";vendor/lapis-redis/?.lua"
local json_params
json_params = require("lapis.application").json_params
local get_redis
get_redis = require("lapis.redis").get_redis
local lapis = require("lapis")
local util = require("lapis.util")
local http = require("resty.http.simple")
local local_counter = 0
local Model
Model = require("lapis.db.model").Model
local Lines
do
  local _parent_0 = Model
  local _base_0 = { }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  local _class_0 = setmetatable({
    __init = function(self, ...)
      return _parent_0.__init(self, ...)
    end,
    __base = _base_0,
    __name = "Lines",
    __parent = _parent_0
  }, {
    __index = function(cls, name)
      local val = rawget(_base_0, name)
      if val == nil then
        return _parent_0[name]
      else
        return val
      end
    end,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  if _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  Lines = _class_0
end
local db = require("lapis.db")
local App
do
  local _parent_0 = lapis.Application
  local _base_0 = {
    ["/http_request"] = function(self)
      local res, err = http.request("httpbin.org", 80, {
        ['path'] = '/ip'
      })
      return {
        json = tostring(util.from_json(res.body).origin)
      }
    end,
    ["/post"] = json_params(function(self)
      return {
        json = {
          value_in_test = self.params.test
        }
      }
    end),
    ["/redis_counter"] = function(self)
      local redis = get_redis()
      local counter = redis:incr("counter")
      return {
        json = counter
      }
    end,
    ["/postgresql"] = function(self)
      local line = db.select("* from lines where id = ?", 1574489)
      return {
        json = line
      }
    end,
    ["/postgresql/model"] = function(self)
      local line = Lines:find(1574489)
      return {
        json = line
      }
    end,
    ["/local_counter"] = function(self)
      local_counter = local_counter + 1
      return {
        json = {
          local_counter = local_counter,
          note = "Works correctly only in production mode"
        }
      }
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  local _class_0 = setmetatable({
    __init = function(self, ...)
      return _parent_0.__init(self, ...)
    end,
    __base = _base_0,
    __name = "App",
    __parent = _parent_0
  }, {
    __index = function(cls, name)
      local val = rawget(_base_0, name)
      if val == nil then
        return _parent_0[name]
      else
        return val
      end
    end,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  if _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  App = _class_0
  return _class_0
end
