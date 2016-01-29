package com.jui.stm.controller;


import com.jui.stm.dao.ExGameDao;
import com.jui.stm.dto.PagingDTO;
import com.jui.stm.query.dao.SpidoptionDao;
import com.jui.stm.vo.CalendarVo;
import com.jui.stm.vo.ExGameVo;
import net.sf.json.JSONArray;
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
import java.text.ParseException;
import java.text.SimpleDateFormat;

@Controller
public class ExgameController {

    @Autowired
    private SqlSession sqlSession;

    private static final Logger logger = LoggerFactory.getLogger(CoachingController.class);

    @RequestMapping("exgame/exgamemain")
    public String exGameMain(Model model,
                             HttpSession session,
                             @ModelAttribute("pagingDTO") PagingDTO pagingDTO
            ,@RequestParam(required = false,value = "search_fromdate") String search_fromdate
            ,@RequestParam(required = false,value = "search_todate") String search_todate
            ,@RequestParam(required = false,value = "search_oppoteam") String oppoteam
            ,@RequestParam(required = false,value = "search_weather") String weather
            ,@RequestParam(required = false,value = "search_location") String location
            ,@RequestParam(required = false,value = "search_result") String result
            ,@RequestParam(required = false,value = "search_formation") String formation
            ,@RequestParam(required = false,value = "search_exclass") String exclass
            ,@RequestParam(value = "pageNo", required = false) String pageNo
            ,@RequestParam(value = "upflag", required = false) String upflag
                             ){

        pagingDTO.setTeamid((Integer) session.getAttribute("teamid"));
        pagingDTO.setPageSize(5);  // 한 페이지에 보일 게시글 수
        pagingDTO.setPageNo(1);     // 현재 페이지 번호
        pagingDTO.setBlockSize(5);

        if(StringUtils.isNotEmpty(search_fromdate)){
            pagingDTO.setFromdate(search_fromdate);
        }

        if(StringUtils.isNotEmpty(search_todate)){
            pagingDTO.setTodate(search_todate);
        }

        if(StringUtils.isNotEmpty(oppoteam)){
            pagingDTO.setOppoteam(oppoteam);
        }

        if(StringUtils.isNotEmpty(weather)){
            pagingDTO.setWeather(weather);
        }

        if(StringUtils.isNotEmpty(location)){
            pagingDTO.setLocation(location);
        }

        if(StringUtils.isNotEmpty(result)){
            pagingDTO.setResult(result);
        }

        if(StringUtils.isNotEmpty(formation)){
            pagingDTO.setFormation(formation);
        }

        if(StringUtils.isNotEmpty(exclass)){
            pagingDTO.setExclass(exclass);
        }

        if(StringUtils.isNotEmpty(pageNo)){
            pagingDTO.setPageNo(Integer.parseInt(pageNo));
        }

        logger.info("팀아이디는 : " + pagingDTO.getTeamid());
        logger.info("시작 숫자 : " + pagingDTO.getStartRowNum());
        logger.info("끝 숫자 : " + pagingDTO.getPageSize());

        ExGameDao exGameDao = sqlSession.getMapper(ExGameDao.class);

        pagingDTO.setTotalCount(exGameDao.getExgameCount(pagingDTO));
        model.addAttribute("list", exGameDao.selectList(pagingDTO));

        model.addAttribute("paging", pagingDTO);
        model.addAttribute("upflag",upflag);
        return "/exgame/exgamemain";
    }

    @RequestMapping("exgame/exinsert")
    public String exInsert(HttpSession session,Model model){

        //전지훈련정보를 json으로 넘긴다.
        int teamid = (Integer) session.getAttribute("teamid");

        SpidoptionDao spidoptionDao  =  sqlSession.getMapper(SpidoptionDao.class);
        JSONArray jsonArray = new JSONArray();


        model.addAttribute("jsonList", jsonArray.fromObject(spidoptionDao.getSelect(teamid)));
        return "/exgame/exinsert";
    }

    @RequestMapping(value = "exgame/dbexinsert")
    public String exdbInsert(HttpServletRequest request,
                             HttpSession session,
                             @ModelAttribute("ExGameVo") ExGameVo exGameVo,
                             @RequestParam("date") String date){

        logger.info("Sptrid : "+exGameVo.getSptrid());

        ExGameDao exGameDao = sqlSession.getMapper(ExGameDao.class);

        int teamid = (Integer) session.getAttribute("teamid");

        exGameVo.setTeamid(teamid);

        SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

        try {
            // 스트링 타입을 => 데이트 타입으로 변경해준다.
            exGameVo.setExgamedate(transFormat.parse(date));
        } catch (ParseException e) {
            logger.info("문제 발생?");
            e.printStackTrace();
        }


        int wteamat = exGameVo.getFhwrecord() + exGameVo.getShwrecord(); //우리팀
        int oteamat = exGameVo.getFhorecord() + exGameVo.getShorecord(); //상대팀

        if (wteamat > oteamat){
            exGameVo.setResult("W");
        }else if(wteamat < oteamat){
            exGameVo.setResult("L");
        }else{
            exGameVo.setResult("E");
        }
        exGameDao.insert(exGameVo);


        if(exGameVo.getScheduleflag().equals("Y")) {
            //스케줄을 생성한다.
            CalendarVo calendarVo = new CalendarVo();
            //시작일 종료일
            calendarVo.setTeamid(teamid);
            calendarVo.setStart(date);
            calendarVo.setEnd(date);
            calendarVo.setTitle("연습경기 : " + exGameVo.getOppoteam());
            calendarVo.setColor("purple");

            CommonController commonController = new CommonController();
            commonController.calenderCreate(sqlSession, calendarVo);
        }

        return "redirect:" +"/exgame/exgamemain?upflag=I";
    }

