# PHP server

## Dependencies
* PHP v5.5+
* PHP-FPM
* NoSQL Database MongoDB 2.4+
* Nginx 1.4.6+
* Silex Framework
* PHP extension ext-mongo

## Installing and configuring
```bash
curl -sS https://getcomposer.org/installer | php
composer install
ln -s $PWD/nginx.conf /etc/nginx/sites-enabled/php.conf
/etc/init.d/nginx restart
```

## Start the server
```bash
ln -s $PWD/php-fpm-pool.conf /etc/php5/fpm/pool.d/benchmark.conf
/etc/init.d/php5-fpm restart
```

## Testing
```bash
curl localhost:8082/taxi-position --request PUT -d '{"lat": -19.432608, "long": -99.133208}' -H 'Accept: application/json' -H 'Content-type: application/json'
```

## Stop the server
```bash
/etc/init.d/php5-fpm stop
```

## References
* http://www.if-not-true-then-false.com/2011/nginx-and-php-fpm-configuration-and-optimizing-tips-and-tricks/
* https://getcomposer.org/download/
* http://silex.sensiolabs.org/doc/intro.html
