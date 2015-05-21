### Development

Install OpenResty, lua, luarocks

```sh
sudo apt-get install build-essential libreadline-dev libncurses5-dev libpcre3-dev libssl-dev perl make
wget http://openresty.org/download/ngx_openresty-1.7.10.1.tar.gz
tar xzvf ngx_openresty-1.7.10.1.tar.gz
cd ngx_openresty-1.7.10.1/
./configure -j4 --with-pcre-jit --with-ipv6
make -j4
sudo make install
```

Once:

```sh
sudo apt-get install luarocks luajit
sudo luarocks install lapis

sudo apt-get install git-core
git clone https://github.com/slava-vishnyakov/lapis-example.git

cd openresty-example
git submodule init
git submodule update

echo http://$(wget -qO - http://api.ipify.org):8081/http_request
lapis server development

# org
lapis server production 2>/dev/null
```

Development:

```sh
moonc -w src/ -t compiled/
lapis server development
```

### Sources

Editable sources are in `src/`

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

ab -k -c 5 -n 1000 http://localhost:8081/local_counter
> Requests per second:    6954.15 [#/sec] (mean)
> 50%      1
> 99%      1

ab -k -c 100 -n 100 http://localhost:8081/http_request
> Requests per second:    239.13 [#/sec] (mean) # зависит от скорости ответа httpbin.org

curl -XPOST -d'{"test":1}' -H 'Content-Type: application/json' http://localhost:8081/post
> {"value_in_test":1}
```

### GUI

Atom editor + language-moonscript
`apm install language-moonscript`

#### For Mac OS X

```sh
brew install pcre
./configure \
             --with-cc-opt="-I/usr/local/include" \
             --with-ld-opt="-L/usr/local/lib" \
             -j4
make -j4
sudo make install
```
