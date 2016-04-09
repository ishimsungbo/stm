package com.jui.stm.controller;

import com.jui.stm.dao.*;
import com.jui.stm.option.OexgameVo;
import com.jui.stm.query.vo.MatchForgameVo;
import com.jui.stm.query.vo.PlayerQueryListVo;
import com.jui.stm.vo.PlayerGameVo;
import com.jui.stm.vo.PlayerVo;
import com.jui.stm.vo.TrJrPlayerVo;
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

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * Created by sungbo on 2015-12-07.
 */
@Controller
public class AjaxController {

    @Autowired
    private SqlSession sqlSession;
    private static final Logger logger = LoggerFactory.getLogger(CommonController.class);

    //private static final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

    @RequestMapping(value= "ajax/getplayer", method= RequestMethod.GET)
    public @ResponseBody
    PlayerVo AjaxView(
            @RequestParam(required = false,value="id") int id)  {

        logger.info("AjaxController.AjaxView(player)");

        PlyearDao plyearDao = sqlSession.getMapper(PlyearDao.class);

        PlayerVo playerVo = plyearDao.selectOneP(id);

        //객체를 리턴한다.
        return playerVo;
    }

    @RequestMapping(value= "ajax/getteamplayers", method= RequestMethod.GET)
    public @ResponseBody
    List<TrJrPlayerVo> getteamplayers(
            @RequestParam(required = false,value="teamid") int teamid,
            @RequestParam(required = false,value="exclass") String exclass
            )  {

        logger.info("The Method is Starting. (AjaxController) : exclass" + exclass);

        PlayerVo playerVo = new PlayerVo();
        playerVo.setTeamid(teamid);

        Calendar cal= Calendar.getInstance();

        Date today = new Date();
        playerVo.setJoindate(cal.getTime());

        if(!exclass.equals("O")){
            playerVo.setExclass(exclass);
        }

        TrjrPlayerDao trjrPlayerDao = sqlSession.getMapper(TrjrPlayerDao.class);

        List<TrJrPlayerVo> daoList = trjrPlayerDao.tempPlayerlist(playerVo);

        logger.info("It's end");

        return daoList;
    }


    //개인경기 입력에서 사용할 리스트
    @RequestMapping(value= "ajax/getExgamelist", method= RequestMethod.GET)
    public @ResponseBody
    List<OexgameVo> getexGamelist(@RequestParam(required = false,value="teamid") int teamid) {

        logger.info("연습경기 정보 리스트 Start");

        OptionListDao optionListDao = sqlSession.getMapper(OptionListDao.class);
        List<OexgameVo> oexgameVos = optionListDao.exgameList(teamid);

        logger.info("연습경기 정보 리스트 End");

        return oexgameVos;
    }

    @RequestMapping("ajax/getPlayerList")
    public  @ResponseBody
    List<PlayerGameVo> getPlayerList(@RequestParam(required = false,value="teamid") int teamid){

        logger.info("요청한 팀 : "+teamid);

        PlayerGameDao playerGameDao = sqlSession.getMapper(PlayerGameDao.class);

        List<PlayerGameVo> playerGameVos = playerGameDao.teamPlayerList(teamid);


        logger.info("getPlayerList 종료");

        return playerGameVos;
    }

    @RequestMapping("ajax/getMatchs")
    public @ResponseBody
    List<MatchForgameVo> getMatchs(HttpSession session){
        logger.info("대회경기 자료를 가져옵니다.");
        int teamid = (Integer) session.getAttribute("teamid");
        MatchGamesDao matchGamesDao =  sqlSession.getMapper(MatchGamesDao.class);
        List<MatchForgameVo> vos =  matchGamesDao.matchList(teamid);
        logger.info("대회경기 자료 가져오기 끝");
        return vos;
    }

    @RequestMapping(value= "ajax/evalplayer", method= RequestMethod.GET)
    public @ResponseBody
    List<PlayerQueryListVo> evalplayer(
            @RequestParam(required = false,value="teamid") int teamid,
            @RequestParam(required = false,value="exclass") String exclass
    )  {

        PlyearDao mapper = sqlSession.getMapper(PlyearDao.class);

        PlayerQueryListVo vo = new PlayerQueryListVo();
        vo.setTeamid(teamid);

        if(!exclass.equals("O")){
            vo.setExclass(exclass);
        }

        List<PlayerQueryListVo> PlayerVo = mapper.getTeamPlayerList(vo);

        return PlayerVo;
    }


    //http://192.168.0.43:9090/stm/users 안드로이드에서 접근 하면 됩니다.
    @RequestMapping(value= "stm/users")
    public @ResponseBody
    ArrayList<UserVo> User(){

        UserDao userDao = sqlSession.getMapper(UserDao.class);
        ArrayList<UserVo> userVo = userDao.selectUser();

        //JSONArray jsonArray = new JSONArray();

        return userVo;
    }
}
