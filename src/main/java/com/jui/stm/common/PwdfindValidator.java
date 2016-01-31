package com.jui.stm.common;

import com.jui.stm.dao.UserDao;
import com.jui.stm.dto.FindUserDto;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

public class PwdfindValidator implements Validator {

    private SqlSession sqlSession;

    public SqlSession getSqlSession() {
        return sqlSession;
    }

    public void setSqlSession(SqlSession sqlSession) {
        this.sqlSession = sqlSession;
    }

    private static final Logger logger = LoggerFactory.getLogger(PwdfindValidator.class);

    @Override
    public boolean supports(Class aClass) {
        return false;
    }

    @Override
    public void validate(Object target, Errors errors) {

        FindUserDto dto = (FindUserDto) target;
        UserDao userDao = getSqlSession().getMapper(UserDao.class);

        int count = userDao.getSnsUser(dto.getEmail(),dto.getUserid());

        if (count == 0) {
            logger.info("입력하신 아이디와 이메일에 대한 계정이 없습니다");
            //첫번째 인자가 꼭 vo에 있어야 한다
            errors.rejectValue("userid", "join.account.empty");
        }
    }
}
