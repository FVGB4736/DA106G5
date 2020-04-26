package com.weather_detail.model;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.sql.Timestamp;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//import net.sf.json.JSONObject;
import org.json.*;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
import com.common.JedisPoolUtil;

public class WeatherJsonURL extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private static JedisPool pool = JedisPoolUtil.getJedisPool();

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String url = "https://opendata.cwb.gov.tw/fileapi/v1/opendataapi/F-C0032-001?Authorization=CWB-1D147D77-107C-4005-8F8E-94CE678C3779&downloadType=WEB&format=JSON";
//      String url2 = "http://opendata.cwb.gov.tw/opendataapi?dataid=F-C0032-001&authorizationkey=CWB-77235BD2-2020-4346-A37E-DEE22EB1D2D8"; //doc_name,user_key
//      String url3 = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=24.9670306,121.1921616&radius=1000&types=food&name=&language=zh-TW&key=AIzaSyAYmC8oUYc9DGAZn8hqZKakFeclhAbTRSI";
//      String url4 = "https://v2-api.sheety.co/af46c17763293c918b7674dc2134a95d/da106/food";

//      URL myURL = new URL(url2);
//    	HttpURLConnection conn = (HttpURLConnection) myURL.openConnection();
//    	ByteArrayOutputStream baos = new ByteArrayOutputStream();
//		InputStream in = conn.getInputStream();
//		BufferedInputStream bf = new BufferedInputStream(in);
		Jedis jedis = pool.getResource();
		jedis.auth("DA106G5");
		System.out.println(jedis.ping());
        
        InputStream is = new URL(url).openStream();
        try {
             BufferedReader rd = new BufferedReader(new InputStreamReader(is,"utf-8")); //避免中文亂碼問題
             StringBuilder sb = new StringBuilder();
             int cp;
             while ((cp = rd.read()) != -1) {
                 sb.append((char) cp);
             }
//           System.out.println(sb);
//           JSONObject json = JSONObject.fromObject(sb.toString());
             
             //先刪掉所有現有檔案
             Weather_detailService weather_detailSvc = new Weather_detailService();
             weather_detailSvc.deleteAllWeather_detail();
             
             //整個JSON檔
             JSONObject jsonObj;
			 jsonObj = new JSONObject(sb.toString());
			
             //氣象局公開資源
             JSONObject jsonObjCwbopendata = new JSONObject(jsonObj.get("cwbopendata").toString());
             //資料設定
             JSONObject jsonObjDataset = new JSONObject(jsonObjCwbopendata.get("dataset").toString());

//             SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
//             SimpleDateFormat outputFormat = new SimpleDateFormat("dd-MM-yyyy");
//             Date date = inputFormat.parse("2018-04-10T04:00:00.000Z");
//             String formattedDate = outputFormat.format(date);
//             System.out.println(formattedDate); // prints 10-04-2018
             
             //地點 jsonArrayLocation.length()=22
             JSONArray jsonArrayLocation = jsonObjDataset.getJSONArray("location");
             for (int i = 0; i < jsonArrayLocation.length(); i++) {
            	 //表格所有變數
                 Timestamp weather_time = null;//先給假時間建立資料用
                 String weather_place = null;
                 String wth_comfort = "爽";
                 Integer wth_high = 999;
                 Integer wth_low = -999;
            	 String wth_status = "愛情來的太快就像龍捲風";
                 Integer wth_rain_chance = -100;
                 int wthElements = 0;
                 
                 JSONObject jsonObjLocation = new JSONObject(jsonArrayLocation.get(i).toString());
                 //地點名稱(weather_place)
//               System.out.println("第"+(i+1)+"個城市："+jsonObjLocation.get("locationName"));
                 weather_place = (String)jsonObjLocation.get("locationName");
                 
                 //天氣元素 jsonArrayWeatherElement.length()=5
                 JSONArray jsonArrayWeatherElement = jsonObjLocation.getJSONArray("weatherElement");
                 for (int j = 0; j < jsonArrayWeatherElement.length(); j++) {
                	 JSONObject jsonObjWeatherElement = new JSONObject(jsonArrayWeatherElement.get(j).toString());
                	 //元素名稱
//                	 System.out.println(jsonObjWeatherElement.get("elementName")+":");
                	 String elementName=(String)jsonObjWeatherElement.get("elementName");
                	 wthElements += 1;
                	 
                	 //時間(weather_time) jsonArrayTime.length()=3
                	 JSONArray jsonArrayTime = jsonObjWeatherElement.getJSONArray("time");
                	 for (int k = 0; k < jsonArrayTime.length(); k++) {
                		 JSONObject jsonObjTime = new JSONObject(jsonArrayTime.get(k).toString());
                		 //開始到結束
//                		 System.out.print(jsonObjTime.get("startTime").toString()+" 到 "+jsonObjTime.get("endTime").toString() + "時 : ");
                		 //只存結束時間
                		 String endTime=(String)jsonObjTime.get("endTime");
                		 String[] timeArray = endTime.split("T");
                	     String yyyyMMdd = timeArray[0];
                	     String[] onlyTime = timeArray[1].split("\\+");
                	     String hhmmss = onlyTime[0];
                         weather_time = Timestamp.valueOf(yyyyMMdd+" "+hhmmss);
                         
                         //第一個元素創建時
                         if (wthElements == 1) {
                         	 //先建立一個只有地點和時間的物件
                        	 weather_detailSvc.addWeather_detail(weather_time, weather_place, wth_status, wth_high, wth_low, wth_comfort, wth_rain_chance);
                         }
                         
                         //參數及單位
                		 JSONObject jsonObjParameter = new JSONObject(jsonObjTime.get("parameter").toString());
//                		 if (jsonObjParameter.has("parameterUnit")) {
//                			 System.out.println(jsonObjParameter.get("parameterName").toString()+" ( "+jsonObjParameter.get("parameterUnit").toString()+")");
//                		 }else {
//                			 System.out.println(jsonObjParameter.get("parameterName").toString());
//                		 }
                		 String parameterName = jsonObjParameter.get("parameterName").toString();
                		 if ("Wx".equals(elementName)) {
                			 wth_status = parameterName;
                		 }else if("MaxT".equals(elementName)) {
                			 wth_high = Integer.parseInt(parameterName);
                		 }else if("MinT".equals(elementName)) {
                			 wth_low = Integer.parseInt(parameterName);
                		 }else if("CI".equals(elementName)) {
                			 wth_comfort = parameterName;
                		 }else if("PoP".equals(elementName)) {
                			 wth_rain_chance = Integer.parseInt(parameterName);
                		 }
                		 //元素更新
                		 weather_detailSvc.updateWeather_detail(weather_time, weather_place, wth_status, wth_high, wth_low, wth_comfort, wth_rain_chance);
                		 jedis.hset(weather_place,elementName,parameterName);
                	 }
				 }
                 jedis.expire(weather_place, 10*1);//秒
             }
             jedis.close();
        }catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
             is.close();
        }
    }
	
	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		JedisPoolUtil.shutdownJedisPool();
		super.destroy();
	}
}
