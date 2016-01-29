package com.jui.stm.common;

import com.jui.stm.controller.CoachingController;
import com.jui.stm.dao.UserDao;
import com.jui.stm.vo.UserVo;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;


public class JoinValidator implements Validator{

    private SqlSession sqlSession;

    public SqlSession getSqlSession() {
        return sqlSession;
    }

    public void setSqlSession(SqlSession sqlSession) {
        this.sqlSession = sqlSession;
    }

    private static final Logger logger = LoggerFactory.getLogger(CoachingController.class);



    @Override
    public boolean supports(Class aClass) {
        return false;
    }

    @Override
    public void validate(Object target, Errors errors) {
        UserVo user = (UserVo) target;

        if (user.getUserid().equals("")){
            errors.rejectValue("userid", "join.userid.empty");
        }else{
            if (user.getUserid().length() > 15 || user.getUserid().length() < 4) {
                errors.rejectValue("userid", "join.userid.length");
            }
        }

        if(user.getEmail().equals("")){
            errors.rejectValue("email", "join.email.empty");
        }
        if(user.getPassword().equals("")){
            errors.rejectValue("password", "join.pwd.empty");
        }

        logger.info("이메일을 체크 하기위한 SQLDAO 시작");
        UserDao userDao = getSqlSession().getMapper(UserDao.class);
        logger.info("이메일을 체크 하기위한 SQLDAO 종료");
        int count =  userDao.emailCheck(user.getEmail());

        if(count > 0 ){
            errors.rejectValue("email", "join.email.exist");
        }

    }

}
