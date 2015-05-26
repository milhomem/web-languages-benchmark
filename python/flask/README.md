# Python server

## Dependencies
* Python 2.7.6+
* uWSGI 2.0.10+
* NoSQL Database MongoDB 2.4+
* Nginx 1.4.6+
* Flask Framework

## Installing and configuring
```bash
curl --silent --show-error --retry 5 https://bootstrap.pypa.io/get-pip.py | sudo python2.7
apt-get install build-essential python python-dev
pip install virtualenv
virtualenv .
source bin/activate
pip install -r requirements.txt
ln -s $PWD/nginx.conf /etc/nginx/sites-enabled/python.conf
/etc/init.d/nginx restart
```

## Start the server
```bash
uwsgi --socket :9004 --wsgi-file index.py --callable app --master --processes 8 --threads 1 1>/var/log/uwsgi.log 2>&1 & echo $! > /var/run/uwsgi.pid
```

## Testing
```bash
curl localhost:8084/taxi-position --request PUT -d '{"lat": -19.432608, "long": -99.133208}' -H 'Accept: application/json' -H 'Content-type: application/json'
```

## Stop the server
```bash
cat /var/run/uwsgi.pid | xargs kill -QUIT
```

## References
* http://search.cpan.org/~miyagawa/Carton-v1.0.21/lib/Carton.pm
* http://www.slideshare.net/friedo/building-a-mongodb-app-with-perl
* http://mojolicio.us/perldoc/Mojolicious/Guides/Cookbook#Nginx
