package com.jui.stm.controller;

import com.jui.stm.dao.IndexPageDao;
import com.jui.stm.query.dto.QueryParam;
import com.jui.stm.query.vo.MainExgameQueryVo;
import com.jui.stm.query.vo.PhyResultVo;
import com.jui.stm.reports.ExgameDto;
import com.jui.stm.reports.ExgamePlayerDto;
import com.jui.stm.reports.PlayerAvgDto;
import com.jui.stm.vo.PlayerGameVo;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

/**
 * Created by sungbo on 2015-11-13.
 */
@Controller
public class ReportsController {

    private static final Logger logger = LoggerFactory.getLogger(ReportsController.class);
    @Autowired
    private SqlSession sqlSession;

    @RequestMapping(value= "report/exgamesData", method= RequestMethod.GET)
    public @ResponseBody
    ExgameDto getteamplayers(
            @RequestParam(required = false,value="teamid") int teamid,
            @RequestParam(required = false,value="exclass") String exclass,
            @RequestParam(required = false,value="fromdate") String fromdate,
            @RequestParam(required = false,value="todate") String todate
    )  {
        logger.info("ajax 연습경기 정보 요청 실행");
        IndexPageDao indexPageDao = sqlSession.getMapper(IndexPageDao.class);

        MainExgameQueryVo vo = new MainExgameQueryVo();

        vo.setTeamid(teamid);

        //선수클래스에 따른 데이터 조회
        if(exclass.equals("O")){ //O는 전체를 의미한다.
            logger.info("exclass 전체값을 조회 합니다.");
        }else{
            logger.info("exclass 개별값을 조회 합니다.");
            vo.setExclass(exclass);
        }

        //날짜에 따른 조회
        if(!fromdate.equals("0000-00-00")){
            vo.setFromdate(fromdate);
        }

        if(!todate.equals("0000-00-00")){
            vo.setTodate(todate);
        }


        logger.info("1." + vo.getTeamid());
        logger.info("2." + vo.getExclass());

        ExgameDto daoList = indexPageDao.exgameInfor(vo);
        logger.info("ajax 연습경기 정보 요청 종료 : " + daoList.getWincount());
        return daoList;
    }

    @RequestMapping(value= "report/gamesData", method= RequestMethod.GET)
    public @ResponseBody
    ExgameDto getGame(
            @RequestParam(required = false,value="teamid") int teamid,
            @RequestParam(required = false,value="exclass") String exclass,
            @RequestParam(required = false,value="fromdate") String fromdate,
            @RequestParam(required = false,value="todate") String todate,
            @RequestParam(required = false,value="matchid") int matchid
    )  {
        logger.info("ajax 연습경기 정보 요청 실행");
        IndexPageDao indexPageDao = sqlSession.getMapper(IndexPageDao.class);

        MainExgameQueryVo vo = new MainExgameQueryVo();

        vo.setTeamid(teamid);

        //선수클래스에 따른 데이터 조회
        if(exclass.equals("O")){ //O는 전체를 의미한다.
            logger.info("exclass 전체값을 조회 합니다.");
        }else{
            logger.info("exclass 개별값을 조회 합니다.");
            vo.setExclass(exclass);
        }

        //날짜에 따른 조회
        if(!fromdate.equals("0000-00-00")){
            vo.setFromdate(fromdate);
        }

        if(!todate.equals("0000-00-00")){
            vo.setTodate(todate);
        }


            vo.setMatchid(matchid);


        logger.info("1." + vo.getTeamid());
        logger.info("2." + vo.getExclass());

        ExgameDto daoList = indexPageDao.gameInfor(vo);
        logger.info("ajax 대회경기 평균 정보 요청 종료 : " + daoList.getWincount());
        return daoList;
    }


