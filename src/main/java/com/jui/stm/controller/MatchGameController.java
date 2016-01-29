package com.jui.stm.controller;

import com.jui.stm.common.GameValidator;
import com.jui.stm.dao.MatchDao;
import com.jui.stm.dao.MatchGamesDao;
import com.jui.stm.dao.PlayerGameDao;
import com.jui.stm.dto.PagingDTO;
import com.jui.stm.query.vo.MatchForgameVo;
import com.jui.stm.vo.*;
import net.sf.json.JSONArray;
import org.apache.commons.lang.StringUtils;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2016-01-11.
 */

@Controller
public class MatchGameController {

    private static final Logger logger = LoggerFactory.getLogger(MatchController.class);

    @Autowired
    private SqlSession sqlSession;


    /*
    @InitBinder
    protected void iniBinder(WebDataBinder binder){
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }*/



    @RequestMapping("matchgame/matchgame")
    public String gameMain(
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
            ,@RequestParam(value = "upflag", required = false) String upflag,
            @RequestParam(value = "search_matchid", required = false )  String matchid
            ,Model model,HttpSession session,HttpServletRequest request
    ){

        logger.info("gameMain(matchgame) 컨트롤러 시작 ");
        int teamid = (Integer) session.getAttribute("teamid");


        logger.info("1대회 아이디는 : " + matchid);
        try{

            if(!matchid.equals("")){
                int ematchid= Integer.parseInt(matchid);
                pagingDTO.setMatchid(ematchid);

            }}catch (Exception e){

            int ematchid= 0;
            pagingDTO.setMatchid(0);
        }
        logger.info("2대회 아이디는 : " + pagingDTO.getMatchid());

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

        MatchGamesDao matchGamesDao = sqlSession.getMapper(MatchGamesDao.class);

        pagingDTO.setTotalCount(matchGamesDao.getMatchCount(pagingDTO));
        List<GameVo> gameVos =  matchGamesDao.gameList(pagingDTO);
        model.addAttribute("list",gameVos);


        //대회명을 리스트로 선택할 수 있도록 자료를 넘긴다.
        MatchsVo matchsVo = new MatchsVo();

        model.addAttribute("matchList",matchGamesDao.matchList(teamid));
        model.addAttribute("matchsVo",matchsVo);
        model.addAttribute("upflag", upflag);
        model.addAttribute("paging",pagingDTO);

        logger.info("gameMain(matchgame) 컨트롤러 종료 ");

        return "/matchgame/matchgame";
    }

    @RequestMapping("matchgame/matchgnew")
    public String matchGnew(HttpSession session,Model model){

        int teamid = (Integer) session.getAttribute("teamid");
        MatchGamesDao matchGamesDao =  sqlSession.getMapper(MatchGamesDao.class);
        List<MatchForgameVo> vos =  matchGamesDao.matchList(teamid);

        JSONArray jsonArray = new JSONArray();

        model.addAttribute("matchslist",jsonArray.fromObject(vos));
        return "matchgame/matchgnew";
    }

    @RequestMapping("matchgame/matchinsert")
    public String matchInsert(@ModelAttribute GameVo gameVo,
                              @RequestParam("date") String date,
                              BindingResult bindingResult,
                              Model model,
                              HttpSession session){

        logger.info("대회경기 자료를 생성합니다.");
        MatchGamesDao gameDao = sqlSession.getMapper(MatchGamesDao.class);
        MatchDao dao = sqlSession.getMapper(MatchDao.class);


        if(bindingResult.hasErrors()) {
            logger.info("밸리데이션에 걸렸습니다.");
            model.addAttribute("gameVo", gameVo);
            model.addAttribute("date",date);
            return "/matchgame/matchgnew";
        }

        int teamid = (Integer) session.getAttribute("teamid");
        gameVo.setTeamid(teamid);

        MatchsVo matchsVo = dao.matchOne(teamid,gameVo.getMatchid());

        SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        try {
            gameVo.setGamedate(transFormat.parse(date));
            gameVo.setEgamedate(date);
        } catch (ParseException e) {
            e.printStackTrace();
        }

        int wteamat = gameVo.getFhwrecord() + gameVo.getShwrecord(); //우리팀
        int oteamat = gameVo.getFhorecord() + gameVo.getShorecord(); //상대팀

        if (wteamat > oteamat){
            gameVo.setResult("W");
        }else if(wteamat < oteamat){
            gameVo.setResult("L");
        }else{
            gameVo.setResult("E");
        }

        logger.info(gameVo.toString());

        GameValidator gameValidator = new GameValidator();
        gameValidator.validate(gameVo, bindingResult);

        if(gameVo.getScheduleflag().equals("Y")) {

            //스케줄을 생성한다.
            CalendarVo calendarVo = new CalendarVo();
            //시작일 종료일
            calendarVo.setTeamid(teamid);
            calendarVo.setStart(date);
            calendarVo.setEnd(date);
            calendarVo.setTitle(gameVo.getOppoteam() +" - "+matchsVo.getName());
            calendarVo.setColor("#3F51B5");

            CommonController commonController = new CommonController();
            commonController.calenderCreate(sqlSession, calendarVo);
        }

        gameDao.insertGame(gameVo);

        logger.info("대회경기 자료 입력 작업이 종료 됩니다.");

        return "redirect:" +"/matchgame/matchgame?upflag=I";
    }

