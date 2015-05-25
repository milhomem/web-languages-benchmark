# Ruby server

## Dependencies
* Ruby 2.2.1
* Puma
* NoSQL Database MongoDB 2.4+
* Nginx 1.4.6+
* Sinatra Framework

## Installing and configuring
```bash
gem install bundler
bundle install
ln -s nginx.conf /etc/nginx/sites-enabled/benchmark.conf
/etc/init.d/nginx restart
```

## Start puma server
```bash
puma -C puma.rb
```

## Start unicorn server
```bash
unicorn -c unicorn.rb -E deployment
```

## Testing
```bash
curl localhost:8080/taxi-position --request PUT -d '{"lat": -19.432608, "long": -99.133208}' -H 'Accept: application/json' -H 'Content-type: application/json'
```

## Stop the server
```bash
cat /var/run/unicorn.pid | xargs kill -QUIT
```

## References
* http://recipes.sinatrarb.com/p/deployment/nginx_proxied_to_unicorn#label-The+Example+Application
* http://bundler.io/
* http://www.sinatrarb.com/
* http://recipes.sinatrarb.com/p/databases/mongo