    @RequestMapping(value= "report/exgamesDataPlayer", method= RequestMethod.GET)
    public @ResponseBody
    ExgamePlayerDto getteamplayersavg(
            @RequestParam(required = false,value="teamid") int teamid,
            @RequestParam(required = false,value="exclass") String exclass,
            @RequestParam(required = false,value="fromdate") String fromdate,
            @RequestParam(required = false,value="todate") String todate,
            @RequestParam(required = false,value="playerid") int playerid
    )  {
        logger.info("ajax 연습경기 정보 요청 실행");
        IndexPageDao indexPageDao = sqlSession.getMapper(IndexPageDao.class);

        MainExgameQueryVo vo = new MainExgameQueryVo();

        vo.setTeamid(teamid);

        //선수클래스에 따른 데이터 조회
        if(exclass.equals("O")){ //O는 전체를 의미한다.
            logger.info("exclass 전체값을 조회 합니다.");
        }else{
            logger.info("exclass 개별값을 조회 합니다.");
            vo.setExclass(exclass);
        }

        vo.setPlayerid(playerid);

        //날짜에 따른 조회
        if(!fromdate.equals("0000-00-00")){
            vo.setFromdate(fromdate);
        }

        if(!todate.equals("0000-00-00")){
            vo.setTodate(todate);
        }

        logger.info("1." + vo.getTeamid());
        logger.info("2." + vo.getExclass());

        ExgamePlayerDto daoList = indexPageDao.exgamePlayer(vo);
        return daoList;
    }

    @RequestMapping(value= "report/gamesDataPlayer", method= RequestMethod.GET)
    public @ResponseBody
    ExgamePlayerDto getGamePlayerAvg(
            @RequestParam(required = false,value="teamid") int teamid,
            @RequestParam(required = false,value="exclass") String exclass,
            @RequestParam(required = false,value="fromdate") String fromdate,
            @RequestParam(required = false,value="todate") String todate,
            @RequestParam(required = false,value="playerid") int playerid,
            @RequestParam(required = false,value="matchid") int matchid
    )  {
        logger.info("ajax 대회경기 선수 평균 스킬정보 요청 실행 시작");
        IndexPageDao indexPageDao = sqlSession.getMapper(IndexPageDao.class);

        MainExgameQueryVo vo = new MainExgameQueryVo();

        vo.setTeamid(teamid);

        //선수클래스에 따른 데이터 조회
        if(exclass.equals("O")){ //O는 전체를 의미한다.
            logger.info("exclass 전체값을 조회 합니다.");
        }else{
            logger.info("exclass 개별값을 조회 합니다.");
            vo.setExclass(exclass);
        }

        vo.setPlayerid(playerid);

        //날짜에 따른 조회
        if(!fromdate.equals("0000-00-00")){
            vo.setFromdate(fromdate);
        }

        if(!todate.equals("0000-00-00")){
            vo.setTodate(todate);
        }

            vo.setMatchid(matchid);


        logger.info("1." + vo.getTeamid());
        logger.info("2." + vo.getExclass());

        logger.info("ajax 대회경기 선수 평균 스킬정보 요청 실행 종료");
        ExgamePlayerDto daoList = indexPageDao.gamePlayer(vo);
        return daoList;
    }


    @RequestMapping("reports/reportmain")
    public String ReportsMain(HttpSession session,Model model){

        int teamid = (Integer) session.getAttribute("teamid");

        System.out.println("teamid : "+ teamid);

        return "reports/reportmain";
    }

    @RequestMapping(value= "report/playerAvgeval", method= RequestMethod.GET)
    public @ResponseBody
    List<PlayerAvgDto> getteamplayersavg(HttpSession session,
                                         @RequestParam(required = false,value="fromdate") String fromdate,
                                         @RequestParam(required = false,value="todate") String todate
                                         ){

        logger.info("팀(선수)의 정기평가 자료를 가져옵니다. 시작");
        int teamid = (Integer) session.getAttribute("teamid");

        PlayerAvgDto playerAvgDto = new PlayerAvgDto();
        playerAvgDto.setTeamid(teamid);

        //날짜에 따른 조회
        if(!fromdate.equals("0000-00-00")){
            logger.info("평가 정보 시작일자가 셋팅됩니다.");
            playerAvgDto.setFromdate(fromdate);
        }

        if(!todate.equals("0000-00-00")){
            logger.info("평가 정보 종료일자가 셋팅됩니다.");
            playerAvgDto.setTodate(todate);
        }

        IndexPageDao pageDao = sqlSession.getMapper(IndexPageDao.class);
        List<PlayerAvgDto> dtos = pageDao.playerRegulareval(playerAvgDto);
        logger.info("팀(선수)의 정기평가 자료를 가져옵니다. 종료" + dtos.size());
        return dtos;
    }

