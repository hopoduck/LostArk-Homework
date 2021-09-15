<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>로그인</title>
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU"
            crossorigin="anonymous"
        />
        <script
            src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ"
            crossorigin="anonymous"
        ></script>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css" />
    </head>
    <body>
        <div class="wrap">
            <form action="${pageContext.request.contextPath}/member/login" method="POST">
                <h1>LAR - LostArk Recorder</h1>
                <div class="form-floating col-5 mb-3 mx-auto">
                    <input type="text" class="form-control" name="member_id" id="member_id" placeholder="ID" />
                    <label for="member_id">ID</label>
                </div>
                <div class="form-floating col-5 mb-4 mx-auto">
                    <input type="password" class="form-control" name="member_password" id="member_password" placeholder="Password" />
                    <label for="member_password">Password</label>
                </div>
                <div class="col-5 my-3 mx-auto">
                    <button type="submit" class="btn btn-warning btn-lg w-100 p-2">로그인</button>
                </div>
                <div class="col-5 my-3 mx-auto">
                    <a class="btn btn-warning btn-lg w-100 p-2" href="${pageContext.request.contextPath}/member/join">회원가입</a>
                </div>
            </form>
        </div>
    </body>
</html>
