package com.jui.stm.controller;

import com.jui.stm.dao.*;
import com.jui.stm.dto.EvaluationDTO;
import com.jui.stm.vo.*;
import org.apache.commons.lang.StringUtils;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

 /**
 * Created by sungbo on 2015-10-14.
 */
@Controller
public class EvaluationController {

    @Autowired
    private SqlSession sqlSession;

    private static final Logger logger = LoggerFactory.getLogger(CoachingController.class);

    @RequestMapping(value = "evaluation/physical_main")
    public String physicalMain(HttpSession session,
                               HttpServletRequest request,
                               Model model,
                               @ModelAttribute("pagingDTO")EvaluationDTO pagingDTO,
                               @RequestParam(required = false,value = "search_fromdate") String search_fromdate,
                               @RequestParam(required = false,value = "search_todate") String search_todate,
                               @RequestParam(required = false,value = "search_performer") String performer,
                               @RequestParam(required = false,value = "search_weather") String weather,
                               @RequestParam(required = false,value = "search_subject") String subject,
                               @RequestParam(required = false,value = "search_location") String location,
                               @RequestParam(value = "pageNo", required = false) String pageNo,
                               @RequestParam(value = "upflag", required = false) String upflag
                               ){


        pagingDTO.setPageSize(5);  // 한 페이지에 보일 게시글 수
        pagingDTO.setPageNo(1);     // 현재 페이지 번호
        int teamid = (Integer) session.getAttribute("teamid");

        if(StringUtils.isNotEmpty(search_fromdate) && StringUtils.isNotEmpty(search_todate)){
            pagingDTO.setFromdate(search_fromdate);
            pagingDTO.setTodate(search_todate);
        }

        if(StringUtils.isNotEmpty(performer)){
            pagingDTO.setPerformer(performer);
        }

        if(StringUtils.isNotEmpty(weather)){
            pagingDTO.setWeather(weather);
        }

        if(StringUtils.isNotEmpty(subject)){
            pagingDTO.setSubject(subject);
        }

        if(StringUtils.isNotEmpty(location)){
            pagingDTO.setLocation(location);
        }

        if(StringUtils.isNotEmpty(pageNo)){
            pagingDTO.setPageNo(Integer.parseInt(pageNo));
        }

        pagingDTO.setBlockSize(5);
        pagingDTO.setTeamid(teamid);

        EvaluationDao evaluationDao = sqlSession.getMapper(EvaluationDao.class);
        int teamCount = (Integer) session.getAttribute("teamCount");

        pagingDTO.setTotalCount(evaluationDao.evaluationCount(pagingDTO));
        ArrayList<EvaluationVo> list = evaluationDao.evaluationList(pagingDTO);

        logger.info("카운터 전체 : "+pagingDTO.getTotalCount());
        logger.info("pageNum : "+pagingDTO.getPageNo());
        logger.info("시작 :" + pagingDTO.getStartPageNo());
        logger.info("종료 :" + pagingDTO.getEndPageNo());

        model.addAttribute("paging", pagingDTO);
        model.addAttribute("teamid", teamid);
        model.addAttribute("teamCount", teamCount);
        model.addAttribute("list", list);
        model.addAttribute("upflag", upflag);
        return "evaluation/physical_main";
    }

    @RequestMapping("evaluation/physical_insert")
    public String physicalReg(Model model){
        List<EvaluationPlayerVo> evaluationPlayerVos = new ArrayList<EvaluationPlayerVo>();

        System.out.println("평가등록페이지 시작");
        String userid = SecurityContextHolder.getContext().getAuthentication().getName();
        int userkey = 0;
        int teamid  = 0;

        UserDao userDao = sqlSession.getMapper(UserDao.class);
        userkey = userDao.getuserkey(userid);

        int teamCount=0;
        if(userid != "anonymousUser" ){
            teamCount = userDao.getTeamcount(userid);
        }else{
            teamCount=0;
        }

        TeamDao teamDao = sqlSession.getMapper(TeamDao.class);

        teamid = teamDao.getTeamid(userkey);

        PlyearDao plyearDao = sqlSession.getMapper(PlyearDao.class);

        EvaluationPlayerList playerList = new EvaluationPlayerList();

        playerList.setevalvos(evaluationPlayerVos);

        int count = plyearDao.TeamPlayerList(teamid).size();

        for (int i=0; count > i ; i++)
        {

            evaluationPlayerVos.add(i,new EvaluationPlayerVo(
                            1,
                            0,
                            plyearDao.TeamPlayerList(teamid).get(i).getPlayerid(),
                            "Y",
                            0,
                            0,
                            0,
                            0,
                            0, // 패스
                            0, // 슈팅
                            plyearDao.TeamPlayerList(teamid).get(i).getPlayername()
                            ,0
                            ,0
                            ,0
                            ,null
                    )
            );
        }


        model.addAttribute("playerList",playerList);
        model.addAttribute("teamid",teamid);
        model.addAttribute("teamCount", teamCount);


        return "/evaluation/physical_insert";
    }


