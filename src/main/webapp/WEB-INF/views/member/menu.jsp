<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>LAR - LostArk Recorder</title>
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
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/menu.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script>
            let oldHtml = {};
            // 숙제 프리셋 데이터
            const homeworkPreset = {
                "카오스 던전": [250, "day", false],
                "가디언 토벌": [302, "day", false],
                "오레하의 우물": [1340, "week", false],
                아르고스: [1370, "week", false],
                "쿠크세이튼 리허설": [1385, "week", true],
                "발탄 노말": [1415, "week", false],
                "비아키스 노말": [1430, "week", false],
                "아브렐슈드 데자뷰": [1430, "week", true],
                "발탄 하드": [1445, "week", false],
                "비아키스 하드": [1460, "week", false],
                "쿠크세이튼 노말": [1475, "week", false],
                "아브렐슈드 노말": [1490, "week", false],
                카오스게이트: [302, "day", true],
            };
            // 페이지 시작시 초기 설정
            function init() {
                // 숙제 목록업데이트
                html = "";
                for (const key in homeworkPreset) {
                    html += `<option value="${"${key}"}"></option>`;
                }
                $("#homework_preset").html(html);
                // 메모의 크기 설정
                $("#memoSize").html($("#memo_content").val().length + " / 5000");
            }
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
            function changeCharacterData(e) {
                const name = $(e.target).val();
                $.ajax({
                    type: "post",
                    url: "${pageContext.request.contextPath}/character/getlevel",
                    data: { character_name: name },
                    success: function (response) {
                        $("#character_level").val(parseInt(response));
                    },
                });
            }
            function changeHomeworkData(e) {
                const name = $(e.target).val();
                if (name in homeworkPreset) {
                    $("#homework_level").val(homeworkPreset[name][0]);
                    $("#" + homeworkPreset[name][1]).prop("checked", true);
                    $("#homework_account_value").prop("checked", homeworkPreset[name][2]);
                }
            }
            $(document).ready(function () {
                // 숙제 프리셋에 대한 데이터를 옵션에 내용을 추가한다.
                init();
                // 캐릭터명 입력시 레벨 데이터 받아오기
                $("#character_name").change(function (e) {
                    changeCharacterData(e);
                });
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
                        let html = ``;
                        // if (characterTh.prev().html() !== "") {
                        //     html += `<button class="left btn btn-outline-secondary mx-1" onclick="location.href='${pageContext.request.contextPath}/character/changesortid?sort_id1=${"${sort_id[0]}"}&sort_id2=${"${sort_id[1]}"}'"><i class="fas fa-caret-left"></i></button>`;
                        // }
                        // html += `<button class="delete_btn btn btn-outline-danger" onclick="location.href='${pageContext.request.contextPath}/character/delete?character_id=${"${character_id}"}'"><i class="far fa-trash-alt"></i> 삭제</button>`;
                        // if (characterTh.next().length !== 0) {
                        //     html += `<button class="right btn btn-outline-secondary mx-1" onclick="location.href='${pageContext.request.contextPath}/character/changesortid?sort_id1=${"${sort_id[1]}"}&sort_id2=${"${sort_id[2]}"}'"><i class="fas fa-caret-right"></i></button>`;
                        // }

                        if (characterTh.prev().html() !== "") {
                            html += `<i class="fas fa-caret-left pointer p-2" onclick="location.href='${
                                pageContext.request.contextPath
                            }/character/changesortid?sort_id1=${"${sort_id[0]}"}&sort_id2=${"${sort_id[1]}"}'"></i>`;
                        }
                        html += `<i class="far fa-trash-alt pointer p-2" onclick="location.href='${
                            pageContext.request.contextPath
                        }/character/delete?character_id=${"${character_id}"}'"></i>`;
                        if (characterTh.next().length !== 0) {
                            html += `<i class="fas fa-caret-right pointer p-2" onclick="location.href='${
                                pageContext.request.contextPath
                            }/character/changesortid?sort_id1=${"${sort_id[1]}"}&sort_id2=${"${sort_id[2]}"}'"></i>`;
                        }

                        characterTh.html(html);
                    },
                    function () {
                        const characterTh = $(this);
                        const character_id = $(this).attr("itemid");
                        $(this).html(`
                            <div class="character_name">${"${characterTh.attr('itemprop')}"}</div>
                            <div class="character_level">${"${characterTh.attr('value')}"}</div>`);
                    }
                );
                // 숙제 이름에 마우스를 가져다 댈 시 삭제버튼을 보여준다.
                $(".homework_name").hover(
                    function () {
                        oldHtml = $(this).html();
                        const homeworkTd = $(this);
                        const homework_id = $(this).attr("itemid");
                        const sort_id = [
                            homeworkTd.parent().prev().children("td.homework_name").attr("itemscope"),
                            homeworkTd.attr("itemscope"),
                            homeworkTd.parent().next().children("td.homework_name").attr("itemscope"),
                        ];
                        let html = "";
                        if (homeworkTd.parent().prev().prev().hasClass(homeworkTd.parent().attr("class"))) {
                            html += `<button class="up btn btn-outline-secondary mx-1" onclick="location.href='${
                                pageContext.request.contextPath
                            }/homework/changesortid?sort_id1=${"${sort_id[0]}"}&sort_id2=${"${sort_id[1]}"}'"><i class="fas fa-caret-up"></i></button>`;
                        }
                        html += `<button class="delete_btn btn btn-outline-danger" onclick="location.href='${
                            pageContext.request.contextPath
                        }/homework/delete?homework_id=${"${homework_id}"}'"><i class="far fa-trash-alt"></i> 삭제</button>`;
                        if (homeworkTd.parent().next().hasClass(homeworkTd.parent().attr("class"))) {
                            html += `<button class="up btn btn-outline-secondary mx-1" onclick="location.href='${
                                pageContext.request.contextPath
                            }/homework/changesortid?sort_id1=${"${sort_id[1]}"}&sort_id2=${"${sort_id[2]}"}'"><i class="fas fa-caret-down"></i></button>`;
                        }
                        $(this).html(html);
                    },
                    function () {
                        $(this).html(oldHtml);
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
                // 프리셋에 있는 이름을 숙제 제목에 입력하면 프리셋의 데이터 등록
                $("#homework_name").change(function (e) {
                    changeHomeworkData(e);
                });
                // 메모 저장
                $("#memoForm").submit(function (e) {
                    e.preventDefault();
                    const memoForm = $(this);
                    $.ajax({
                        type: "post",
                        url: "${pageContext.request.contextPath}/memo/save",
                        data: { member_id: memoForm[0].member_id.value, memo_content: $("#memo_content").val() },
                        success: function (response) {
                            alert("메모 내용이 저장되었습니다.");
                        },
                    });
                });
                // 메모 작성시 여유 글자수 보여줌
                $("#memo_content").on("input", function (e) {
                    $("#memoSize").html($("#memo_content").val().length + " / 5000");
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
            <div id="character_add_form" class="border add_form my-3 p-4" style="display: none">
                <form action="${pageContext.request.contextPath}/character/add" method="POST">
                    <div class="form-floating mb-3">
                        <input type="text" name="character_name" id="character_name" class="form-control" placeholder="캐릭터 이름" required />
                        <label for="character_name">캐릭터 이름</label>
                    </div>
                    <div class="form-floating mb-3">
                        <input
                            type="number"
                            name="character_level"
                            id="character_level"
                            class="form-control"
                            placeholder="캐릭터 아이템 레벨"
                            min="0"
                            max="1590"
                            required
                        />
                        <label for="character_level">캐릭터 아이템 레벨</label>
                    </div>
                    <!-- <div class="form-check form-switch mb-3">
                        <input class="form-check-input" type="checkbox" id="find" name="find" value="true" />
                        <label class="form-check-label" for="find">보유 캐릭터 일괄 추가</label>
                    </div> -->
                    <input type="hidden" name="member_id" value="${user.member_id}" />
                    <button type="submit" class="btn btn-success"><i class="far fa-plus-square"></i> 추가</button>
                </form>
            </div>
            <div id="homework_add_form" class="border add_form my-3 p-4" style="display: none">
                <form action="${pageContext.request.contextPath}/homework/add" method="POST">
                    <div class="form-floating mb-3">
                        <input
                            type="text"
                            name="homework_name"
                            id="homework_name"
                            class="form-control"
                            placeholder="숙제 이름"
                            list="homework_preset"
                            required
                        />
                        <datalist id="homework_preset"></datalist>
                        <label for="homework_name">숙제 이름</label>
                    </div>
                    <div class="form-floating mb-3">
                        <input
                            type="number"
                            name="homework_level"
                            id="homework_level"
                            class="form-control"
                            placeholder="최소 레벨"
                            min="0"
                            max="1590"
                            required
                        />
                        <label for="homework_level">최소 레벨</label>
                    </div>
                    <div class="btn-group mb-3" role="group">
                        <input type="radio" class="btn-check" name="homework_type" id="day" value="day" required />
                        <label class="btn btn-outline-warning" for="day">일일 숙제</label>
                        <input type="radio" class="btn-check" name="homework_type" id="week" value="week" required />
                        <label class="btn btn-outline-warning" for="week">주간 숙제</label>
                    </div>
                    <div class="form-check form-switch mb-3">
                        <input class="form-check-input" type="checkbox" id="homework_account_value" name="homework_account_value" value="true" />
                        <label class="form-check-label" for="homework_account_value">원정대 1회 제한</label>
                    </div>
                    <input type="hidden" name="member_id" value="${user.member_id}" />
                    <button type="submit" class="btn btn-success"><i class="far fa-plus-square"></i> 추가</button>
                </form>
            </div>
            <h1 class="title">숙제 기록</h1>
            <c:choose>
                <c:when test="${not empty characterList && (not empty dayHomework || not empty weekHomework)}">
                    <table class="record">
                        <tr>
                            <td></td>
                            <c:forEach var="c" items="${characterList}">
                                <td
                                    class="character_name"
                                    itemid="${c.character_id}"
                                    itemprop="${c.character_name}"
                                    itemscope="${c.sort_id}"
                                    value="${c.character_level}"
                                >
                                    <div class="character_name">${c.character_name}</div>
                                    <div class="character_level">${c.character_level}</div>
                                </td>
                            </c:forEach>
                        </tr>
                        <c:if test="${not empty dayHomework}">
                            <tr class="dh">
                                <th colspan="${characterList.size()+1}">일일 숙제</th>
                            </tr>
                            <c:forEach var="dh" items="${dayHomework}">
                                <tr class="dh" itemtype="${dh.homework_account_value}">
                                    <td class="homework_name" itemid="${dh.homework_id}" itemprop="${dh.homework_name}" itemscope="${dh.sort_id}">
                                        ${dh.homework_name}
                                    </td>
                                    <c:forEach var="c" items="${characterList}">
                                        <c:set var="disabled" value="${c.character_level<dh.homework_level?'disabled':''}" />
                                        <!-- <td><input type="checkbox" id="h_${dh.homework_id}_c_${c.character_id}" ${disabled}></td> -->
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
                                    <td class="homework_name" itemid="${wh.homework_id}" itemprop="${wh.homework_name}" itemscope="${wh.sort_id}">
                                        ${wh.homework_name}
                                    </td>
                                    <c:forEach var="c" items="${characterList}">
                                        <c:set var="disabled" value="${c.character_level<wh.homework_level?'disabled':''}" />
                                        <!-- <td><input type="checkbox" id="h_${wh.homework_id}_c_${c.character_id}" ${disabled}></td> -->
                                    </c:forEach>
                                </tr>
                            </c:forEach>
                        </c:if>
                    </table>
                </c:when>
                <c:otherwise>
                    <h3>
                        먼저 우상단의 메뉴에서 ${not empty characterList?"":"캐릭터"}${(not empty dayHomework || not empty weekHomework)?"":"숙제"}를
                        추가해주세요!
                    </h3>
                </c:otherwise>
            </c:choose>
            <form id="memoForm" method="POST">
                <div class="form-floating mb-3">
                    <textarea name="memo_content" id="memo_content" class="form-control" placeholder="메모" maxlength="5000">${memo.memo_content}</textarea>
                    <label for="memo_content">메모</label>
                </div>
                <input type="hidden" name="member_id" value="${user.member_id}" />
                <div class="text-end">
                    <span id="memoSize" class="mx-3 text-muted">0 / 5000</span>
                    <button type="submit" class="btn btn-success" id="memoSubmit">저장</button>
                </div>
            </form>
        </div>
    </body>
</html>
