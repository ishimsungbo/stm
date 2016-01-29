package com.jui.stm.controller;

import com.jui.stm.dao.CalendarDao;
import com.jui.stm.vo.CalendarVo;
import net.sf.json.JSONArray;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;

//import net.sf.json.JSONArray;

/**
 * Created by sungbo on 2015-11-02.
 */
@Controller
public class ScheduleControlle {

    private static final Logger logger = LoggerFactory.getLogger(ScheduleControlle.class);
    @Autowired
    private SqlSession sqlSession;

/*    @RequestMapping("schedule/schedulemain")
    public ModelAndView schedule(HttpServletRequest request) throws Exception{


        ModelAndView modelAndView = new ModelAndView("/schedule/schedulemain");
        modelAndView.addObject("body","schedules place");
        return modelAndView;
    }*/

    @RequestMapping("schedule/schedulemain")
    public String schedule(HttpServletRequest request,HttpSession session,Model model) throws Exception{

        JSONArray jsonArray = new JSONArray();
        CalendarDao calendarDao =  sqlSession.getMapper(CalendarDao.class);
        int teamid = (Integer) session.getAttribute("teamid");
        ArrayList<CalendarVo> list = calendarDao.list(teamid);


        model.addAttribute("jsonList", jsonArray.fromObject(list));


        return "/schedule/schedulemain";
    }


    @RequestMapping("schedule/addday")
    public String addday( @ModelAttribute("calendarVo") CalendarVo calendarVo,HttpSession session){

        logger.info("스케줄 추가 컨트롤러 시작");

        int teamid = (Integer) session.getAttribute("teamid");

        /*
        CalendarVo calendarVo = new CalendarVo();
        calendarVo.setTitle(request.getParameter("title"));
        calendarVo.setStart(request.getParameter("start"));
        calendarVo.setEnd(request.getParameter("end"));
        calendarVo.setContent(request.getParameter("content"));
        */

        calendarVo.setTeamid(teamid);

        CalendarDao calendarDao = sqlSession.getMapper(CalendarDao.class);
        calendarDao.createSchedile(calendarVo);

        logger.info("스케줄정보가 입력되었습니다.");

        return "redirect:"+"/schedule/schedulemain";
    }

    @RequestMapping("schedule/modify")
    public String schedule(@ModelAttribute("calendarVo") CalendarVo calendarVo,HttpSession session){

        int teamid = (Integer) session.getAttribute("teamid");
        calendarVo.setTeamid(teamid);
        CalendarDao calendarDao = sqlSession.getMapper(CalendarDao.class);

        logger.info("액션 값은 : "+calendarVo.getFlag());

        if(
                calendarVo.getFlag().equals("삭제")
                ){
            logger.info("삭제합니다");
            calendarDao.deleteRow(calendarVo);
        }else{
            logger.info("업데이트합니다");
            calendarDao.updateRow(calendarVo);
        }


        return "redirect:"+"/schedule/schedulemain";
    }


    //test
    @RequestMapping("schedule/addschdule")
    public String addScdule(){
        return "/schedule/testCalendar";
    }

    @RequestMapping("schedule/acetest")
    public String acetest(){

        return "/schedule/acetest";
    }

}
