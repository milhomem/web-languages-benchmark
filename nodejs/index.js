var path = require('path'),
  fs = require('fs'),
  yaml = require('js-yaml'),
  config = yaml.load(fs.readFileSync(path.join(__dirname, 'config.yml'), 'utf8')),
  restify = require('restify'),
  mongo = require('mongoskin'),
  Server = mongo.Server,
  Db = mongo.Db,
  ObjectID = mongo.ObjectID;

var server = restify.createServer();
server.use(restify.bodyParser());

var mongoServer = new Server(config.mongodb.host, config.mongodb.port);
var db = new Db(config.mongodb.database, mongoServer, {w: 1});
//MongoSkin does not support db.authenticate(config.mongodb.username, config.mongodb.password);

server.put('/taxi-position', function respond(req, res, next) {
  var lat = req.body.lat
  var long = req.body.long

  var collection = db.collection(config.mongodb.collection);
  var criteria = {'_id': new ObjectID('556018800640fd52df330d31')};
  var positionRecord = {'lat': lat, 'long': long};
  var flags = {'upsert': true};
  collection.update(criteria, positionRecord, flags, function(err, myCollection) {
      if (err) console.log(err);
  });

  res.send(204)

  next();
});

server.listen(config.proxy.listen, function() {
  console.log('%s listening at %s', server.name, server.url);
});
