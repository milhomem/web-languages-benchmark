require 'rubygems'
require 'sinatra/base'
require 'sinatra/config_file'
require 'mongo'
require 'multi_json'

include Mongo

class MyApp < Sinatra::Base

  register Sinatra::ConfigFile

  helpers do
    def parsed_body
      ::MultiJson.decode(request.body)
    end
    # a helper method to turn a string ID
    # representation into a BSON::ObjectId
    def object_id val
      BSON::ObjectId.from_string(val)
    end
  end

  configure do
    config_file '../config.yml'

    connection = MongoClient.new(settings.mongodb['host'], settings.mongodb['port'])
    set :mongo_connection, connection
    set :mongo_db, connection.db(settings.mongodb['database'])
  end

  put '/taxi-position' do
    content_type :json
    jsonRequest = parsed_body

    criteria = {:_id => object_id('556018800640fd52df330d31')}
    positionRecord = {'lat' => jsonRequest['lat'], 'long' => jsonRequest['long']}
    flags = {:upsert => true}
    settings.mongo_db[settings.mongodb['collection']].update(criteria, positionRecord, flags)

    status 204
  end

end
