package com.jui.stm.common;

import com.jui.stm.dto.FindUserDto;
import org.apache.ibatis.session.SqlSession;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import javax.servlet.http.HttpSession;

/**
 * Created by Administrator on 2016-01-31.
 */
public class ConfirmValidator implements Validator{

    private SqlSession sqlSession;

    public SqlSession getSqlSession() {
        return sqlSession;
    }

    public void setSqlSession(SqlSession sqlSession) {
        this.sqlSession = sqlSession;
    }

    public HttpSession httpSession;

    public HttpSession getHttpSession() {
        return httpSession;
    }

    public void setHttpSession(HttpSession httpSession) {
        this.httpSession = httpSession;
    }


    @Override
    public boolean supports(Class aClass) {
        return false;
    }

    @Override
    public void validate(Object target, Errors errors) {

        FindUserDto findUserDto = (FindUserDto) target;

        if(!findUserDto.getPassword().equals(findUserDto.getPwdclone())){
            errors.rejectValue("pwdclone", "join.pwdclone.diff");
        }
        if(findUserDto.getEmailchecknum().equals("")){
            errors.rejectValue("emailchecknum", "join.emailchecknum.empty");
        }
        if(!findUserDto.getEmailchecknum().equals(httpSession.getAttribute("emailrandomnum"))){
            errors.rejectValue("emailchecknum", "join.emailchecknum.diff");
        }

    }
}
