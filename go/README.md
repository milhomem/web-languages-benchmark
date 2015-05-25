Go API
---

## Install Go Glide package manager and Mercurial
* brew install hg glide
* glide in
* glide install

## Run Go Server
Build binary from source and run server
* go build -o bin/main
* ./bin/main

## Make a test call using cUrl
curl localhost:9000/taxi-position --request PUT --data '{"lat": -19.432608, "long": -99.133208}' -H 'Accept: application/json' -H 'Content-type: application/json'

### Reference
https://gobyexample.com/multiple-return-values
https://github.com/smallfish/simpleyaml
http://labix.org/mgo
http://webgo.io/
http://stackoverflow.com/questions/21014073/sending-json-in-post-request-to-web-api-written-in-web-go-framework