    @RequestMapping(value = "dbwork/evalinsert", method = RequestMethod.POST)
    public String evalInsert(
            @ModelAttribute("playerList") EvaluationPlayerList playerList,
            Model model,HttpServletRequest request
            ,@RequestParam("date") Date date
    ){

        String userid = SecurityContextHolder.getContext().getAuthentication().getName();
        int userkey = 0;
        int teamid  = 0;

        UserDao userDao = sqlSession.getMapper(UserDao.class);
        TeamDao teamDao = sqlSession.getMapper(TeamDao.class);

        //1.유저키를 가져온다.
        userkey = userDao.getuserkey(userid);
        //2.유저키에 해당하는 팀아이디를 구한다.
        teamid = teamDao.getTeamid(userkey);

        //3.정기평가 헤더를 인설트 한다.
        EvaluationDao evaluationDao = sqlSession.getMapper(EvaluationDao.class);

        EvaluationVo evaluationVo = new EvaluationVo();

        evaluationVo.setTeamid(teamid);
        evaluationVo.setDate(date);
        evaluationVo.setSubject(request.getParameter("subject"));
        evaluationVo.setLocation(request.getParameter("location"));
        evaluationVo.setWeather(request.getParameter("weather"));
        evaluationVo.setPerformer(request.getParameter("performer"));
        evaluationVo.setDescription(request.getParameter("description"));
        evaluationVo.setEvalrason(request.getParameter("evalrason"));
        evaluationVo.setExclass(request.getParameter("exclass"));


        evaluationDao.inSertEval(evaluationVo);

        EvaluationPlayerDao evaluationPlayerDao = sqlSession.getMapper(EvaluationPlayerDao.class);

        for (int i=0; playerList.getEvalvos().size() > i ; i++)
        {

            EvaluationPlayerVo evaluationPlayerVo = new EvaluationPlayerVo();

            evaluationPlayerVo.setAttend("Y");
            evaluationPlayerVo.setEvaluationid(evaluationVo.getEvaluationid());
            evaluationPlayerVo.setPlayerid(playerList.getEvalvos().get(i).getPlayerid());
            evaluationPlayerVo.setPass(playerList.getEvalvos().get(i).getPass());
            evaluationPlayerVo.setShooting(playerList.getEvalvos().get(i).getShooting());
            evaluationPlayerVo.setKick(playerList.getEvalvos().get(i).getKick());
            evaluationPlayerVo.setDribble(playerList.getEvalvos().get(i).getDribble());
            evaluationPlayerVo.setControll(playerList.getEvalvos().get(i).getControll());
            evaluationPlayerVo.setKick(playerList.getEvalvos().get(i).getKick());
            evaluationPlayerVo.setGame(playerList.getEvalvos().get(i).getGame());
            evaluationPlayerVo.setTactics(playerList.getEvalvos().get(i).getTactics());
            evaluationPlayerVo.setCreativity(playerList.getEvalvos().get(i).getCreativity());
            evaluationPlayerVo.setLeadings(playerList.getEvalvos().get(i).getLeadings());

            evaluationPlayerDao.InsertEvalPlayer(evaluationPlayerVo);
        }



        //스케줄을 생성한다.
        CalendarVo calendarVo = new CalendarVo();

        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        String lvdate = dateFormat.format(date);

        //시작일 종료일
        calendarVo.setTeamid(teamid);
        calendarVo.setStart(lvdate);
        calendarVo.setEnd(lvdate);
        calendarVo.setTitle("정기평가 : " + lvdate);
        //calendarVo.setContent(request.getParameter("subject"));
        calendarVo.setColor("blue");

        CommonController commonController = new CommonController();
        commonController.calenderCreate(sqlSession,calendarVo);

        return "redirect:" +"/evaluation/physical_main?upflag=I";
    }

