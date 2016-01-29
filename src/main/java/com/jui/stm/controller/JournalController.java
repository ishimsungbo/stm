package com.jui.stm.controller;

import com.jui.stm.dao.JounalTimeLineDao;
import com.jui.stm.dao.TrJrsDao;
import com.jui.stm.dao.TrProgramDao;
import com.jui.stm.dao.TrjrPlayerDao;
import com.jui.stm.dto.PagingDTO;
import com.jui.stm.vo.*;
import net.sf.json.JSONArray;
import org.apache.commons.lang.StringUtils;
import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.MyBatisSystemException;
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
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by sungbo on 2015-12-21.
 *  훈련일지 관련 컨트롤러
 */
@Controller
public class JournalController {

    private static final Logger logger = LoggerFactory.getLogger(MainController.class);

    @Autowired
    private SqlSession sqlSession;

    //훈련일지 메인
    @RequestMapping("trjournals/trjournalmain")
    public String trjournalMain(
            Model model,
            HttpSession session,
            @ModelAttribute("pagingDTO") PagingDTO pagingDTO,
            @RequestParam(value = "pageNo", required = false) String pageNo,
            @RequestParam(value = "upflag", required = false) String upflag,
            @RequestParam(value = "search_fromdate", required = false) String search_fromdate,
            @RequestParam(value = "search_todate", required = false) String search_todate,
            @RequestParam(value = "search_exclass", required = false) String exclass,
            @RequestParam(value = "search_weather", required = false) String weather,
            @RequestParam(value = "search_concept", required = false) String concept,
            @RequestParam(value = "search_location", required = false) String location
    ){
        logger.info("trjournalMain 컨트롤러 시작");
        pagingDTO.setTeamid((Integer) session.getAttribute("teamid"));
        pagingDTO.setPageSize(5);  // 한 페이지에 보일 게시글 수
        pagingDTO.setPageNo(1);     // 현재 페이지 번호
        pagingDTO.setBlockSize(5);

        if(StringUtils.isNotEmpty(search_fromdate) && StringUtils.isNotEmpty(search_todate)){
            pagingDTO.setFromdate(search_fromdate);
            pagingDTO.setTodate(search_todate);
        }

        if(StringUtils.isNotEmpty(exclass)){
            logger.info("1.값이 있어?");
            pagingDTO.setExclass(exclass);
        }

        if(StringUtils.isNotEmpty(weather)){
            logger.info("2.값이 있어?");
            pagingDTO.setWeather(weather);
        }

        if(StringUtils.isNotEmpty(concept)){
            pagingDTO.setConcept(concept);
        }

        if(StringUtils.isNotEmpty(location)){
            pagingDTO.setLocation(location);
        }

        if(StringUtils.isNotEmpty(pageNo)){
            pagingDTO.setPageNo(Integer.parseInt(pageNo));
        }

        TrJrsDao trJrsDao = sqlSession.getMapper(TrJrsDao.class);

        pagingDTO.setTotalCount(trJrsDao.totalCount(pagingDTO));
        model.addAttribute("list", trJrsDao.selectList(pagingDTO));

        model.addAttribute("pageNo",pageNo);
        model.addAttribute("upflag",upflag);
        model.addAttribute("paging",pagingDTO);

        logger.info("trjournalMain 컨트롤러 종료");
        return "/trjournals/trjournalmain";
    }

    //훈련일지 입력
    @RequestMapping("trjournals/jrinsertview")
    public String insertView(HttpSession session,Model model){
        logger.info("insertView 컨트롤러 시작");

        int teamid = (Integer) session.getAttribute("teamid");

        TrProgramDao trProgramDao = sqlSession.getMapper(TrProgramDao.class);

        JSONArray jsonArray = new JSONArray();
        model.addAttribute("trprogram", jsonArray.fromObject(trProgramDao.trProgramSelect(teamid)));


        //select list를 automation으로 하기 위한 설정이나 사용안함.
//        TrProVo trProVo = new TrProVo();
//        model.addAttribute("trProVos",trProgramDao.trProgramSelect(teamid));
//        model.addAttribute("trProVo",trProVo);

        List<TrtimeLineList> trtimeLineLists = new ArrayList<TrtimeLineList>();


        TrjrPlayerDao trjrPlayerDao =  sqlSession.getMapper(TrjrPlayerDao.class);

        PlayerVo playerVo = new PlayerVo();
        playerVo.setTeamid(teamid);

        //가져온것
        List<TrJrPlayerVo> daoList = trjrPlayerDao.tempPlayerlist(playerVo);

        //담을것
        TrJrPlayerList trJrPlayerList = new TrJrPlayerList();

        for (int i=0; daoList.size() > i ; i++)
        {
            logger.info("선수들 이름은 : "+daoList.get(i).getPlayername());
            trJrPlayerList.setTrJrPlayerVos(daoList);
        }
        model.addAttribute("playerlist",trJrPlayerList);

        model.addAttribute("teamid",teamid);
        logger.info("insertView 컨트롤러 종료");



        return "/trjournals/jrinsertview";
    }

