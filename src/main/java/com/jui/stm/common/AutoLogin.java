package com.jui.stm.common;

import com.jui.stm.security.PreludebUserService;
import org.apache.commons.lang.StringUtils;
import org.apache.ibatis.session.SqlSession;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.WebAuthenticationDetails;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by Administrator on 2016-01-18.
 */
public class AutoLogin {

    private String userid;
    private String userpwd;
    private HttpServletRequest request;
    private SqlSession sqlSession;

    public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }

    public String getUserpwd() {
        return userpwd;
    }

    public void setUserpwd(String userpwd) {
        this.userpwd = userpwd;
    }

    public HttpServletRequest getRequest() {
        return request;
    }

    public void setRequest(HttpServletRequest request) {
        this.request = request;
    }

    public SqlSession getSqlSession() {
        return sqlSession;
    }

    public void setSqlSession(SqlSession sqlSession) {
        this.sqlSession = sqlSession;
    }

    public boolean setAuthentication(HttpServletRequest request,String userid, String userpwd){

        UsernamePasswordAuthenticationToken token = new UsernamePasswordAuthenticationToken(userid,userpwd);
        request.getSession();
        token.setDetails(new WebAuthenticationDetails(request));

        //자동로그인하기 2016-01-02 변경
        UserDetails userDetails = new PreludebUserService().loadUserByUsername(userid, sqlSession);


        //유저정보가 없다면 회워 가입 사이트로 이동한다.
        if(StringUtils.isEmpty(userDetails.getUsername())){
            return false;
        }else{
            //유저가 존재한다면 로그인을 시킨다
            UsernamePasswordAuthenticationToken auth = new UsernamePasswordAuthenticationToken(userDetails, userpwd, userDetails.getAuthorities());
            SecurityContextHolder.getContext().setAuthentication(auth);
            return true;
        }

    }


}