    @RequestMapping("evaluation/physical_update")
    public String physicalView(
            HttpSession session
            ,@RequestParam("evaluationid") int evaluationid
            ,Model model
            ,HttpServletRequest request
    ){
        logger.info("physicalView Start");
        int teamid = (Integer) session.getAttribute("teamid");
        int teamCount = (Integer) session.getAttribute("teamCount");

        EvaluationDao dao = sqlSession.getMapper(EvaluationDao.class);
        EvaluationPlayerDao playerDao = sqlSession.getMapper(EvaluationPlayerDao.class);

        EvaluationPlayerList playerList = new EvaluationPlayerList();
        playerList.setevalvos(playerDao.getEvalplayerList(evaluationid));

        model.addAttribute("teamid", teamid);
        model.addAttribute("teamCount", teamCount);
        model.addAttribute("listHeader", dao.selectEvalRow(evaluationid));
        model.addAttribute("playerList",playerList);

        String upflag = request.getParameter("upflag");
        model.addAttribute("upflag",upflag);
        logger.info("physicalView End");
        return "evaluation/physical_update";
    }

    @RequestMapping(value = "dbwork/update", method = RequestMethod.POST)
    public String evalUpdate(
            @RequestParam("evaluationid") int evaluationid
            ,@RequestParam("subject") String subject
            ,@RequestParam("date") Date date
            ,@RequestParam("location") String location
            ,@RequestParam("weather") String weather
            ,@RequestParam("description") String description
            ,@RequestParam("performer") String performer
            ,@RequestParam("evalrason") String evalrason
            ,@RequestParam("exclass") String exclass
            ,@ModelAttribute("playerList") EvaluationPlayerList playerList
    ){
        logger.info("physicalupdate Start");
        EvaluationDao evaluationDao = sqlSession.getMapper(EvaluationDao.class);

        EvaluationVo evaluationVo = new EvaluationVo();
        evaluationVo.setDate(date);
        evaluationVo.setSubject(subject);
        evaluationVo.setLocation(location);
        evaluationVo.setWeather(weather);
        evaluationVo.setDescription(description);
        evaluationVo.setPerformer(performer);
        evaluationVo.setEvaluationid(evaluationid);
        evaluationVo.setEvalrason(evalrason);
        evaluationVo.setExclass(exclass);

        evaluationDao.updateEval(evaluationVo);

        EvaluationPlayerDao playerDao = sqlSession.getMapper(EvaluationPlayerDao.class);

        //존재하는 라인을 모두 없애준다
        playerDao.delete(evaluationVo.getEvaluationid());

        EvaluationPlayerDao evaluationPlayerDao = sqlSession.getMapper(EvaluationPlayerDao.class);

        for (int i=0; playerList.getEvalvos().size() > i ; i++)
        {

            EvaluationPlayerVo evaluationPlayerVo = new EvaluationPlayerVo();
            evaluationPlayerVo.setAttend("Y");

            evaluationPlayerVo.setEvaluationid(evaluationVo.getEvaluationid());
            evaluationPlayerVo.setPlayerid(playerList.getEvalvos().get(i).getPlayerid());
            evaluationPlayerVo.setShooting(playerList.getEvalvos().get(i).getShooting());
            evaluationPlayerVo.setKick(playerList.getEvalvos().get(i).getKick());
            evaluationPlayerVo.setPass(playerList.getEvalvos().get(i).getPass());
            evaluationPlayerVo.setDribble(playerList.getEvalvos().get(i).getDribble());
            evaluationPlayerVo.setGame(playerList.getEvalvos().get(i).getGame());
            evaluationPlayerVo.setTactics(playerList.getEvalvos().get(i).getTactics());
            evaluationPlayerVo.setLeadings(playerList.getEvalvos().get(i).getLeadings());
            evaluationPlayerVo.setCreativity(playerList.getEvalvos().get(i).getCreativity());
            evaluationPlayerVo.setControll(playerList.getEvalvos().get(i).getControll());

            evaluationPlayerDao.InsertEvalPlayer(evaluationPlayerVo);
        }


        logger.info("physicalupdate End");

        return "redirect:" +"/evaluation/physical_main?evaluationid="+evaluationid+"&upflag=U";
    }

