package webSocket;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

@ServerEndpoint(value="/omok/{cnum}")
public class OmokWebSocket {
	private Map<String,Room> roomList = new ConcurrentHashMap<>();
	
	@OnOpen
	public void enterRoom(Session session,@PathParam("cnum") String roomNum) {
	
		System.out.println("입장");
	Room omokRoom = roomList.get(roomNum);

	if(omokRoom == null) {
		omokRoom = new Room(session,this);
		roomList.put(roomNum, omokRoom);
	}
		
	}
	
	@OnMessage
	public void getMessage(String message, Session session, @PathParam("cnum") String roomNum) {
		Room room = roomList.get(roomNum);
		room.getMessage(session,message);
		
	}
	 @OnClose
	  public void handleClose() {
	    // 콘솔에 접속 끊김 로그를 출력한다.
	    System.out.println("client is now disconnected...");
	  }
	  // WebSocket과 브라우저 간에 통신 에러가 발생하면 요청되는 함수.
	  @OnError
	  public void handleError(Throwable t) {
	    // 콘솔에 에러를 표시한다.
	    t.printStackTrace();
	  }
}
