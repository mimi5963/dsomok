<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
  <title>Web Socket Example</title>
  <script>
  	
  	 	
    	 var webSocket = new WebSocket("ws://localhost:8080/omoomo/omok/2");
      function sendMessage() {
        
        var message = document.getElementById("textMessage");
        
        //messageTextArea.value += "Send to Server => "+message.value+"\n";
       
        var messageJson = {
        		"command":"chat",
        		"name":"${name}",
        		"message":message.value
        		
        }	
        var jsonString = JSON.stringify(messageJson);
        webSocket.send(jsonString);
       
        message.value = "";
      }
      
      function disconnect() {
        
        webSocket.close();
        location.href="/omoomo/wroom.do";
      }
      
      function enterkey() {
    		if (window.event.keyCode == 13) {
    			  var message = document.getElementById("textMessage");
    		   
    		       
    		        var messageJson = {
    		        		"command":"chat",
    		        		"name":"${name}",
    		        		"message":message.value
    		        		
    		        }	
    		        var jsonString = JSON.stringify(messageJson);
    		        webSocket.send(jsonString);
    		       
    		        message.value = "";
    	    }
    	}	

  	window.onload = function() {
  		 var messageTextArea = document.getElementById("messageTextArea");
         
         webSocket.onopen = function(message) {
           
           //messageTextArea.value += "Server connect...\n";
           var message = {
        		   "command":"init",
        		   "name":"${name}",
        	
           };
           var mess = JSON.stringify(message);
           webSocket.send(mess);
         };
         
         webSocket.onclose = function(message) {
          
           messageTextArea.value += "Server Disconnect...\n";
         };
        
         webSocket.onerror = function(message) {
          
           messageTextArea.value += "error...\n";
         };
         
         webSocket.onmessage = function(message) {
          
           messageTextArea.value +=message.data;
         };
         
         const click = document.querySelector('.clickBox');
         click.addEventListener('click',function(e){
        	 sendPoint(e.offsetY,e.offsetX);
         })
	}
  	function sendPoint(y,x) {
		
	
  		var rawjson = {
  				"command":"put",
  				"name":"${name}",
  				"position":y+""+x,
  				"color":"black"
  				
  		};
  		var jsonString = JSON.stringify(rawjson);
  		webSocket.send(jsonString);
  	}
 
  </script>
  <style type="text/css">
  	.clickBox{
  		width:300px;
  		height:300px;
  		background-color: gray;
  		border: 1px solid;
  	}
  </style>
  </head>
  <body>
	<div>
		<div class="clickBox">
			
		</div>
		
	</div>	
      <!-- 송신 메시지를 작성하는 텍스트 박스 -->
      <input id="textMessage" type="text" onkeyup="enterkey()">
      <!-- 메시지 송신을 하는 버튼 -->
      <input onclick="sendMessage()" value="Send" type="button">
      <!-- WebSocket 접속 종료하는 버튼 -->
      <input onclick="disconnect()" value="Disconnect" type="button">
   
    <br />
    <!-- 콘솔 메시지의 역할을 하는 로그 텍스트 에리어.(수신 메시지도 표시한다.) -->
    <textarea id="messageTextArea" rows="10" cols="50"></textarea>
</body>
</html>