    //훈련일지 보기(수정/삭제)
    @RequestMapping("trjournals/jrview")
    public String jrView(Model model
                        ,@RequestParam("jeid") int jeid){
        logger.info("jrView 컨트롤러 시작");

        TrJrsDao trJrsDao = sqlSession.getMapper(TrJrsDao.class);
        JounalTimeLineDao lineDao = sqlSession.getMapper(JounalTimeLineDao.class);
        TrjrPlayerDao trjrPlayerDao = sqlSession.getMapper(TrjrPlayerDao.class);

        model.addAttribute("trJrdata",trJrsDao.selectRowdata(jeid));
        model.addAttribute("line",lineDao.selectRowdata(jeid));
        model.addAttribute("playerlist",trjrPlayerDao.selectRowdata(jeid));

        logger.info("jrView 컨트롤러 종료");
        return "/trjournals/jrview";
    }


    //디비 업데이트 로직 처리 메소드
    @RequestMapping("trjournals/insert")
    public String insert(@ModelAttribute TrjournalVo trjournalVo, //헤더
                         @ModelAttribute TrtimeLineList lineList, //훈련타임라인
                         @ModelAttribute TrJrPlayerList playerList, //훈련참여인원 정보
                         @RequestParam("date") String date,
                         HttpServletRequest request,HttpSession session) throws Exception,MyBatisSystemException{
        logger.info("insert 컨트롤러 시작");


        for (int i=0; lineList.getTimelineVos().size() > i ; i++)
        {
            logger.info("훈련라인번호  : " + lineList.getTimelineVos().get(i).getLinenum());
            logger.info("훈련프로그램아이디  : " + lineList.getTimelineVos().get(i).getTrainingid());
            logger.info("훈련시간  : " + lineList.getTimelineVos().get(i).getTrminute());
            logger.info("훈련만족도  : " + lineList.getTimelineVos().get(i).getSatisfaction());
            logger.info("설명  : " + lineList.getTimelineVos().get(i).getDescription());
        }

        logger.info("선수 훈련 정보 배열의 사이즈는 : " + playerList.getTrJrPlayerVos().size());

        for (int i=0; playerList.getTrJrPlayerVos().size() > i; i++ ){
            logger.info("1.Player value playerid : " + playerList.getTrJrPlayerVos().get(i).getPlayerid());
            logger.info("2.Player value teamid : " + playerList.getTrJrPlayerVos().get(i).getTeamid());
            logger.info("3.Player value injury flag : " + playerList.getTrJrPlayerVos().get(i).getInjury());
            logger.info("4.Player value Satisfaction : " + playerList.getTrJrPlayerVos().get(i).getSatisfaction());
        }

        logger.info("헤더 생성 시작");

        int teamid = (Integer) session.getAttribute("teamid");
        trjournalVo.setTeamid(teamid);

        SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

        logger.info("시간포맷 문제 발생?" + date);

        try {
            // 스트링 타입을 => 데이트 타입으로 변경해준다.
            trjournalVo.setTrdate(transFormat.parse(date));
        } catch (ParseException e) {
            logger.info("문제 발생?");
            e.printStackTrace();
        }

        TrJrsDao trJrsDao = sqlSession.getMapper(TrJrsDao.class);
        JounalTimeLineDao lineDao = sqlSession.getMapper(JounalTimeLineDao.class);
        TrjrPlayerDao playerDao = sqlSession.getMapper(TrjrPlayerDao.class);
        trJrsDao.insert(trjournalVo);

        logger.info("헤더 생성 종료");

        //훈련타임라인을 인설트 함
        logger.info("Time line Create Start" + lineList.getTimelineVos().size());
        for (int i=0; lineList.getTimelineVos().size() > i ; i++){

            TrjrtimelineVo trjrtimelineVo = new TrjrtimelineVo();
            trjrtimelineVo.setJeid(trjournalVo.getJeid());
            trjrtimelineVo.setTeamid(teamid);

            trjrtimelineVo.setTimelineid(lineList.getTimelineVos().get(i).getTimelineid());
            trjrtimelineVo.setDescription(lineList.getTimelineVos().get(i).getDescription());
            trjrtimelineVo.setTrminute(lineList.getTimelineVos().get(i).getTrminute());
            trjrtimelineVo.setSatisfaction(lineList.getTimelineVos().get(i).getSatisfaction());
            trjrtimelineVo.setLinenum(i+1);

            if(lineList.getTimelineVos().get(i).getTrainingid() > 0) {
                trjrtimelineVo.setTrainingid(lineList.getTimelineVos().get(i).getTrainingid());
            }

            lineDao.insert(trjrtimelineVo);

        }
        logger.info("Time line create End");

        logger.info("Player Create Start==========================================================" + playerList.getTrJrPlayerVos().size());
        for (int i=0; playerList.getTrJrPlayerVos().size() > i; i++ ){

            TrJrPlayerVo vo = new TrJrPlayerVo();

            logger.info(" 참석여부 값은 : "+playerList.getTrJrPlayerVos().get(i).getStatus());
            logger.info(" 부상여부 값은 : "+playerList.getTrJrPlayerVos().get(i).getInjury());
            vo.setTeamid(teamid);
            vo.setJeid(trjournalVo.getJeid());
            vo.setPlayerid(playerList.getTrJrPlayerVos().get(i).getPlayerid());
            vo.setStatus(playerList.getTrJrPlayerVos().get(i).getStatus());
            vo.setSatisfaction(playerList.getTrJrPlayerVos().get(i).getSatisfaction());
            vo.setDescription(playerList.getTrJrPlayerVos().get(i).getDescription());
            vo.setInjurydesc(playerList.getTrJrPlayerVos().get(i).getInjurydesc());
            vo.setInjury(playerList.getTrJrPlayerVos().get(i).getInjury());

            playerDao.insert(vo);

        }
        logger.info("Player Create End==========================================================");

        logger.info("insert 컨트롤러 종료");
        return "redirect:" +"/trjournals/trjournalmain?upflag=I";
    }

