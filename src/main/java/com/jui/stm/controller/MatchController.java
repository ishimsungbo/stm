package com.jui.stm.controller;

import com.jui.stm.dao.MatchDao;
import com.jui.stm.dto.MeetingDTO;
import com.jui.stm.vo.CalendarVo;
import com.jui.stm.vo.MatchsVo;
import org.apache.commons.lang.StringUtils;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by Administrator on 2016-01-09.
 */
@Controller
public class MatchController {

    private static final Logger logger = LoggerFactory.getLogger(MatchController.class);

    @Autowired
    private SqlSession sqlSession;

    @RequestMapping("match/matchmain")
    public String matchMain(@ModelAttribute("MeetingDao") MeetingDTO meetingDTO,
                            @RequestParam(required = false,value = "pageNo") String pageNo,
                            @RequestParam(required = false,value = "upflag") String upflag,
                            @RequestParam(required = false,value = "search_fromdate") String search_fromdate,
                            @RequestParam(required = false,value = "search_todate") String search_todate,
                            @RequestParam(required = false,value = "search_name") String search_name,
                            @RequestParam(required = false,value = "search_location") String search_location,
                            @RequestParam(required = false,value = "search_exclass") String search_exclass,
                            Model model,HttpSession session
    ){
        logger.info("MatchController.matchmain 컨트롤러 시작");
        meetingDTO.setTeamid((Integer) session.getAttribute("teamid"));
        meetingDTO.setPageSize(5);  // 한 페이지에 보일 게시글 수
        meetingDTO.setPageNo(1);     // 현재 페이지 번호
        meetingDTO.setBlockSize(5);
        if(StringUtils.isNotEmpty(pageNo)){
            meetingDTO.setPageNo(Integer.parseInt(pageNo));
        }


        if(StringUtils.isNotEmpty(search_fromdate) && StringUtils.isNotEmpty(search_todate)){
            meetingDTO.setFromdate(search_fromdate);
            meetingDTO.setTodate(search_todate);
        }
        if(StringUtils.isNotEmpty(search_name)){
            meetingDTO.setName(search_name);
        }

        if(StringUtils.isNotEmpty(search_location)){
            meetingDTO.setLocation(search_location);
        }

        if(StringUtils.isNotEmpty(search_exclass)){
            meetingDTO.setExclass(search_exclass);
        }

        MatchDao matchDao = sqlSession.getMapper(MatchDao.class);

        meetingDTO.setTotalCount(matchDao.selectCount(meetingDTO));

        model.addAttribute("list", matchDao.selectList(meetingDTO));

        model.addAttribute("paging", meetingDTO);
        model.addAttribute("pageNo",pageNo);
        model.addAttribute("upflag",upflag);

        logger.info("MatchController.matchmain 컨트롤러 종료");
        return "/match/matchmain";
    }

    @RequestMapping("match/matchnew")
    public String matchNew(){

        return "/match/matchnew";
    }

    @RequestMapping("match/matchcreate")
    public String matchCreate(
            @ModelAttribute("matchsVo") MatchsVo matchsVo,
            @RequestParam(required = false,value = "scheduleflag") String scheduleflag,
            HttpSession session
    ){

        logger.info("대회정보 입력시작 : " + scheduleflag +" "+ matchsVo.getName());

        int teamid = (Integer) session.getAttribute("teamid");

        matchsVo.setTeamid(teamid);

        MatchDao matchDao = sqlSession.getMapper(MatchDao.class);
        matchDao.matchInsert(matchsVo);


        if(scheduleflag.equals("Y")) {
            //스케줄을 생성한다.
            CalendarVo calendarVo = new CalendarVo();
            //시작일 종료일
            calendarVo.setTeamid(teamid);
            calendarVo.setStart(matchsVo.getEfromdate());
            calendarVo.setEnd(matchsVo.getEtodate());
            calendarVo.setTitle("대회명 : " + matchsVo.getName());
            calendarVo.setColor("#b8d1e9");

            CommonController commonController = new CommonController();
            commonController.calenderCreate(sqlSession, calendarVo);
        }

        logger.info("대회정보 입력종료 : ");


        return "redirect:" +"/match/matchmain?upflag=I";
    }

    @RequestMapping("match/matchview")
    public String matchview(
            @RequestParam("matchid") int matchid,
            HttpSession session,
            Model model
    ){

        int teamid = (Integer) session.getAttribute("teamid");

        MatchDao matchDao = sqlSession.getMapper(MatchDao.class);

        MatchsVo matchsVo = matchDao.matchOne(teamid,matchid);

        model.addAttribute("matchsVo", matchsVo);
        return "match/matchview";
    }

    @RequestMapping("match/matchupdate")
    public String matchUpdate(
            @ModelAttribute("matchsVo") MatchsVo matchsVo
    ){
        logger.info("MatchController.matchupdate 시작");
        MatchDao matchDao = sqlSession.getMapper(MatchDao.class);

        //원래 자료를 비교하기 위해 가져옵니다.
        MatchsVo matchvoOriginal = matchDao.matchOne(matchsVo.getTeamid(),matchsVo.getMatchid());

        if(matchvoOriginal.getName().equals(matchsVo.getName())){
            matchsVo.setName(null);
        }

        if(matchvoOriginal.getFromdate().equals(matchsVo.getFromdate())){
            matchsVo.setFromdate(null);
        }

        if(matchvoOriginal.getTodate().equals(matchsVo.getTodate())){
            matchsVo.setTodate(null);
        }

        if(matchvoOriginal.getLocation().equals(matchsVo.getLocation())){
            matchsVo.setLocation(null);
        }

        if(matchvoOriginal.getDescription().equals(matchsVo.getDescription())){
            matchsVo.setDescription(null);
        }

        if(matchvoOriginal.getExclass().equals(matchsVo.getExclass())){
            matchsVo.setExclass(null);
        }

        if(matchvoOriginal.getGoal().equals(matchsVo.getGoal())){
            matchsVo.setGoal(null);
        }

        if(matchvoOriginal.getPreparation().equals(matchsVo.getPreparation())){
            matchsVo.setPreparation(null);
        }

        if(matchvoOriginal.getSatisfaction().equals(matchsVo.getSatisfaction())){
            matchsVo.setSatisfaction(null);
        }

        if(matchvoOriginal.getLack().equals(matchsVo.getLack())){
            matchsVo.setLack(null);
        }

        if(matchvoOriginal.getFormation().equals(matchsVo.getFormation())){
            matchsVo.setFormation(null);
        }

        matchDao.matchUpdate(matchsVo);
        logger.info("MatchController.matchupdate 종료");

        return "redirect:" +"/match/matchmain?upflag=U";
    }

    @RequestMapping("match/delete")
    public String delete(
            @RequestParam("matchid") int matchid,HttpSession session
    ){
        int teamid = (Integer) session.getAttribute("teamid");
        logger.info("MatchController.matchupdate 시작");
        MatchDao matchDao = sqlSession.getMapper(MatchDao.class);
        matchDao.delete(teamid,matchid);
        logger.info("MatchController.matchupdate 종료");

        return "redirect:" +"/match/matchmain?upflag=D";
    }


    //String 타입의 날짜를 자동으로 변환해준다네?
    @InitBinder
    protected void iniBinder(WebDataBinder binder){
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat,true));
    }





}
