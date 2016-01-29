package com.jui.stm.controller;

import com.jui.stm.dao.MeetingDao;
import com.jui.stm.dto.MeetingDTO;
import com.jui.stm.vo.CalendarVo;
import com.jui.stm.vo.MeetingVo;
import org.apache.commons.lang.StringUtils;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.text.ParseException;
import java.text.SimpleDateFormat;

/**
 * Created by sungbo on 2015-12-25.
 */
@Controller
public class MeetingController {

    private static final Logger logger = LoggerFactory.getLogger(MainController.class);

    @Autowired
    private SqlSession sqlSession;

    @RequestMapping("meeting/meetmain")
    public String meetMain(HttpSession session,
                           Model model,
                           @ModelAttribute("MeetingDao") MeetingDTO meetingDTO,
                           @RequestParam(required = false,value = "pageNo") String pageNo,
                           @RequestParam(required = false,value = "upflag") String upflag,
                           @RequestParam(required = false,value = "search_subject") String search_subject,
                           @RequestParam(required = false,value = "search_fromdate") String search_fromdate,
                           @RequestParam(required = false,value = "search_todate") String search_todate,
                           @RequestParam(required = false,value = "search_meetingtype") String search_meetingtype,
                           @RequestParam(required = false,value = "search_personcount") String search_personcount
    ){

        logger.info("meetMain 컨트롤러 시작");
        meetingDTO.setTeamid((Integer) session.getAttribute("teamid"));
        meetingDTO.setPageSize(5);  // 한 페이지에 보일 게시글 수
        meetingDTO.setPageNo(1);     // 현재 페이지 번호
        meetingDTO.setBlockSize(5);

        if(StringUtils.isNotEmpty(search_personcount)){
            int personcount=0;
            personcount  = Integer.parseInt(search_personcount);
            if(personcount != 0){
                meetingDTO.setPersoncount(personcount);
            }
            logger.info("훈련시간 분은 : "+meetingDTO.getPersoncount());
        }

        if(StringUtils.isNotEmpty(search_fromdate) && StringUtils.isNotEmpty(search_todate)){
            meetingDTO.setFromdate(search_fromdate);
            meetingDTO.setTodate(search_todate);
        }


        if(StringUtils.isNotEmpty(search_subject)){
            meetingDTO.setSubject(search_subject);
        }

        if(StringUtils.isNotEmpty(search_meetingtype)){
            meetingDTO.setMeetingtype(search_meetingtype);
        }


        if(StringUtils.isNotEmpty(pageNo)){
            meetingDTO.setPageNo(Integer.parseInt(pageNo));
        }

        MeetingDao meetingDao = sqlSession.getMapper(MeetingDao.class);

        meetingDTO.setTotalCount(meetingDao.selectCount(meetingDTO));
        model.addAttribute("list",meetingDao.selectList(meetingDTO));

        model.addAttribute("paging",meetingDTO);
        model.addAttribute("pageNo",pageNo);
        model.addAttribute("upflag", upflag);

        logger.info("meetMain 컨트롤러 종료");
        return "/meeting/meetmain";
    }

    @RequestMapping("meeting/meetinsert")
    public String meetinsert(){

        return "/meeting/meetinsert";
    }

    @RequestMapping("trjournals/dbinsert")
    public String dbInsert(HttpSession session,
            @ModelAttribute("meetingVo")MeetingVo meetingVo,
            @RequestParam("exfromdate") String exfromdate,
            @RequestParam("extodate") String extodate
    ){
        logger.info("dbInsert 컨트롤러 종료");
        MeetingDao meetingDao = sqlSession.getMapper(MeetingDao.class);

        int teamid = (Integer) session.getAttribute("teamid");
        meetingVo.setTeamid(teamid);

        SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");

        try {
            // 스트링 타입을 => 데이트 타입으로 변경해준다.
            meetingVo.setFromdate(transFormat.parse(exfromdate));
            meetingVo.setTodate(transFormat.parse(extodate));
        } catch (ParseException e) {
            e.printStackTrace();
        }

/*        logger.info("1.:"+meetingVo.getFromdate());
        logger.info("2.:"+meetingVo.getTodate());
        logger.info("3.:"+meetingVo.getDescription());
        logger.info("4.:"+meetingVo.getContent());
        logger.info("5.:"+meetingVo.getMeetingtype());
        logger.info("6.:"+meetingVo.getSubject());
        logger.info("7.:"+meetingVo.getTeamid());
        logger.info("8.:"+meetingVo.getScheduleflag());*/

        meetingDao.insert(meetingVo);

        if(meetingVo.getScheduleflag().equals("Y")){
            //캘린더 생성
            CommonController commonController = new CommonController();

            CalendarVo calendarVo = new CalendarVo();
            calendarVo.setTeamid(teamid);
            calendarVo.setStart(exfromdate);
            calendarVo.setEnd(extodate);
            calendarVo.setTitle("회의 : "+meetingVo.getSubject());
            calendarVo.setColor("#8080ff");

            commonController.calenderCreate(sqlSession,calendarVo);
        }

        logger.info("dbInsert 컨트롤러 종료");
        return "redirect:" +"/meeting/meetmain?upflag=I";
    }

    @RequestMapping("meeting/updateview")
    public String updateView(){
        logger.info("updateView 컨트롤러 시작");


        logger.info("updateView 컨트롤러 종료");
        return "meeting/updateview";
    }

}
