# Web Languages Benchmark

These benchmarks compare performance characteristics different web programming languages. Each benchmark includes a nearly identical implementation of the same program in each language. The objective of the program is:

* Read a YAML configuration file
* Process a JSON request parameter
* Calculate Geohash from Latitude and Longitude
* Access a MongoDB server and update one document
* Respond HTTP 204 No Content

I will use NewRelic to mensure reponse time and Bees With Machine Guns to attack the server runing a Debian XXX on an AWS EC2 c3.2xlarge. A MongoDB server hosted on another EC2 c3.2xlarge.

We must try to configure all webservers with only 8 processes and single tread to make things fare. 

First I do tests with different proxy servers the best recomandation for each language.
Later I do tests with the same proxy server uWSGI using plugins to see if make effect.

# References
* https://github.com/newsapps/beeswithmachineguns