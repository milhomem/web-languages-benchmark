require 'rubygems'
require 'sinatra/base'
require 'sinatra/config_file'
require 'mongo'
require 'json'

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
    jsonRequest = parsed_body

    criteria = {:_id => BSON::ObjectId.from_string('556018800640fd52df330d31')}
    positionRecord = {'lat' => jsonRequest['lat'], 'long' => jsonRequest['long']}
    flags = {:upsert => true}
    settings.mongo_db[settings.mongodb['collection']].update(criteria, positionRecord, flags)

    status 204
  end
end
