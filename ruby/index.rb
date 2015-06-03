require 'rubygems'
require 'sinatra/base'
require 'sinatra/config_file'
require 'mongo'
require 'json'
require 'pr_geohash'
require 'newrelic_rpm'

include Mongo

class MyApp < Sinatra::Base
  register Sinatra::ConfigFile

  helpers do
    def parsed_body
      JSON.parse(request.env['rack.input'].read)
    end
  end

  configure do
    config_file 'config.yml'

    connection = MongoClient.new(settings.mongodb['host'], settings.mongodb['port'])
    set :mongo_db, connection.db(settings.mongodb['database'])
    set :environment, :production
  end

  put '/taxi-position' do
    content_type :json
    json_request = parsed_body

    lat, long = json_request['lat'], json_request['long']

    criteria = {:_id => BSON::ObjectId.from_string('556018800640fd52df330d31')}
    geo_hash = GeoHash.encode(lat.to_f, long.to_f, 16)

    position_record = {'lat' => lat, 'long' => long, 'geohash' => geo_hash, 'updated' => Time.new }
    flags = {:upsert => true}
    settings.mongo_db[settings.mongodb['collection']].update(criteria, position_record, flags)

    status 204
  end
end
