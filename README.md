# Web Languages Benchmark

These benchmarks compare performance characteristics different web programming languages. Each benchmark includes a nearly identical implementation of the same program in each language. The objective of the program is:

* Process a JSON request parameter
* Access a MongoDB server and update one document
* Respond HTTP 204 No Content

I will use NewRelic to mensure reponse time and Bees With Machine Guns to attack the server runing a Debian XXX on an AWS EC2 c3.2xlarge.