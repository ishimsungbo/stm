package com.jui.stm.controller;

import com.jui.stm.dao.CoachingDao;
import com.jui.stm.dao.LookupDao;
import com.jui.stm.dao.SearchDao;
import com.jui.stm.dto.CoachingDTO;
import com.jui.stm.vo.CoachingVo;
import com.jui.stm.vo.LookupVo;
import com.jui.stm.vo.SearchVo;
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

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.sql.Date;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;

/**
 * Created by sungbo on 2015-11-04.
 */
@Controller
public class CoachingController {

    private static final Logger logger = LoggerFactory.getLogger(CoachingController.class);

    @Autowired
    private SqlSession sqlSession;

    @RequestMapping("coaching/coachingmain")
    public String coaChingMain(Model model,HttpSession session,HttpServletRequest request,
                               @ModelAttribute("coachingDTO") CoachingDTO coachingDTO,
            @RequestParam(required = false,value = "search_playerid") String playerid,
            @RequestParam(required = false,value = "search_fromdate") String fromdate,
            @RequestParam(required = false,value = "search_todate") String todate,
            @RequestParam(required = false,value = "search_coachinglevel") String coachinglevel,
            @RequestParam(required = false,value = "search_coachingtype") String coachingtype
    ,            @RequestParam(value = "pageNo", required = false) String pageNo
    )
            throws ClassCastException, SQLException, ParseException {

        coachingDTO.setPageSize(5);
        coachingDTO.setPageNo(1);

        int teamid = (Integer) session.getAttribute("teamid");

        CoachingDao coachingDao = sqlSession.getMapper(CoachingDao.class);

        SearchDao searchDao = sqlSession.getMapper(SearchDao.class);

        ArrayList<SearchVo> list = searchDao.plyaerNameList(teamid);

        coachingDTO.setTeamid(teamid);

        if(StringUtils.isNotEmpty(fromdate) && StringUtils.isNotEmpty(todate)){
            coachingDTO.setFromdate(fromdate);
            coachingDTO.setTodate(todate);
        }

        if(StringUtils.isNotEmpty(coachingtype)){
            coachingDTO.setCoachingtype(coachingtype);
        }

        if(StringUtils.isNotEmpty(coachinglevel)){
            coachingDTO.setCoachinglevel(coachinglevel);
        }

        if(StringUtils.isNotEmpty(playerid)){
            coachingDTO.setPlayerid(playerid);
        }

        if(StringUtils.isNotEmpty(pageNo)){
            coachingDTO.setPageNo(Integer.parseInt(pageNo));
        }

        coachingDTO.setBlockSize(5);


        coachingDTO.setTotalCount(coachingDao.totalCount(coachingDTO));
        ArrayList<CoachingVo> coachingVoArrayList = coachingDao.listCoachings(coachingDTO);

        logger.info("카운터 전체 : "+coachingDTO.getTotalCount());
        logger.info("카운터 전체 : "+coachingDao.totalCount(coachingDTO));
        logger.info("시작 :" + coachingDTO.getStartPageNo());
        logger.info("시작 :" + coachingDTO.getEndPageNo());

        //코칭기록 리스트
        model.addAttribute("list", coachingVoArrayList);


        ////////////////////////////////// DB select

        //코칭대상선수
        model.addAttribute("poslist", list);
        model.addAttribute("SearchVo",new SearchVo());

        LookupDao lookupDao = sqlSession.getMapper(LookupDao.class);
        //코칭종류 coachingList
        LookupVo levelvo = new LookupVo();

        model.addAttribute("coachinglevel",lookupDao.LookupFind("COACHINGLEVEL"));
        model.addAttribute("levelvo",levelvo);

        LookupVo typevo = new LookupVo();

        //코칭종류 coachingList
        model.addAttribute("coachingtype",lookupDao.LookupFind("COACHINGTYPE"));
        model.addAttribute("typevo",typevo);
        model.addAttribute("paging", coachingDTO);

        return "/coaching/coachingmain";
    }


    @RequestMapping(value = "coaching/coachinginsert")
    public String insertCoaching(Model model,HttpSession session) {


        int teamid = (Integer) session.getAttribute("teamid");
        SearchDao searchDao = sqlSession.getMapper(SearchDao.class);

        //코칭대상선수
        model.addAttribute("poslist",searchDao.plyaerNameList(teamid));
        model.addAttribute("CoachingVo",new CoachingVo());

        LookupDao lookupDao = sqlSession.getMapper(LookupDao.class);
        //코칭종류 coachingList
        LookupVo levelvo = new LookupVo();

        model.addAttribute("coachinglevel",lookupDao.LookupFind("COACHINGLEVEL"));
        model.addAttribute("levelvo",levelvo);

        LookupVo typevo = new LookupVo();

        //코칭종류 coachingList
        model.addAttribute("coachingtype",lookupDao.LookupFind("COACHINGTYPE"));
        model.addAttribute("typevo",typevo);

        return "/coaching/coachinginsert";
    }

