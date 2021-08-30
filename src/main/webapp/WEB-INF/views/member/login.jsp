<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>로그인</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css" />
    </head>
    <body>
        <div class="wrap">
            <form action="${pageContext.request.contextPath}/member/login" method="POST">
                <h1>LAR - LostArk Recorder</h1>
                <input type="text" name="member_id" placeholder="ID" /> <br />
                <input type="password" name="member_password" placeholder="Password" />
                <br />
                <input type="submit" value="로그인" /> <br />
                <input type="button" value="회원가입" onclick="location.href=`${pageContext.request.contextPath}/member/join`" />
            </form>
        </div>
    </body>
</html>
