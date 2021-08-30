<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>LAR - LostArk Recorder</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/menu.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script>
            // 체크박스 1개의 값을 변경
            function changeCheckbox(homework_id, character_id, record) {
                $("#h_" + homework_id + "_c_" + character_id)[0].checked = record;
            }
            // 체크박스 배열의 값을 변경
            function changeCheckboxList(array) {
                for (let i = 0; i < array.length; i++) {
                    const element = array[i];
                    changeCheckbox(element.homework_id, element.character_id, element.record);
                }
            }
            $(document).ready(function () {
                // 로그인한 멤버의 아이디를 보내 숙제 기록을 받아온다.
                $.ajax({
                    type: "post",
                    url: "${pageContext.request.contextPath}/homeworkRecord/getList",
                    data: { member_id: "${user.member_id}" },
                    success: function (response) {
                        const data = $.parseJSON(response);
                        changeCheckboxList(data);
                    },
                });
                // 기록표 안에 있는 체크박스를 값 변경시
                $(".record").on("change", "input[type='checkbox']", function () {
                    const checkbox = $(this);
                    const data = checkbox.attr("id").split("_");
                    const homework_id = data[1];
                    const character_id = data[3];
                    let checkedValue = checkbox[0].checked;
                    if (checkbox.parent().parent().attr("itemtype") === "true") {
                        const checkboxList = checkbox.parent().parent().children().children("input[type='checkbox']");
                        for (let i = 0; i < checkboxList.length; i++) {
                            const element = checkboxList[i];
                            element.checked = checkbox[0].checked;
                        }
                    }
                    // 데이터를 서버에 보내고 원정대 공유인경우 일괄적용한다.
                    // 실패시 선택했던 체크박스를 원래 값으로 되돌린다.
                    $.ajax({
                        type: "post",
                        url: "${pageContext.request.contextPath}/homeworkRecord/change",
                        data: { homework_id, character_id, record: checkedValue },
                        success: function (response) {
                            const res = $.parseJSON(response);
                            changeCheckboxList(res);
                        },
                        error: function (error) {
                            alert("error..");
                            changeCheckbox(homework_id, character_id, !record);
                        },
                    });
                });
                // 캐릭터 이름에 마우스를 가져다 댈 시 삭제버튼을 보여준다.
                $(".character_name").hover(
                    function () {
                        const characterTh = $(this);
                        const character_id = characterTh.attr("itemid");
                        const character_name = characterTh.attr("itemprop");
                        const sort_id = [characterTh.prev().attr("itemscope"), characterTh.attr("itemscope"), characterTh.next().attr("itemscope")];
                        console.log(sort_id);
                        let html = ``;
                        if (characterTh.prev().html() !== "") {
                            html += `<button class="left" onclick="location.href='${
                                pageContext.request.contextPath
                            }/character/changesortid?sort_id1=${"${sort_id[0]}"}&sort_id2=${"${sort_id[1]}"}'"><i class="fas fa-caret-left"></i></button>`;
                        }
                        html += `<button class="delete_btn" onclick="location.href='${
                            pageContext.request.contextPath
                        }/character/delete?character_id=${"${character_id}"}'"><i class="far fa-trash-alt"></i>삭제</button>`;
                        if (characterTh.next().length !== 0) {
                            html += `<button class="right" onclick="location.href='${
                                pageContext.request.contextPath
                            }/character/changesortid?sort_id1=${"${sort_id[1]}"}&sort_id2=${"${sort_id[2]}"}'"><i class="fas fa-caret-right"></i></button>`;
                        }
                        characterTh.html(html);
                    },
                    function () {
                        const characterTh = $(this);
                        const character_id = characterTh.attr("itemid");
                        const character_name = characterTh.attr("itemprop");
                        characterTh.html(character_name);
                    }
                );
                // 숙제 이름에 마우스를 가져다 댈 시 삭제버튼을 보여준다.
                $(".homework_name").hover(
                    function () {
                        const homework_id = $(this).attr("itemid");
                        const homework_name = $(this).attr("itemprop");
                        $(this).html(
                            `<button class="delete_btn" onclick="location.href='${
                                pageContext.request.contextPath
                            }/homework/delete?homework_id=${"${homework_id}"}'"><i class="far fa-trash-alt"></i>삭제</button>`
                        );
                    },
                    function () {
                        const homework_id = $(this).attr("itemid");
                        const homework_name = $(this).attr("itemprop");
                        $(this).html(homework_name);
                    }
                );
                // 상단 메뉴클릭 시
                $("#character_add").click(function (e) {
                    e.preventDefault();
                    $("#character_add_form").slideToggle();
                });
                $("#homework_add").click(function (e) {
                    e.preventDefault();
                    $("#homework_add_form").slideToggle();
                });
                $("#memberOut").click(function (e) {
                    e.preventDefault();
                    const c1 = confirm("회원탈퇴 하시겠습니까?");
                    if (c1) {
                        const c2 = confirm("정말로 회원탈퇴를 진행할까요?\n회원탈퇴는 되돌릴 수 없으며, 자동적으로 회원님의 데이터는 지워집니다.");
                        if (c2) {
                            alert("회원탈퇴 되셨습니다. 그동안 이용해주셔서 감사합니다.");
                            location.href = "${pageContext.request.contextPath}/member/out";
                        }
                    }
                });
            });
        </script>
    </head>
    <body>
        <header>
            <div class="wrap">
                <div class="left">
                    <a class="logo" href="${pageContext.request.contextPath}/member/menu">LAR</a>
                    <span class="user_info"><span class="user_name">${user.member_name}</span>님 반갑습니다!</span>
                </div>
                <div class="right">
                    <span class="menu">
                        <a href="${pageContext.request.contextPath}/member/logout">로그아웃</a>
                    </span>
                    <span class="menu"> <a href="${pageContext.request.contextPath}/character/add" id="character_add">캐릭터 추가</a> </span
                    ><span class="menu"> <a href="${pageContext.request.contextPath}/homework/add" id="homework_add">숙제 추가</a> </span
                    ><span class="menu">
                        <a href="#" id="memberOut">탈퇴</a>
                    </span>
                </div>
            </div>
        </header>
        <div class="wrap main">
            <div id="character_add_form" style="display: none">
                <form action="${pageContext.request.contextPath}/character/add" method="POST">
                    <input type="text" name="character_name" placeholder="새 캐릭터 이름" required />
                    <br />
                    <input type="checkbox" name="find" value="true" id="find" />
                    <label for="find">보유 캐릭터 일괄 추가</label> <br />
                    <input type="hidden" name="member_id" value="${user.member_id}" />
                    <button><i class="far fa-plus-square"></i> 추가</button> <br />
                </form>
            </div>
            <div id="homework_add_form" style="display: none">
                <form action="${pageContext.request.contextPath}/homework/add" method="POST">
                    <input type="text" name="homework_name" id="homework_name" placeholder="새 숙제 이름" required />
                    <br />
                    <label for="day">Day</label>
                    <input type="radio" name="homework_type" value="day" id="day" required />
                    <label for="week">Week</label>
                    <input type="radio" name="homework_type" value="week" id="week" required />
                    <br />
                    <input type="checkbox" name="homework_account_value" value="true" id="homework_account_value" />
                    <label for="homework_account_value">원정대 1회 제한</label> <br />
                    <input type="hidden" name="member_id" value="${user.member_id}" />
                    <button><i class="far fa-plus-square"></i> 추가</button> <br />
                </form>
            </div>
            <h1 class="title">숙제 기록</h1>
            <c:choose>
                <c:when test="${not empty characterList && (not empty dayHomework || not empty weekHomework)}">
                    <table class="record">
                        <tr>
                            <td></td>
                            <c:forEach var="c" items="${characterList}">
                                <td class="character_name" itemid="${c.character_id}" itemprop="${c.character_name}" itemscope="${c.sort_id}">
                                    ${c.character_name}
                                </td>
                            </c:forEach>
                        </tr>
                        <c:if test="${not empty dayHomework}">
                            <tr class="dh">
                                <th colspan="${characterList.size()+1}">일일 숙제</th>
                            </tr>
                            <c:forEach var="dh" items="${dayHomework}">
                                <tr class="dh" itemtype="${dh.homework_account_value}">
                                    <td class="homework_name" itemid="${dh.homework_id}" itemprop="${dh.homework_name}">${dh.homework_name}</td>
                                    <c:forEach var="c" items="${characterList}">
                                        <td><input type="checkbox" id="h_${dh.homework_id}_c_${c.character_id}"></td>
                                    </c:forEach>
                                </tr>
                            </c:forEach>
                        </c:if>
                        <c:if test="${not empty weekHomework}">
                            <tr class="wh">
                                <th colspan="${characterList.size()+1}">주간 숙제</th>
                            </tr>
                            <c:forEach var="wh" items="${weekHomework}">
                                <tr class="wh" itemtype="${wh.homework_account_value}">
                                    <td class="homework_name" itemid="${wh.homework_id}" itemprop="${wh.homework_name}">${wh.homework_name}</td>
                                    <c:forEach var="c" items="${characterList}">
                                        <td><input type="checkbox" id="h_${wh.homework_id}_c_${c.character_id}"></td>
                                    </c:forEach>
                                </tr>
                            </c:forEach>
                        </c:if>
                    </table>
                </c:when>
                <c:otherwise>
                    <h3>먼저 우상단의 메뉴에서 캐릭터, 숙제를 추가해주세요!</h3>
                </c:otherwise>
            </c:choose>
        </div>
    </body>
</html>
