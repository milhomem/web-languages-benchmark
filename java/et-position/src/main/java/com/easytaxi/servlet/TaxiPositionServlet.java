package com.easytaxi.servlet;
 
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.bson.BSONObject;
import org.bson.BsonArray;
import org.bson.Document;
import org.bson.conversions.Bson;
import org.bson.types.ObjectId;
import org.json.JSONException;
import org.json.JSONObject;

import com.mongodb.BasicDBObject;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.UpdateOptions;
import com.easytaxi.MongoRepository;
import ch.hsr.geohash.GeoHash;
 
public class TaxiPositionServlet extends HttpServlet
{
    protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
    	String jsonString = IOUtils.toString(request.getInputStream());
    	
    	try {
    		JSONObject json = new JSONObject(jsonString);	

        	double latitude = json.getDouble("lat");
        	double longitude = json.getDouble("long");
       	
        	GeoHash geohash = GeoHash.withCharacterPrecision(latitude, longitude, 16);

        	MongoDatabase db = MongoRepository.getInstance();
        	
        	BasicDBObject criteria = new BasicDBObject();
        	criteria.put("_id", new ObjectId("556018800640fd52df330d31"));
        	
        	Document update = new Document();
        	update.put("lat", latitude);
        	update.put("long", longitude);
        	update.put("geohash", geohash.toBase32());
        	
        	UpdateOptions options = new UpdateOptions();
        	options.upsert(true);
        	db.getCollection("positions").updateOne(criteria, new Document("$set", update), options);
        	
            response.setStatus(HttpServletResponse.SC_NO_CONTENT);	
    	} catch (JSONException je) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
    	}	
    }
}