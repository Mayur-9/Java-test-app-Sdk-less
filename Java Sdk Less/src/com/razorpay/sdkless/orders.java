
package com.razorpay.sdkless;

import org.json.JSONObject;
import okhttp3.Credentials;
import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.RequestBody;

public class orders {
	static String key = "";    //replace your merchant key
	static String secret = ""; //replace your secret key
	
	
	public static String generateOrder() throws Exception {
		JSONObject options = new JSONObject();
		
	    options.put("amount", "5000");
	    options.put("currency", "INR");
	    options.put("payment_capture", "1"); //to auto_capture the payment

	    String url = "https://api.razorpay.com/v1/orders";
	  //The below URL should be used incase of whitelisting the static IP's
	  //String url = "https://prod-api-static.razorpay.com/v1/orders";
	    String credentials = Credentials.basic(key, secret);
	    MediaType JSON = MediaType.parse("application/json; charset=utf-8");
	    OkHttpClient client = new OkHttpClient();

	    okhttp3.RequestBody body = RequestBody.create(JSON, options.toString());
	    okhttp3.Request request = new okhttp3.Request.Builder()
	    		                    .url(url)
	    		                    .addHeader("Authorization",credentials)
	    		                    .post(body)
	    		                    .build();
	    
	    okhttp3.Response response = client.newCall(request).execute();

	    String networkResp = response.body().string();
	    JSONObject json = new JSONObject(networkResp);
	    
	    		     
	    return json.getString("id");
	}
	


}