    @RequestMapping("matchgame/matchgameup")
    public String upView(Model model,
                         HttpSession session,
                         @RequestParam("gameid") int gameid){
        int teamid = (Integer) session.getAttribute("teamid");
        MatchGamesDao matchGamesDao = sqlSession.getMapper(MatchGamesDao.class);


        GameVo gameVo = matchGamesDao.gameRow(gameid);
        model.addAttribute("gameVo", gameVo);

        //json 대회경기정보가져오기
        List<MatchForgameVo> vos =  matchGamesDao.matchList(teamid);
        JSONArray jsonArray = new JSONArray();
        model.addAttribute("matchids", jsonArray.fromObject(vos));

        return "/matchgame/matchgameup";
    }

    @RequestMapping("matchgame/matchupdate")
    public String update(@ModelAttribute GameVo gameVo,
                         @RequestParam("date") String date,
                         BindingResult bindingResult,
                         Model model,
                         HttpSession session
    ){

        logger.info("대회경기 자료를 업데이트 합니다." + date);

        MatchGamesDao gameDao = sqlSession.getMapper(MatchGamesDao.class);

        if(bindingResult.hasErrors()) {
            logger.info("밸리데이션에 걸렸습니다.");
            model.addAttribute("gameVo", gameVo);
            model.addAttribute("date",date);
            return "/matchgame/matchgnew";
        }

        Date lvdate;

        MatchGamesDao gamesDao = sqlSession.getMapper(MatchGamesDao.class);
        GameVo dbgameVo = gamesDao.gameRow(gameVo.getGameid());

        SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        try {
            lvdate = transFormat.parse(date);

            if(dbgameVo.getGamedate()==lvdate) {
                gameVo.setGamedate(null);
            }else{
                gameVo.setGamedate(lvdate);
            }

        } catch (ParseException e) {
            e.printStackTrace();
        }

        if(dbgameVo.getOppoteam().equals(gameVo.getOppoteam())) {
            gameVo.setOppoteam(null);
        }


        if(dbgameVo.getExclass().equals(gameVo.getExclass())){
            gameVo.setExclass(null);
        }

        if(dbgameVo.getLocation().equals(gameVo.getLocation())){
            gameVo.setLocation(null);
        }

        if(dbgameVo.getWeather().equals(gameVo.getWeather())){
            gameVo.setWeather(null);
        }

        if(dbgameVo.getResult().equals(gameVo.getResult())){
            gameVo.setResult(null);
        }

        if(dbgameVo.getFormation().equals(gameVo.getFormation())){
            gameVo.setFormation(null);
        }

        if(dbgameVo.getWeather().equals(gameVo.getWeather())){
            gameVo.setWeather(null);
        }

        if(dbgameVo.getFw_description().equals(gameVo.getFw_description())){
            gameVo.setFw_description(null);
        }

        if(dbgameVo.getMf_description().equals(gameVo.getMf_description())){
            gameVo.setMf_description(null);
        }
        if(dbgameVo.getDf_description().equals(gameVo.getDf_description())){
            gameVo.setDf_description(null);
        }
        if(dbgameVo.getDescription().equals(gameVo.getDescription())) {
            gameVo.setDescription(null);
        }
        if(dbgameVo.getYoutubesource().equals(gameVo.getYoutubesource())) {
            gameVo.setYoutubesource(null);
        }

        if(dbgameVo.getMatchid()==gameVo.getMatchid()) {
            gameVo.setYoutubesource(null);
        }

        int wteamat = gameVo.getFhwrecord() + gameVo.getShwrecord(); //우리팀
        int oteamat = gameVo.getFhorecord() + gameVo.getShorecord(); //상대팀

        if (wteamat > oteamat){
            gameVo.setResult("W");
        }else if(wteamat < oteamat){
            gameVo.setResult("L");
        }else{
            gameVo.setResult("E");
        }

        logger.info("Update function is start Games");
        MatchGamesDao matchGamesDao = sqlSession.getMapper(MatchGamesDao.class);
        matchGamesDao.update(gameVo);
        logger.info("대회경기 자료를 업데이트 종료");

        return "redirect:" +"/matchgame/matchgame?upflag=U";
    }

