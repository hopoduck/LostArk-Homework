<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"
%>
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
                에포나: [250, "day", false],
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
                길드출석: [0, "day", false],
                호감도: [0, "day", false],
            };
            const homeworkData = {};
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
                // 캐릭터 이름에 마우스를 가져다 댈 시 수정/삭제버튼을 보여준다.
                $(".character_name").hover(
                    function () {
                        const characterTh = $(this);
                        const character_id = characterTh.attr("itemid");
                        const character_level = characterTh.attr("value");
                        const character_name = characterTh.attr("itemprop");
                        const sort_id = [characterTh.prev().attr("itemscope"), characterTh.attr("itemscope"), characterTh.next().attr("itemscope")];
                        let html = ``;
                        if (characterTh.prev().html() !== "") {
                            html += `<i class="fas fa-caret-left pointer p-2" title="왼쪽으로 이동" onclick="location.href='${
                                pageContext.request.contextPath
                            }/character/changesortid?sort_id1=${"${sort_id[0]}"}&sort_id2=${"${sort_id[1]}"}'"></i>`;
                        }
                        html += `<i class="far fa-edit pointer p-2" title="이 캐릭터 수정" data-bs-toggle="modal" data-bs-target="#modal-characterEdit" data-bs-character_name="${"${character_name}"}" data-bs-character_level="${"${character_level}"}" data-bs-character_id="${"${character_id}"}"></i>`;
                        html += `<i class="far fa-trash-alt pointer p-2" title="이 캐릭터 삭제" onclick="location.href='${
                            pageContext.request.contextPath
                        }/character/delete?character_id=${"${character_id}"}'"></i>`;
                        if (characterTh.next().length !== 0) {
                            html += `<i class="fas fa-caret-right pointer p-2" title="오른쪽으로 이동" onclick="location.href='${
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
                // 숙제 이름에 마우스를 가져다 댈 시 수정/삭제버튼을 보여준다.
                $(".homework_name").hover(
                    async function () {
                        oldHtml = $(this).html();
                        const homeworkTd = $(this);
                        const homework_id = $(this).attr("itemid");
                        if (!(homework_id in homeworkData)) {
                            await $.ajax({
                                type: "post",
                                url: "${pageContext.request.contextPath}/homework/get-data",
                                data: { homework_id },
                                success: function (response) {
                                    homeworkData[homework_id] = $.parseJSON(response);
                                },
                            });
                        }
                        const sort_id = [
                            homeworkTd.parent().prev().children("td.homework_name").attr("itemscope"),
                            homeworkTd.attr("itemscope"),
                            homeworkTd.parent().next().children("td.homework_name").attr("itemscope"),
                        ];
                        let html = "";
                        if (homeworkTd.parent().prev().prev().hasClass(homeworkTd.parent().attr("class"))) {
                            html += `<i class="fas fa-caret-up pointer p-2" title="위로 이동" onclick="location.href='${
                                pageContext.request.contextPath
                            }/homework/changesortid?sort_id1=${"${sort_id[0]}"}&sort_id2=${"${sort_id[1]}"}'"></i>`;
                        }
                        html += `<i class="far fa-edit pointer p-2" title="이 숙제 수정" data-bs-toggle="modal" data-bs-target="#modal-homework-edit" 
                                    data-bs-homework_name="${"${homeworkData[homework_id]['homework_name']}"}" 
                                    data-bs-homework_level="${"${homeworkData[homework_id]['homework_level']}"}" 
                                    data-bs-homework_id="${"${homeworkData[homework_id]['homework_id']}"}" 
                                    data-bs-homework_type="${"${homeworkData[homework_id]['homework_type']}"}" 
                                    data-bs-homework_account_value="${"${homeworkData[homework_id]['homework_account_value']}"}" 
                                    data-bs-homework_bonus="${"${homeworkData[homework_id]['homework_bonus']}"}" 
                                    data-bs-homework_bonus_value="${"${homeworkData[homework_id]['homework_bonus_value']}"}"
                                ></i>`;
                        html += `<i class="far fa-trash-alt pointer p-2" title="이 숙제 삭제" onclick="location.href='${
                            pageContext.request.contextPath
                        }/homework/delete?homework_id=${"${homework_id}"}'"></i>`;
                        if (homeworkTd.parent().next().hasClass(homeworkTd.parent().attr("class"))) {
                            html += `<i class="fas fa-caret-down pointer p-2" title="아래로 이동" onclick="location.href='${
                                pageContext.request.contextPath
                            }/homework/changesortid?sort_id1=${"${sort_id[1]}"}&sort_id2=${"${sort_id[2]}"}'"></i>`;
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
                // 캐릭터/숙제 레벨 입력시 숫자만 입력가능하게 하고, 최소/최대레벨 제한
                $(document).on("input", "input[name='character_level'], input[name='homework_level']", function (e) {
                    const input = $(this);
                    if (input.val() < 0) {
                        input.val(0);
                    } else if (input.val() > 1590) {
                        input.val(1590);
                    }
                    input.val(parseInt(input.val() + "".replace("/[^0-9]/g", "")));
                });
                // 캐릭터 수정 모달
                const modalCharacterEdit = document.getElementById("modal-characterEdit");
                modalCharacterEdit.addEventListener("show.bs.modal", function (event) {
                    // Button that triggered the modal
                    const button = event.relatedTarget;
                    // Extract info from data-bs-* attributes
                    const characterId = button.getAttribute("data-bs-character_id");
                    const characterName = button.getAttribute("data-bs-character_name");
                    const characterLevel = button.getAttribute("data-bs-character_level");
                    // If necessary, you could initiate an AJAX request here
                    // and then do the updating in a callback.
                    //
                    // Update the modal's content.
                    modalCharacterEdit.querySelector(".modal-title").textContent = characterName + " 정보 수정";
                    modalCharacterEdit.querySelector(".modal-body input#modal-character_id").value = characterId;
                    modalCharacterEdit.querySelector(".modal-body input#modal-character_name").value = characterName;
                    modalCharacterEdit.querySelector(".modal-body input#modal-character_level").value = characterLevel;
                    const saveBtn = document.getElementById("modal-characterEdit-btn");
                    saveBtn.addEventListener("click", (e) => {
                        e.preventDefault();
                        modalCharacterEdit.querySelector("form").submit();
                    });
                });
                // 숙제 수정 모달
                const modalHomeworkEdit = document.getElementById("modal-homework-edit");
                modalHomeworkEdit.addEventListener("show.bs.modal", function (event) {
                    // Button that triggered the modal
                    const button = event.relatedTarget;
                    // Extract info from data-bs-* attributes
                    const homework_id = button.getAttribute("data-bs-homework_id");
                    const homework_name = button.getAttribute("data-bs-homework_name");
                    const homework_level = button.getAttribute("data-bs-homework_level");
                    const homework_type = button.getAttribute("data-bs-homework_type");
                    const homework_account_value = $.parseJSON(button.getAttribute("data-bs-homework_account_value"));
                    // If necessary, you could initiate an AJAX request here
                    // and then do the updating in a callback.
                    //
                    // Update the modal's content.
                    modalHomeworkEdit.querySelector(".modal-title").textContent = homework_name + " 정보 수정";
                    modalHomeworkEdit.querySelector(".modal-body input#modal-homework_id").value = homework_id;
                    modalHomeworkEdit.querySelector(".modal-body input#modal-homework_name").value = homework_name;
                    modalHomeworkEdit.querySelector(".modal-body input#modal-homework_level").value = homework_level;
                    modalHomeworkEdit.querySelector("form").homework_type.value = homework_type;
                    $(".modal-body input#modal-homework_account_value").prop("checked", homework_account_value);
                    const saveBtn = document.getElementById("modal-homework-edit-btn");
                    saveBtn.addEventListener("click", (e) => {
                        e.preventDefault();
                        modalHomeworkEdit.querySelector("form").submit();
                    });
                });
            });
        </script>
    </head>
    <body>
        <!-- 헤더 (네비바) -->
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
                    ><span class="menu"> <a href="${pageContext.request.contextPath}/homework/add" id="homework_add">숙제 추가</a> </span>
                    <span class="menu">
                        <a href="${pageContext.request.contextPath}/character/update-level">캐릭터 레벨 업데이트</a>
                    </span>
                    <span class="menu">
                        <a href="#" id="memberOut">탈퇴</a>
                    </span>
                </div>
            </div>
        </header>
        <div class="wrap main">
            <!-- 캐릭터 추가 폼 -->
            <div id="character_add_form" class="border add_form my-3" style="display: none">
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
            <!-- 숙제 추가 폼 -->
            <div id="homework_add_form" class="border add_form my-3" style="display: none">
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
            <!-- 숙제 기록표 -->
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
                                        <td>
                                            <input type="checkbox" id="h_${dh.homework_id}_c_${c.character_id}" ${disabled}>
                                        </td>
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
                                        <td>
                                            <input type="checkbox" id="h_${wh.homework_id}_c_${c.character_id}" ${disabled}>
                                        </td>
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
            <!-- 메모 -->
            <form id="memoForm" method="POST">
                <div class="form-floating mb-3">
                    <textarea name="memo_content" id="memo_content" class="form-control" placeholder="메모" maxlength="5000">
