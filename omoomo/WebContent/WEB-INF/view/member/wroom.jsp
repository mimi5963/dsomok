<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
function goRoom(roomNum) {
	//location.href="<c:url value='/enterRoom.do'/>?num="+roomNum;
	location.href="/omoomo/enterRoom.do?num="+roomNum;
}

</script>
</head>
<body>
<h1>대기실 화면입니다.</h1>

<button onclick="goRoom(1)">방1번접속</button>
<button onclick="goRoom(2)">방2번접속</button>
<button onclick="goRoom(3)">방3번접속</button>
<button onclick="goRoom(4)">방4번접속</button>
<button onclick="goRoom(5)">방5번접속</button>
</body>
</html>