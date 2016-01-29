package com.jui.stm.controller;

import com.jui.stm.dao.IndexPageDao;
import com.jui.stm.dao.UserDao;
import com.jui.stm.dto.FindUserDto;
import com.jui.stm.query.vo.MainExgameQueryVo;
import com.jui.stm.reports.ExgameDto;
import com.jui.stm.vo.UserVo;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Created by Administrator on 2016-01-15.
 */
@Controller
public class ValidationController {

    private static final Logger logger = LoggerFactory.getLogger(ReportsController.class);

    @Autowired
    private SqlSession sqlSession;

    @RequestMapping(value= "validation/checkemail", method= RequestMethod.GET)
    public @ResponseBody
    int checkEmail(@RequestParam("email")String email)  {

        logger.info("이메일을 체크합니다.시작" + email);

        UserDao userDao = sqlSession.getMapper(UserDao.class);

        int count = userDao.emailCheck(email);

        logger.info("이메일을 체크합니다. 끝 : " + count);
        return count;
    }
}
