package com.jui.stm.controller;

import com.jui.stm.dao.CalendarDao;
import com.jui.stm.dao.SptrainingDao;
import com.jui.stm.vo.CalendarVo;
import com.jui.stm.vo.SptrainingVo;
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
import java.sql.Date;
import java.text.SimpleDateFormat;

/**
 * Created by sungbo on 2015-12-13.
 */

@Controller
public class SptrController {

    @Autowired
    private SqlSession sqlSession;

    private static final Logger logger = LoggerFactory.getLogger(CoachingController.class);

    @RequestMapping("sptr/sptrmain")
    public String sptrMain( @RequestParam(value = "upflag",required = false) String upflag,
                           Model model,
                           HttpSession session
                           ){
        int teamid = (Integer) session.getAttribute("teamid");
        SptrainingDao sptrainingDao = sqlSession.getMapper(SptrainingDao.class);

        model.addAttribute("list",sptrainingDao.sptrainingList(teamid));
        model.addAttribute("upflag",upflag);
        return "/sptr/sptrmain";
    }

    @RequestMapping("sptr/sptrinsert")
    public String sptrInsert(){
        return "/sptr/sptrinsert";
    }

    @RequestMapping("sptr/sptrview")
    public String sptrview(
            Model model,
            @RequestParam("sptrid") int sptrid){
        logger.info("sptrview start");

        SptrainingVo sptrainingVo = new SptrainingVo();

        SptrainingDao sptrainingDao = sqlSession.getMapper(SptrainingDao.class);
        sptrainingVo = sptrainingDao.selectRow(sptrid);

        model.addAttribute("sptrainingVo",sptrainingVo);

        logger.info("sptrview end");
        return "/sptr/sptrview";
    }

    @RequestMapping("sptr/create")
    public String sptrDbcreate(HttpSession session,
                               @ModelAttribute("SptrainingVo") SptrainingVo sptrainingVo,
                               @RequestParam("efromdate") Date efdate,
                               @RequestParam("etodate") Date etodate,
                               Model model
    ){
        logger.info("sptrInsert start");
        int teamid = (Integer) session.getAttribute("teamid");
        sptrainingVo.setTeamid(teamid);
        sptrainingVo.setFromdate(efdate);
        sptrainingVo.setTodate(etodate);

        logger.info("시작 날짜? : " + sptrainingVo.getFromdate());
        logger.info("종료 날짜? : "+sptrainingVo.getTodate());
        logger.info("제목 ? : "+sptrainingVo.getSubject());
        logger.info("스케줄 플래그 : "+sptrainingVo.getAddscflag());

        //스케줄 옵션에 따라 실행
        if(sptrainingVo.getAddscflag()!="N"){
            logger.info("캘린더에 스케줄 추가");

            CalendarDao calendarDao = sqlSession.getMapper(CalendarDao.class);
            CalendarVo calendarVo = new CalendarVo();

            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            calendarVo.setStart(dateFormat.format(sptrainingVo.getFromdate()));
            calendarVo.setEnd(dateFormat.format(sptrainingVo.getTodate()));
            calendarVo.setTitle(sptrainingVo.getSubject());
            calendarVo.setTeamid(teamid);
            calendarVo.setColor("#0080ff");
            calendarDao.createSchedile(calendarVo);
        }

        //전지훈련 정보 생성
        SptrainingDao sptrainingDao = sqlSession.getMapper(SptrainingDao.class);

        sptrainingDao.insertSp(sptrainingVo);


        logger.info("sptrInsert end");
        return "redirect:" +"/sptr/sptrmain?upflag=I";
    }

    @RequestMapping("sptr/updateSP")
    public String updateSP(
            @ModelAttribute("SptrainingVo") SptrainingVo sptrainingVo,
            @RequestParam("efromdate") Date efromdate,
            @RequestParam("etodate") Date etodate    ){


        sptrainingVo.setFromdate(efromdate);
        sptrainingVo.setTodate(etodate);

        SptrainingDao dao = sqlSession.getMapper(SptrainingDao.class);
        dao.updateSp(sptrainingVo);

        return "redirect:" +"/sptr/sptrmain?upflag=U";
    }

    @RequestMapping("sptr/deleteSP")
    public String deleteSP(
            @RequestParam("sptrid") int sptrid
    ){
        logger.info("deleteSP Start");



        SptrainingDao sptrainingDao = sqlSession.getMapper(SptrainingDao.class);
        sptrainingDao.deleteSp(sptrid);

        logger.info("deleteSP end");
        return "redirect:" +"/sptr/sptrmain?upflag=D";
    }


}