    @RequestMapping("reports/phyplayerAvg")
    public @ResponseBody
    PhyResultVo getPhyPlayerAvg(@RequestParam(required = false,value="teamid") int teamid,
                                   @RequestParam(required = false,value="exclass") String exclass,
                                   @RequestParam(required = false,value="fromdate") String fromdate,
                                   @RequestParam(required = false,value="todate") String todate
                                   ){

        logger.info("선수들의 신체평균을 가져옵니다.시작");

        IndexPageDao indexPageDao = sqlSession.getMapper(IndexPageDao.class);

        QueryParam param = new QueryParam();

        if(!fromdate.equals("0000-00-00")){
            SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");
            try {
                param.setFromdate(transFormat.parse(fromdate));
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }

        if(!todate.equals("0000-00-00")){
            SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");
            try {
                param.setTodate(transFormat.parse(todate));
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }

        if(!exclass.equals("O")){
            param.setExclass(exclass);
        }

        param.setTeamid(teamid);
        PhyResultVo lineVo = indexPageDao.avgPhyinfo(param);

        logger.info("선수들의 신체평균을 가져옵니다. 끝");
        return lineVo;
    }


    //선수정보중 자신의 연습경기 실력과 평균을 비교
    @RequestMapping(value= "report/exgamePavg", method= RequestMethod.GET)
    public @ResponseBody
    List<ExgamePlayerDto> getPlayerExgameAvg(
            @RequestParam(required = false,value="teamid") int teamid,
            @RequestParam(required = false,value="exclass") String exclass,
            @RequestParam(required = false,value="fromdate") String fromdate,
            @RequestParam(required = false,value="todate") String todate,
            @RequestParam(required = false,value="playerid") int playerid
    )  {
        logger.info("ajax 연습경기 정보 요청 실행");
        IndexPageDao indexPageDao = sqlSession.getMapper(IndexPageDao.class);

        MainExgameQueryVo vo = new MainExgameQueryVo();

        vo.setTeamid(teamid);

        //선수클래스에 따른 데이터 조회
        if(exclass.equals("O")){ //O는 전체를 의미한다.
            logger.info("exclass 전체값을 조회 합니다.");
        }else{
            logger.info("exclass 개별값을 조회 합니다.");
            vo.setExclass(exclass);
        }

        vo.setPlayerid(playerid);

        //날짜에 따른 조회
        if(!fromdate.equals("0000-00-00")){
            vo.setFromdate(fromdate);
        }

        if(!todate.equals("0000-00-00")){
            vo.setTodate(todate);
        }

        logger.info("1." + vo.getTeamid());
        logger.info("2." + vo.getExclass());

        List<ExgamePlayerDto> daoList = indexPageDao.exgamePlayerAppear(vo);
        return daoList;
    }

    @RequestMapping("report/gamePlayerAvg")
    public @ResponseBody List<PlayerGameVo> playerAvg(
            @RequestParam(required = false,value="teamid") int teamid,
            @RequestParam(required = false,value="playerid") int playerid){

        logger.info("선수의 정식경기 평균 값을 가져옵니다. 시작");

        IndexPageDao indexPageDao = sqlSession.getMapper(IndexPageDao.class);

        MainExgameQueryVo vo = new MainExgameQueryVo();
        vo.setPlayerid(playerid);
        vo.setTeamid(teamid);

        List<PlayerGameVo> gameVos = indexPageDao.gamePlayerAvg(vo);

        logger.info("선수의 정식경기 평균 값을 가져옵니다. 끝");

        return gameVos;
    }



}
