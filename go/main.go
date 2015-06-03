package main

import (
    "encoding/json"
    "log"
    "io/ioutil"
    "path/filepath"
    "fmt"
    "time"
    "github.com/gnagel/go-geohash/ggeohash"
    "github.com/smallfish/simpleyaml"
    "gopkg.in/mgo.v2"
    "gopkg.in/mgo.v2/bson"
    "github.com/hoisie/web"
    "runtime"
)

type TaxiPosition struct {
    Lat float64 `json:"lat"`
    Long float64 `json:"long"`
    Geohash string
    Updated time.Time
}

var MongoConnection struct {
    collection *mgo.Collection
    session *mgo.Session
}

func getConfiguration(configPath string) (string, int, string, string) {
    file, _ := filepath.Abs(configPath)
    configYaml, _ := ioutil.ReadFile(file)
    config, _ := simpleyaml.NewYaml(configYaml)

    dbHost, _ := config.Get("mongodb").Get("host").String();
    dbPort, _ := config.Get("mongodb").Get("port").Int();
    dbName, _ := config.Get("mongodb").Get("database").String();
    dbCollection, _ := config.Get("mongodb").Get("collection").String();

    return dbHost, dbPort, dbName, dbCollection
}

func putTaxiPosition(ctx *web.Context) string {
    body, _ := ioutil.ReadAll(ctx.Request.Body)
    taxiPosition := &TaxiPosition{}
    json.Unmarshal(body, &taxiPosition)

    taxiPosition.Geohash = ggeohash.Encode(taxiPosition.Lat, taxiPosition.Long, 9)
    taxiPosition.Updated = time.Now()

    _, err := MongoConnection.collection.UpsertId(bson.ObjectIdHex("556018800640fd52df330d31"), taxiPosition)
    if err != nil {
        log.Fatal(err)
    }

    ctx.WriteHeader(204)

    return "{}"
}

func getMongoCollection() (*mgo.Collection, *mgo.Session) {
    dbHost, dbPort, dbName, dbCollection := getConfiguration("config.yml")
    session, err := mgo.Dial(fmt.Sprintf("mongodb://%v:%v", dbHost, dbPort))
    if err != nil {
        log.Fatal(err)
    }
    collection := session.DB(dbName).C(dbCollection)

    return collection, session
}

func main() {
    collection, session := getMongoCollection()
    MongoConnection.collection = collection
    MongoConnection.session = session

    runtime.GOMAXPROCS(runtime.NumCPU())
    web.Put("/taxi-position", putTaxiPosition)
    web.RunFcgi("0.0.0.0:9006")
}
