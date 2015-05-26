# Erlang server

## Dependencies
* Erlang/OTP 17
* NoSQL Database MongoDB 2.4+
* Nginx 1.4.6+
* Chicagoboss Framework

## Installing and configuring
```bash
./rebar get-deps
./rebar compile
./rebar boss c=test_functional
vi boss.config #Change mongodb configurations
ln -s $PWD/nginx.conf /etc/nginx/sites-enabled/erlang.conf
/etc/init.d/nginx restart
```

## Start the server
```bash
./init.sh start
```

## Testing
```bash
curl localhost:8085/taxi-position --request PUT -d '{"lat": -19.432608, "long": -99.133208}' -H 'Accept: application/json' -H 'Content-type: application/json'
```

## Stop the server
```bash
./init.sh stop
```

## References
* https://github.com/ChicagoBoss/ChicagoBoss/wiki/Quickstart
* https://github.com/yakaz/yamerl
* http://chicagoboss.org/doc/api-controller.html
* http://chicagoboss.org/doc/api-record.html
* http://stackoverflow.com/questions/2739384/decode-json-with-mochijson2-in-erlang
* https://github.com/ChicagoBoss/ChicagoBoss/wiki/Deploy
