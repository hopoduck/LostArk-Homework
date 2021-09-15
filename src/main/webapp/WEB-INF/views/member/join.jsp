<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>회원가입</title>
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
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script>
            $(document).ready(function () {
                $("#join_form input").change(function (e) {
                    const f = $(this).parent().parent();
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
                        console.log(f[0]);
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
                <div class="form-floating col-5 mb-3 mx-auto">
                    <input type="text" class="form-control" name="member_id" id="member_id" placeholder="ID" />
                    <label for="member_id">ID</label>
                    <div class="id mx-auto" style="display: none"></div>
                </div>
                <div class="form-floating col-5 mb-4 mx-auto">
                    <input type="password" class="form-control" name="member_password" id="member_password" placeholder="Password" />
                    <label for="member_password">Password</label>
                </div>
                <div class="form-floating col-5 mb-4 mx-auto">
                    <input type="password" class="form-control" name="member_password2" id="member_password2" placeholder="Password" />
                    <label for="member_password2">Verify Password</label>
                    <div class="password mx-auto" style="display: none"></div>
                </div>
                <div class="form-floating col-5 mb-4 mx-auto">
                    <input type="text" class="form-control" name="member_name" id="member_name" placeholder="Name" />
                    <label for="member_name">Name</label>
                </div>
                <div class="col-5 my-3 mx-auto">
                    <button type="submit" class="btn btn-warning btn-lg w-100 p-2">회원가입</button>
                </div>
                <div class="col-5 my-3 mx-auto">
                    <a class="btn btn-warning btn-lg w-100 p-2" href="${pageContext.request.contextPath}/member/login">로그인 화면으로</a>
                </div>
            </form>
        </div>
    </body>
</html>
