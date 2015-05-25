# NodeJS server

## Dependencies
* NodeJS v0.10.38+
* PM2 v0.12.15+
* NoSQL Database MongoDB 2.4+
* Nginx 1.4.6+
* Restify Framework

## Installing and configuring
```bash
npm install pm2 -g
npm install -d
ln -s /path/to/nginx.conf /etc/nginx/sites-enabled/benchmark.conf
/etc/init.d/nginx restart
```

## Start the server
```bash
pm2 delete index; pm2 start index.js --instances 8
```

## Testing
```bash
curl 192.168.33.10:8080/taxi-position --request PUT -d '{"lat": -19.432608, "long": -99.133208}' -H 'Accept: application/json' -H 'Content-type: application/json'
```

## Stop the server
```bash
pm2 stop index
```

## References
* http://mcavage.me/node-restify/#server-api
* https://github.com/kissjs/node-mongoskin
* https://www.digitalocean.com/community/tutorials/how-to-set-up-a-node-js-application-for-production-on-ubuntu-14-04