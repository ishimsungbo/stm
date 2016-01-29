package com.jui.stm.controller;

import com.jui.stm.dao.CalendarDao;
import com.jui.stm.vo.CalendarVo;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by sungbo on 2015-11-16.
 */
@Controller
public class CommonController {

    private static final Logger logger = LoggerFactory.getLogger(CommonController.class);

    @Autowired
    private SqlSession sqlSession;

    @RequestMapping("mail/mailwrite")
    public String mailwrite(){
        logger.info("Mail Write method Start{}","test");
        return "/mail/mailwrite";
    }

    @RequestMapping("mail/mailsend")
    public String mainSend(){
        return "/mail/mailconfirm";
    }


    public void calenderCreate(SqlSession session,CalendarVo calendarVo){
        logger.info("캘린더 스케줄을 생성합니다");


        CalendarDao calendarDao = session.getMapper(CalendarDao.class);
        calendarDao.createSchedile(calendarVo);
        logger.info("캘린더 생성이 종료 되었습니다.");
    }

}


