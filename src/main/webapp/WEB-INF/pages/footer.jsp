<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="stm" uri="http://www.springframework.org/tags" %>
<div class="row">
    <div class="col-md-8"></div>
    <div class="col-md-4">
        <a data-toggle="tooltip" data-placement="top" title="Go! Facebook STMsoccer Service Page"
           href="https://www.facebook.com/stmsoccer/?ref=hl" target="_blank"><img src="/resources/footer/facebook.png" width="25" height="25"/></a>
        <stm:eval expression="@version['version_name']"/> /
        <stm:eval expression="@version['version_info']"/> /
        <stm:eval expression="@version['last_update']"/>
    </div>
</div>
<div class="stm-footerline"></div>
<div class="row">
</div>
