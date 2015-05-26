# Perl server

## Dependencies
* Perl v5.10+
* NoSQL Database MongoDB 2.4+
* Nginx 1.4.6+
* Mojolicious Framework

## Installing and configuring
```bash
apt-get install carton
carton install --deployment
ln -s $PWD/nginx.conf /etc/nginx/sites-enabled/perl.conf
/etc/init.d/nginx restart
```

## Start the server
```bash
carton exec hypnotoad ./index.pl
```

## Testing
```bash
curl localhost:8083/taxi-position --request PUT -d '{"lat": -19.432608, "long": -99.133208}' -H 'Accept: application/json' -H 'Content-type: application/json'
```

## Stop the server
```bash
carton exec hypnotoad ./index.pl --stop
```

## References
* http://search.cpan.org/~miyagawa/Carton-v1.0.21/lib/Carton.pm
* http://www.slideshare.net/friedo/building-a-mongodb-app-with-perl
* http://mojolicio.us/perldoc/Mojolicious/Guides/Cookbook#Nginx
