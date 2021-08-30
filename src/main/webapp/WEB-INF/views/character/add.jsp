<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>캐릭터 추가</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css" />
    </head>
    <body>
        <div class="wrap">
            <form action="${pageContext.request.contextPath}/character/add" method="POST">
                <input type="text" name="character_name" placeholder="새 캐릭터 이름" required />
                <br />
                <label for="find">보유 캐릭터 일괄 추가</label>
                <input type="checkbox" name="find" value="true" id="find"> <br>
                <input type="hidden" name="member_id" value="${user.member_id}" />
                <input type="submit" value="추가" /> <br />
            </form>
        </div>
    </body>
</html>