    @RequestMapping("exgame/exgameview")
    public String gameView(Model model,HttpSession session,@RequestParam int exgameid
            ,@RequestParam(required = false, value = "upflag") String upflag){

        ExGameDao exGameDao = sqlSession.getMapper(ExGameDao.class);
        SpidoptionDao spidoptionDao  =  sqlSession.getMapper(SpidoptionDao.class);

        int teamid = (Integer) session.getAttribute("teamid");

        ExGameVo exGameVo = new ExGameVo();
        exGameVo.setExgameid(exgameid);

        JSONArray jsonArray = new JSONArray();
        model.addAttribute("jsonList", jsonArray.fromObject(spidoptionDao.getSelect(teamid)));

        model.addAttribute("exgame", exGameDao.selectOne(exGameVo));
        model.addAttribute("upflag", upflag);
        return "/exgame/exgameview";
    }

    @RequestMapping("exgame/delete")
    public String delete(@RequestParam("exgameid") int exgameid){

        ExGameDao gameDao = sqlSession.getMapper(ExGameDao.class);
        gameDao.deleteRow(exgameid);

        return "redirect:" +"/exgame/exgamemain?upflag=D";
    }

    @RequestMapping("exgame/exupdate")
    public String upDate(@ModelAttribute("ExGameVo") ExGameVo exGameVo,
                         @RequestParam("gamedate") Date date){

        logger.info("업데이트 시작");

        ExGameDao exGameDao = sqlSession.getMapper(ExGameDao.class);

        //현재DB에 있는 자료를 가져온다
        ExGameVo dbexGameVo = new ExGameVo();
        dbexGameVo = exGameDao.selectOne(exGameVo);

        logger.info("Step 01");

        //dbexGameVo 와 같지 않는 컬럼만 업데이트를 해주기 위해 비교한 후 update문을 사용한다.
        if(dbexGameVo.getOppoteam().equals(exGameVo.getOppoteam())) {
            exGameVo.setOppoteam(null);
        }

        if(dbexGameVo.getExgamedate().equals(date)) {
            exGameVo.setExgamedate(null);
        }else{
            exGameVo.setExgamedate(date);
        }

        if(dbexGameVo.getExclass().equals(exGameVo.getExclass())){
            exGameVo.setExclass(null);
        }

        if(dbexGameVo.getLocation().equals(exGameVo.getLocation())){
            exGameVo.setLocation(null);
        }

        if(dbexGameVo.getWeather().equals(exGameVo.getWeather())){
            exGameVo.setWeather(null);
        }

        if(dbexGameVo.getResult().equals(exGameVo.getResult())){
            exGameVo.setResult(null);
        }

        if(dbexGameVo.getFormation().equals(exGameVo.getFormation())){
            exGameVo.setFormation(null);
        }

        if(dbexGameVo.getWeather().equals(exGameVo.getWeather())){
            exGameVo.setWeather(null);
        }

        if(dbexGameVo.getObjectpoint().equals(exGameVo.getObjectpoint())){
            exGameVo.setObjectpoint(null);
        }

        if(dbexGameVo.getFw_description().equals(exGameVo.getFw_description())){
            exGameVo.setFw_description(null);
        }

        if(dbexGameVo.getMf_description().equals(exGameVo.getMf_description())){
            exGameVo.setMf_description(null);
        }
        if(dbexGameVo.getDf_description().equals(exGameVo.getDf_description())){
            exGameVo.setDf_description(null);
        }
        if(dbexGameVo.getDescription().equals(exGameVo.getDescription())) {
            exGameVo.setDescription(null);
        }
        if(dbexGameVo.getYoutubesource().equals(exGameVo.getYoutubesource())) {
            exGameVo.setYoutubesource(null);
        }
        logger.info("Step 02");

        exGameDao.update(exGameVo);

        logger.info("Step 03");

        return "redirect:" +"/exgame/exgameview?upflag=Y&exgameid="+exGameVo.getExgameid();
    }

}