    @RequestMapping("matchgame/gameplayer")
    public String insertView(HttpSession session,
                             Model model,
                             @RequestParam(required = false,value = "gameid") int gameid,
                             @RequestParam(required = false,value = "playercount") int playercount){

        logger.info("대회경기입력시작" + playercount);
        int teamid = (Integer) session.getAttribute("teamid");

        PlayerGameDao playerGameDao = sqlSession.getMapper(PlayerGameDao.class);
        JSONArray jsonArray = new JSONArray();

        if(playercount == 0) {
            List<PlayerGameVo> playerGameVos = playerGameDao.gamePlayer(teamid, gameid);
            for (int i = 0; i < playerGameVos.size(); i++) {
                playerGameVos.get(i).setGameid(gameid);
            }
            model.addAttribute("playerGameVos", jsonArray.fromObject(playerGameVos));
        }else{
            model.addAttribute("UpplayerGameVos", jsonArray.fromObject(playerGameDao.getGamePlayerList(gameid)));
        }

        model.addAttribute("teamid");
        model.addAttribute("gameid",gameid);
        model.addAttribute("playercount",playercount);

        logger.info("대회경기입력종료");
        return "/matchgame/gameplayer";
    }

    @RequestMapping("matchgame/playerinsert")
    public String insertDb(@ModelAttribute PlayerGameList playerGameList,
                           HttpServletRequest request,
                           HttpSession session){

        int teamid = (Integer) session.getAttribute("teamid");
        String pageflag = request.getParameter("pageflag");

        logger.info("플레이어 연습경기 정보 인설트 시작");
        logger.info("총 레코드 수는: " + playerGameList.getPlayerGameVos().size());
        logger.info("신규 or 수정: " + pageflag);

        PlayerGameDao playerGameDao = sqlSession.getMapper(PlayerGameDao.class);

        if(pageflag.equals("update")){
            logger.info("기존자료를 삭제합니다.");
            playerGameDao.gamedelete(playerGameList.getPlayerGameVos().get(0).getGameid());
        }

        for(int i=0; i < playerGameList.getPlayerGameVos().size(); i++){

            PlayerGameVo playerGameVo = new PlayerGameVo();
            playerGameVo.setTeamid(teamid);
            playerGameVo.setPlayerid(playerGameList.getPlayerGameVos().get(i).getPlayerid());

            playerGameVo.setGameid(playerGameList.getPlayerGameVos().get(i).getGameid());

            playerGameVo.setGameid(playerGameList.getPlayerGameVos().get(i).getGameid());
            playerGameVo.setIntime(playerGameList.getPlayerGameVos().get(i).getIntime());
            playerGameVo.setBacknumber(playerGameList.getPlayerGameVos().get(i).getBacknumber());
            playerGameVo.setControll(playerGameList.getPlayerGameVos().get(i).getControll());
            playerGameVo.setDefensive(playerGameList.getPlayerGameVos().get(i).getDefensive());
            playerGameVo.setGood(playerGameList.getPlayerGameVos().get(i).getGood());
            playerGameVo.setOffensive(playerGameList.getPlayerGameVos().get(i).getOffensive());
            playerGameVo.setPass(playerGameList.getPlayerGameVos().get(i).getPass());
            playerGameVo.setPositioncode(playerGameList.getPlayerGameVos().get(i).getPositioncode());
            playerGameVo.setProblem(playerGameList.getPlayerGameVos().get(i).getProblem());
            playerGameVo.setReview(playerGameList.getPlayerGameVos().get(i).getReview());
            playerGameVo.setStrength(playerGameList.getPlayerGameVos().get(i).getStrength());
            playerGameVo.setTactics(playerGameList.getPlayerGameVos().get(i).getTactics());
            playerGameVo.setCreativity(playerGameList.getPlayerGameVos().get(i).getCreativity());
            playerGameVo.setGoal(playerGameList.getPlayerGameVos().get(i).getGoal());
            playerGameVo.setAsist(playerGameList.getPlayerGameVos().get(i).getAsist());

            logger.info(i+" : 선수번호는 : " + playerGameVo.getPlayerid()+"   연습경기 아이디는 : "+playerGameVo.getExgameid());

            if(playerGameVo.getExgameid()==0 && playerGameVo.getGameid()==0){
                logger.info("빈 객체가 넘어왔습니다.");
            }else{
                playerGameDao.insert(playerGameVo);
            }

        }
        return "redirect:/matchgame/matchgame?upflag=I";
    }


}
