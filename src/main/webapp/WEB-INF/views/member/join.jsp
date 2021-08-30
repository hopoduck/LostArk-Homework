<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>회원가입</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css" />
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script>
            $(document).ready(function () {
                $("#join_form input").change(function (e) {
                    const f = $(this).parent();
                    if (this.name === "member_id") {
                        $.ajax({
                            type: "post",
                            url: "/member/find_member_id",
                            data: { member_id: this.value },
                            success: function (response) {
                                const data = $.parseJSON(response);
                                $(".id").show();
                                if (data.result === true) {
                                    $(".id").removeClass("fail");
                                    $(".id").addClass("success");
                                    $(".id").text("사용 가능한 ID입니다.");
                                } else {
                                    $(".id").removeClass("success");
                                    $(".id").addClass("fail");
                                    $(".id").text("사용 불가능한 ID입니다.");
                                }
                                setInterval(() => {
                                    $(".id").hide();
                                }, 5000);
                            },
                        });
                    } else if (this.name === "member_password" || this.name === "member_password2") {
                        $(".password").show();
                        if (f[0][1].value === f[0][2].value) {
                            $(".password").removeClass("fail");
                            $(".password").addClass("success");
                            $(".password").text("입력한 비밀번호가 같습니다.");
                        } else {
                            $(".password").removeClass("success");
                            $(".password").addClass("fail");
                            $(".password").text("입력한 비밀번호가 다릅니다.");
                        }
                        setInterval(() => {
                            $(".password").hide();
                        }, 5000);
                    }
                });
                $("#join_form").submit(function (e) {
                    if ($(".id").text() !== "사용 가능한 ID입니다." || $(".password").text() !== "입력한 비밀번호가 같습니다.") {
                        e.preventDefault();
                        alert("ID와 비밀번호를 확인하세요.");
                    }
                });
            });
        </script>
    </head>
    <body>
        <div class="wrap">
            <form action="${pageContext.request.contextPath}/member/join" method="POST" id="join_form">
                <h1>LAR - LostArk Recorder</h1>
                <input type="text" name="member_id" placeholder="ID" required />
                <br />
                <div class="id" style="display: none"></div>
                <input type="password" name="member_password" placeholder="Password" required />
                <br />
                <input type="password" name="member_password2" placeholder="Verify Password" required />
                <br />
                <div class="password" style="display: none"></div>
                <input type="text" name="member_name" placeholder="이름" required />
                <br />
                <input type="submit" value="회원가입" /> <br />
            </form>
        </div>
    </body>
</html>
