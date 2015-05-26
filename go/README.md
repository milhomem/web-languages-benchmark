Go API
---

### Install Go Glide package manager and Mercurial

#### Debian
* sudo apt-get install golang-go
* git clone https://github.com/Masterminds/glide /opt/glide && cd /opt/glide && make bootstrap && cd -
* /opt/glide/glide in
* /opt/glide/glide install

#### OSX
* brew install go hg glide
* cd web-languages-benchmark/go
* glide in
* glide install

### Run Go Server (build binary and run server)
* go build -o bin/main
* ./bin/main &

### Make a test call using cUrl
curl localhost:8086/taxi-position --request PUT -d '{"lat": -19.432608, "long": -99.133208}' -H 'Accept: application/json' -H 'Content-type: application/json'

### Reference
* https://gobyexample.com/multiple-return-values
* https://github.com/smallfish/simpleyaml
* http://labix.org/mgo
* http://webgo.io/
* http://stackoverflow.com/questions/21014073/sending-json-in-post-request-to-web-api-written-in-web-go-framework
* https://github.com/Masterminds/glide
