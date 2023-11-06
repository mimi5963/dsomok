package webSocket;

import java.util.List;
import java.util.Vector;

import javax.websocket.Session;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

public class Room {
	private List<Session> list;
	private OmokWebSocket omokServer;
	
	public Room(Session player, OmokWebSocket omServer) {
		list = new Vector<>();
		list.add(player);
		omokServer = omServer;
	}
	
	public boolean isInRoom(Session session) {
		
		for(Session s: list) {
			if(s==session)return true;
		}
		
		return false;
	}
	
	private Session finduser(Session session) {
		return list.get(0) == session ? list.get(0):list.get(1);
	}
	
	public void getMessage(Session session, String message) {
		
		//메시지 파싱 (근데 room이 할일은 아님 빼야함) 
		JsonParser parser = new JsonParser();
		JsonObject jo = (JsonObject)parser.parse(message);
		
		String command = jo.get("command").getAsString();
		
		if("init".equals(command)) {
			
			String name = jo.get("name").getAsString();
			String mess = name+"님이 입장하셨습니다.\n";
			sendMessage(mess);
		
		}else if("put".equals(command)) {
			
			String name = jo.get("name").getAsString();
			String position = jo.get("position").getAsString();
			String color = jo.get("color").getAsString();
			sendMessage(name+"님의 좌표 ="+position+'\n');
			
		}else {
			
			String name = jo.get("name").getAsString();
			String uerMess = jo.get("message").getAsString();
			String mess = name+" : "+uerMess+"\n";
			sendMessage(mess);
		}
	}
	
	private void sendMessage(String message) {
		try {
		for(Session s : list) {
			s.getBasicRemote().sendText(message);
		}
		}catch(Exception e) {
			e.printStackTrace();
		}
		
	}
	
	

}