    @RequestMapping(value = "dbwork/coinsert")
    public String coinsert(HttpServletRequest request,
                           HttpSession session,
                           @RequestParam("playerid") int playerid,
                           @RequestParam("cdate") Date cdate,
                           @RequestParam("coachinglevel") String coachinglevel,
                           @RequestParam("coachingtype") String coachingtype,
                           @RequestParam(required = false,value = "cause") String cause,
                           @RequestParam(required = false,value = "problem") String problem,
                           @RequestParam(required = false,value = "solution") String solution,
                           @RequestParam("recoachingflag") String recoachingflag,
                           @RequestParam("learnscore") int learnscore,
                           @RequestParam("subject") String subject

    ){

        CoachingVo coachingVo = new CoachingVo();

        coachingVo.setPlayerid(playerid);
        coachingVo.setDate(cdate);
        coachingVo.setCoachinglevel(coachinglevel);
        coachingVo.setCoachingtype(coachingtype);
        coachingVo.setLearnscore(learnscore);
        coachingVo.setRecoachingflag(recoachingflag);
        coachingVo.setTeamid((Integer) session.getAttribute("teamid"));
        coachingVo.setSolution(solution);
        coachingVo.setCause(cause);
        coachingVo.setProblem(problem);
        coachingVo.setSubject(subject);

        CoachingDao coachingDao = sqlSession.getMapper(CoachingDao.class);
        coachingDao.insert(coachingVo);

        return "redirect:" +"/coaching/coachingmain";
    }

    @RequestMapping(value = "coaching/coachingview")
    public String coachingview(HttpServletRequest request, Model model,HttpSession session){

        //실제 가져올 값
        CoachingDao dao =  sqlSession.getMapper(CoachingDao.class);

        int coachingid = Integer.parseInt(request.getParameter("coachingid"));
        CoachingVo coachingVo = new CoachingVo();

        coachingVo.setCoachingid(coachingid);

        model.addAttribute("coachingrow", dao.selectOnerow(coachingVo));

        //DB 선택값..컨트롤을 위한 코딩
        int teamid = (Integer) session.getAttribute("teamid");
        SearchDao searchDao = sqlSession.getMapper(SearchDao.class);

        //코칭대상선수
        model.addAttribute("poslist",searchDao.plyaerNameList(teamid));
        model.addAttribute("CoachingVo",new CoachingVo());

        LookupDao lookupDao = sqlSession.getMapper(LookupDao.class);
        //코칭종류 coachingList
        LookupVo levelvo = new LookupVo();

        model.addAttribute("coachinglevel",lookupDao.LookupFind("COACHINGLEVEL"));
        model.addAttribute("levelvo",levelvo);

        LookupVo typevo = new LookupVo();

        //코칭종류 coachingList
        model.addAttribute("coachingtype",lookupDao.LookupFind("COACHINGTYPE"));
        model.addAttribute("typevo", typevo);

        String upflag = request.getParameter("upflag");
        model.addAttribute("upflag",upflag);

        return "/coaching/coachingview";
    }


    @RequestMapping(value="coachingupdate.tr")
    public String coachingupdate(                           HttpSession session,
            @RequestParam("playerid") int playerid,
            @RequestParam("cdate") Date cdate,
            @RequestParam("coachinglevel") String coachinglevel,
            @RequestParam("coachingtype") String coachingtype,
            @RequestParam(required = false,value = "cause") String cause,
            @RequestParam(required = false,value = "problem") String problem,
            @RequestParam(required = false,value = "solution") String solution,
            @RequestParam("recoachingflag") String recoachingflag,
            @RequestParam("learnscore") int learnscore,
            @RequestParam("subject") String subject,
            @RequestParam("coachingid") int Coachingid
    ){

        logger.info("업데이트 로직 수행");

        CoachingVo coachingVo = new CoachingVo();
        coachingVo.setCoachingid(Coachingid);
        coachingVo.setPlayerid(playerid);
        coachingVo.setDate(cdate);
        coachingVo.setCoachinglevel(coachinglevel);
        coachingVo.setCoachingtype(coachingtype);
        coachingVo.setLearnscore(learnscore);
        coachingVo.setRecoachingflag(recoachingflag);
        coachingVo.setTeamid((Integer) session.getAttribute("teamid"));
        coachingVo.setSolution(solution);
        coachingVo.setCause(cause);
        coachingVo.setProblem(problem);
        coachingVo.setSubject(subject);

        CoachingDao coachingDao = sqlSession.getMapper(CoachingDao.class);
        coachingDao.update(coachingVo);

        logger.info("정상적으로 업데이트가 이루어짐");

        return "redirect:" +"/coaching/coachingview?coachingid="+coachingVo.getCoachingid()+"&upflag=Y";

    }

}
