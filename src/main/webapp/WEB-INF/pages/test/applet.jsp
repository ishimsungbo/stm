<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>선수등록</title>
    <link rel="stylesheet" href="/resources/stm.css">
    <link rel="stylesheet" href="/resources/bootstrap-3.3.2-dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="/resources/bootstrap-3.3.2-dist/css/bootstrap-theme.css">
    <script src="/resources/bootstrap-3.3.2-dist/js/jquery-1.11.3.min.js"></script>
    <script src="/resources/bootstrap-3.3.2-dist/js/bootstrap.min.js"></script>

    <script type="text/javascript">
        function previewImage(input) {
            var preview = document.getElementById('preview');

            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    preview.setAttribute('src', e.target.result);
                }
                reader.readAsDataURL(input.files[0]);
            } else {
                preview.setAttribute('src', '/resources/img/140+140.svg');
            }
        }

        function open_file(){
            frm.file.click();
        }

    </script>


    <style>

        .img-thumbnail {
            display: inline-block;
            /*width: 140px;*/
            /*height: 140px;*/
            /*max-width: 100%;*/
            /*height: auto;*/
            padding: 4px;
            line-height: 1.42857143;
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 4px;
            -webkit-transition: all .2s ease-in-out;
            -o-transition: all .2s ease-in-out;
            transition: all .2s ease-in-out;
        }

        .col-2{
            style="font-size: 13px; color: #333"
        }


    </style>
</head>

<body class="stmbody">
<header>
    <%@ include file="../headerpage.jsp"%>
</header>

<article>
    <section class="page-subject">
        <h2>등록선수 리스트</h2>
    </section>

    <section style="margin: 10px" class="highlight_white">
        <script>
            $(function () {
                $('[data-toggle="tooltip"]').tooltip()
            })
        </script>
        <table class="table table-hover">
            <thead>
            <tr>
                <th>사진</th>
                <th>이름</th>
                <th>공격/수비</th>
                <th>포지션</th>
                <th>입단일자</th>
                <th>소속상태</th>
                <th>탈퇴일자</th>
                <th>대회참가 횟수</th>
                <th>연습경기참가 횟수</th>
            </tr>
            </thead>
            <%--<td colspan="4" style="text-align: center" class="warning">연습경기 정보가 존재하지 않습니다!</td>--%>
            <tbody>
            <c:if test="${list.size() != 0}">
                <c:forEach items="${list}" var="plyear">
                    <tr data-toggle="tooltip" data-placement="left" title="${plyear.description}">
                        <td><img src="/resources/img/player/${plyear.picture}" alt="${plyear.picture}" width="50px" height="50px" /></td>
                        <td><a href="/player/playerper?playerid=${plyear.playerid}">${plyear.playername}</a></td>
                        <td class="text-center">${plyear.positioncategory}</td>
                        <td class="text-center">${plyear.positioncode}</td>
                        <td> <fmt:formatDate value="${plyear.joindate}" pattern="yyyy년 MM월 dd일"/></td>
                        <td class="text-center">${plyear.status}</td>
                        <td class="text-center"> <fmt:formatDate value="${plyear.withdrawdate}" pattern="yyyy년 MM월 dd일"/></td>
                        <td class="text-center">10</td>
                        <td class="text-center">20</td>
                    </tr>
                </c:forEach>
            </c:if>

            <c:if test="${list.size() == 0}">
                <tr>
                    <td colspan="9" style="text-align: center" class="warning">팀에 소속된 선수가 없습니다</td>
                </tr>
            </c:if>
            </tbody>
        </table>

        <%--게시물 pagenation--%>

        <nav style="text-align: center">
            <ul class="pagination">
                <li>

                    <a href="#" aria-label="Previous">
                        <span aria-hidden="true">&laquo;</span>
                    </a>

                </li>
                <c:forEach items="${list}" var="plyear">
                    <li><a href="#">1</a></li>
                </c:forEach>
                <li>

                    <a href="#" aria-label="Next">
                        <span aria-hidden="true">&raquo;</span>
                    </a>
                </li>
            </ul>
        </nav>

    </section>
</article>



<footer>



</footer>


</body>
</html>
