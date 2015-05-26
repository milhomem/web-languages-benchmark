#!/usr/bin/env python
from flask import Flask, request
from flask.ext.mongoengine import MongoEngine
from mongoengine import *
from bson.objectid import ObjectId
import os, yaml

configFile = os.path.join(os.getcwd(), 'config.yml')
with open(configFile, 'r') as ymlfile:
        config = yaml.load(ymlfile)

app = Flask(__name__)
app.config["MONGODB_SETTINGS"] = {
        'DB': config['mongodb']['database'],
        'HOST': config['mongodb']['host'],
        'PORT': config['mongodb']['port'],
        'USERNAME': config['mongodb']['username'],
        'PASSWORD': config['mongodb']['password']
}
db = MongoEngine(app)

class Position(DynamicDocument):
        lat = FloatField(required=True)
        long = FloatField(required=True)
        meta = {'collection': config['mongodb']['collection']}

@app.route("/taxi-position", methods=['PUT'])
def position_update():
        jsonRequest = request.json

        Position(
                id=ObjectId('556018800640fd52df330d31'),
                lat=jsonRequest['lat'],
                long=jsonRequest['long']
        ).save()

        return ('', 204)