${memo.memo_content}</textarea
                    >
                    <label for="memo_content">메모</label>
                </div>
                <input type="hidden" name="member_id" value="${user.member_id}" />
                <div class="text-end">
                    <span id="memoSize" class="mx-3 text-muted">0 / 5000</span>
                    <button type="submit" class="btn btn-success" id="memoSubmit">저장</button>
                </div>
            </form>
            <!-- 캐릭터 수정 모달 -->
            <div class="modal fade" id="modal-characterEdit" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">캐릭터 정보 수정</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form action="${pageContext.request.contextPath}/character/edit" method="POST">
                                <div class="form-floating mb-3">
                                    <input
                                        type="text"
                                        name="character_name"
                                        id="modal-character_name"
                                        class="form-control"
                                        placeholder="캐릭터 이름"
                                        required
                                    />
                                    <label for="modal-character_name">캐릭터 이름</label>
                                </div>
                                <div class="form-floating mb-3">
                                    <input
                                        type="number"
                                        name="character_level"
                                        id="modal-character_level"
                                        class="form-control"
                                        placeholder="캐릭터 아이템 레벨"
                                        min="0"
                                        max="1590"
                                        required
                                    />
                                    <label for="modal-character_level">캐릭터 아이템 레벨</label>
                                </div>
                                <input type="hidden" name="character_id" id="modal-character_id" />
                                <input type="hidden" name="member_id" value="${user.member_id}" />
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                            <button type="button" class="btn btn-success" id="modal-characterEdit-btn"><i class="far fa-edit"></i> 수정</button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 숙제 수정 모달 -->
            <div class="modal fade" id="modal-homework-edit" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">숙제 정보 수정</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form action="${pageContext.request.contextPath}/homework/edit" method="POST">
                                <div class="form-floating mb-3">
                                    <input
                                        type="text"
                                        name="homework_name"
                                        id="modal-homework_name"
                                        class="form-control"
                                        placeholder="숙제 이름"
                                        list="homework_preset"
                                        required
                                    />
                                    <datalist id="homework_preset"></datalist>
                                    <label for="modal-homework_name">숙제 이름</label>
                                </div>
                                <div class="form-floating mb-3">
                                    <input
                                        type="number"
                                        name="homework_level"
                                        id="modal-homework_level"
                                        class="form-control"
                                        placeholder="최소 레벨"
                                        min="0"
                                        max="1590"
                                        required
                                    />
                                    <label for="modal-homework_level">최소 레벨</label>
                                </div>
                                <div class="btn-group mb-3" role="group">
                                    <input type="radio" class="btn-check" name="homework_type" id="modal-day" value="day" required />
                                    <label class="btn btn-outline-warning" for="modal-day">일일 숙제</label>
                                    <input type="radio" class="btn-check" name="homework_type" id="modal-week" value="week" required />
                                    <label class="btn btn-outline-warning" for="modal-week">주간 숙제</label>
                                </div>
                                <div class="form-check form-switch mb-3">
                                    <input
                                        class="form-check-input"
                                        type="checkbox"
                                        id="modal-homework_account_value"
                                        name="homework_account_value"
                                        value="true"
                                    />
                                    <label class="form-check-label" for="modal-homework_account_value">원정대 1회 제한</label>
                                </div>
                                <input type="hidden" name="homework_id" id="modal-homework_id" />
                                <input type="hidden" name="member_id" value="${user.member_id}" />
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                            <button type="button" class="btn btn-success" id="modal-homework-edit-btn"><i class="far fa-edit"></i> 수정</button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 숙제 수정 모달 끝 -->
        </div>
    </body>
</html>