    @RequestMapping("trjournals/delete")
    public String delete(@RequestParam("jeid") int jeid){
        logger.info("delete 컨트롤러 시작");

        TrJrsDao dao = sqlSession.getMapper(TrJrsDao.class);

        dao.deleteHeader(jeid);
        dao.deleteTimeLine(jeid);
        dao.deletePlayer(jeid);

        logger.info("delete 컨트롤러 종료");
        return "redirect:" +"/trjournals/trjournalmain?upflag=D";
    }

    @RequestMapping("trjournals/update")
    public String update(@ModelAttribute TrjournalVo trjournalVo,
                         @RequestParam("date") String date){

        logger.info("update 컨트롤러 시작" + trjournalVo.getJeid());

        SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");

        try {
            // 스트링 타입을 => 데이트 타입으로 변경해준다.
            trjournalVo.setTrdate(transFormat.parse(date));
        } catch (ParseException e) {
            e.printStackTrace();
        }


        TrJrsDao trJrsDao =  sqlSession.getMapper(TrJrsDao.class);

        //원본 데이터
        TrjournalVo vo = trJrsDao.selectRowdata(trjournalVo.getJeid());

        //변경관련 비교해보기
        if(vo.getExclass().equals(trjournalVo.getExclass())){
            trjournalVo.setExclass(null);
        }
        if(vo.getLocation().equals(trjournalVo.getLocation())){
            trjournalVo.setLocation(null);
        }
        if(vo.getPerformer().equals(trjournalVo.getPerformer())){
            trjournalVo.setPerformer(null);
        }
        if(vo.getConcept().equals(trjournalVo.getConcept())){
            trjournalVo.setConcept(null);
        }
        if(vo.getConceptobject().equals(trjournalVo.getConceptobject())){
            trjournalVo.setConceptobject(null);
        }

        if(vo.getGood().equals(trjournalVo.getGood())){
            trjournalVo.setGood(null);
        }
        if(vo.getInsufficiency().equals(trjournalVo.getInsufficiency())){
            trjournalVo.setInsufficiency(null);
        }
        if(vo.getWeather().equals(trjournalVo.getWeather())){
            trjournalVo.setWeather(null);
        }
        if(vo.getTrdate().equals(trjournalVo.getTrdate())){
            trjournalVo.setTrdate(null);
        }

        trJrsDao.updateHeader(trjournalVo);

        logger.info("update 컨트롤러 종료");
        return "redirect:" +"/trjournals/trjournalmain?upflag=U";
    }

}