    @RequestMapping(value = "evaluation/physicaldelete")
    public String evalUpdate(
            @RequestParam("evaluationid") int evaluationid
    ){
        EvaluationDao vo = sqlSession.getMapper(EvaluationDao.class);
        EvaluationPlayerDao playerDao = sqlSession.getMapper(EvaluationPlayerDao.class);
        vo.delete(evaluationid);
        playerDao.delete(evaluationid);
        return "redirect:" +"/evaluation/physical_main?upflag=D";
    }

     @RequestMapping("evaluation/physical_player")
     public String insertEvalPlayer(
             Model model,
             @RequestParam("evaluationid") int evaluationid,
             @RequestParam("playerid") int playerid,
             HttpSession session
     ){
         int teamid = (Integer) session.getAttribute("teamid");

         PlyearDao dao = sqlSession.getMapper(PlyearDao.class);

         EvaldetaileDao evaldetaileDao = sqlSession.getMapper(EvaldetaileDao.class);
         EvalDetailVo evalDetailVo = new EvalDetailVo();
         try {
             evalDetailVo =  evaldetaileDao.getDetailData(teamid,playerid,evaluationid);

         }catch (Exception e){
             logger.info("========================자료가 없어요========================");
         }


         model.addAttribute("evaluationid",evaluationid);
         model.addAttribute("playerid", playerid);
         model.addAttribute("playername", dao.getPlayerName(playerid));
         model.addAttribute("teamid", teamid);
         model.addAttribute("evalDetailVo", evalDetailVo);

         return "evaluation/physical_player";
     }

     @RequestMapping("evaluation/evaldetaile")
     public String evaluationSave(
             @ModelAttribute("evalDetailVo") EvalDetailVo evalDetailVo
             ){

         EvaldetaileDao dao = sqlSession.getMapper(EvaldetaileDao.class);

         if(evalDetailVo.getDetailid()==0){
             logger.info("신규일때 실행");
             dao.insert(evalDetailVo);
         }else{
             logger.info("이미 자료가 있다면 없데이트로 변경");

             EvalDetailVo dbrecord  =  dao.getDetailData(evalDetailVo.getTeamid(),evalDetailVo.getPlayerid(),evalDetailVo.getEvaluationid());

             if(dbrecord.getPass().equals(evalDetailVo.getPass())) {
                 evalDetailVo.setPass(null);
             }
             if(dbrecord.getShooting().equals(evalDetailVo.getShooting())) {
                 evalDetailVo.setShooting(null);
             }
             if(dbrecord.getKick().equals(evalDetailVo.getKick())) {
                 evalDetailVo.setKick(null);
             }
             if(dbrecord.getDribble().equals(evalDetailVo.getDribble())) {
                 evalDetailVo.setDribble(null);
             }
             if(dbrecord.getGame().equals(evalDetailVo.getGame())) {
                 evalDetailVo.setGame(null);
             }
             if(dbrecord.getTactics().equals(evalDetailVo.getTactics())) {
                 evalDetailVo.setTactics(null);
             }
             if(dbrecord.getLeadings().equals(evalDetailVo.getLeadings())) {
                 evalDetailVo.setLeadings(null);
             }
             if(dbrecord.getCreativity().equals(evalDetailVo.getCreativity())) {
                 evalDetailVo.setCreativity(null);
             }
             if(dbrecord.getControll().equals(evalDetailVo.getControll())) {
                 evalDetailVo.setControll(null);
             }
             dao.update(evalDetailVo);

         }




         return "redirect:" +"/evaluation/physical_update?evaluationid="+evalDetailVo.getEvaluationid();
     }

}
