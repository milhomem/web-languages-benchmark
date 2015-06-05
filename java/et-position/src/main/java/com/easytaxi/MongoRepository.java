package com.easytaxi;

import com.mongodb.MongoClient;
import com.mongodb.client.MongoDatabase;

public class MongoRepository {
	
	private static MongoDatabase mDb;
	
	public static MongoDatabase getInstance() {
		if (mDb != null) return mDb; 

		MongoClient mongoClient = new MongoClient( "localhost" , 27017 );
		mDb = mongoClient.getDatabase("etposition");
		
		return mDb;
	}
}