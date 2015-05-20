### Development

Install OpenResty, lua, luarocks

```sh
luarocks install lapis
moonc -w src/ -t compiled/
lapis server development
```

### GUI

Atom editor + language-moonscript
`apm install language-moonscript`

### Sources

Editable sources are in `src/`

### Checkout

```sh
git submodule init
git submodule update
```

### Benchmark

```sh
lapis server production 2>/dev/null
ab -k -c 2 -n 1000 http://localhost:8081/redis_counter

> Requests per second:    6400.61 [#/sec] (mean)
> 50%      0ms
> 99%      1ms

ab -k -c 2 -n 1000 http://localhost:8081/postgresql
> Requests per second:    3578.05 [#/sec] (mean)
> 50%      1
> 99%      1

ab -k -c 2 -n 1000 http://localhost:8081/postgresql/model
> Requests per second:    3172.43 [#/sec] (mean)
> 50%      1
> 99%      1

> ab -k -c 5 -n 1000 http://localhost:8081/local_counter
> Requests per second:    6954.15 [#/sec] (mean)
> 50%      1
> 99%      1

curl -XPOST -d'{"test":1}' -H 'Content-Type: application/json' http://localhost:8081/post
> {"value_in_test":1}
```
