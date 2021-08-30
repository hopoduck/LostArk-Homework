<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>숙제 추가</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css" />
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script>
            // function addHomework(event) {
            //     const name = addForm.name.value;
            //     const type = addForm.type.value;
            //     const all_character = addForm.all_character.checked;
            //     const member_id = addForm.member_id.value;
            //     const data = { name, type, all_character, member_id };
            //     $.ajax({
            //         type: "post",
            //         url: "/homework/add",
            //         data: data,
            //         success: function (response) {
            //             location.href = `/member/menu`;
            //         },
            //         error: function () {
            //             alert("오류발생! 추가에 실패했습니다..ㅠㅠ");
            //         },
            //     });
            // }
            //
            //
            // document.addEventListener("DOMContentLoaded", () => {
            //     const checkbox = document.getElementById("all_character");
            //     checkbox.addEventListener("change", () => {
            //         if (checkbox.checked) {
            //             checkbox.value = true;
            //         } else {
            //             checkbox.value = false;
            //         }
            //     });
            // });
        </script>
    </head>
    <body>
        <div class="wrap">
            <form action="${pageContext.request.contextPath}/homework/add" method="POST">
                <input type="text" name="homework_name" id="homework_name" placeholder="새 숙제 이름" required />
                <br />
                <label for="day">Day</label>
                <input type="radio" name="homework_type" value="day" id="day" required />
                <label for="week">Week</label>
                <input type="radio" name="homework_type" value="week" id="week" required />
                <br />
                <label for="">원정대 제한 : </label>
                <label for="account_value_true">원정대당 1회 제한</label>
                <input type="radio" id="account_value_true" name="homework_account_value" value="true" required />
                <label for="account_value_false">제한없음</label>
                <input type="radio" id="account_value_false" name="homework_account_value" value="false" required />
                <br />
                <input type="hidden" name="member_id" value="${user.member_id}" />
                <input type="submit" value="추가" />
                <br />
            </form>
        </div>
    </body>
</html>
