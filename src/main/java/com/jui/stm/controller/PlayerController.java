package com.jui.stm.controller;

import com.jui.stm.common.UploadFunction;
import com.jui.stm.dao.*;
import com.jui.stm.dto.GrappaingDTO;
import com.jui.stm.dto.PagingDTO;
import com.jui.stm.query.vo.PlayerCoTrVo;
import com.jui.stm.query.vo.PlayerInfoAvgVo;
import com.jui.stm.vo.EvalpartoneVo;
import com.jui.stm.vo.EvalrecordVo;
import com.jui.stm.vo.PlayerVo;
import net.sf.json.JSONArray;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.sql.Date;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

@Controller
public class PlayerController {

    @Autowired
    private SqlSession sqlSession;

    private static final Logger logger = LoggerFactory.getLogger(CoachingController.class);

    @RequestMapping("player/playerjoin")
    public String playerJoin(Model model,HttpSession session){

        String userid = SecurityContextHolder.getContext().getAuthentication().getName();
        int userkey = 0;
        int teamid  = 0;

        UserDao userDao = sqlSession.getMapper(UserDao.class);

        userkey = userDao.getuserkey(userid);

        TeamDao teamDao = sqlSession.getMapper(TeamDao.class);

        teamid = teamDao.getTeamid(userkey);

        model.addAttribute("teamid",teamid);
        model.addAttribute("userkey", userkey);

        int teamCount = (Integer) session.getAttribute("teamCount");
        model.addAttribute("teamCount", teamCount);


        return "/player/playerjoin";
    }

    @RequestMapping("player/playermain")
    public String playerMain(@ModelAttribute("pagingDTO") PagingDTO pagingDTO
                            ,Model model
                            ,@RequestParam(required = false,value = "search_exclass") String exclass
                            ,@RequestParam(required = false,value = "search_positioncode") String positioncode
                            ,@RequestParam(required = false,value = "search_status") String status
            ,@RequestParam(required = false,value = "search_fromdate") String search_fromdate
            ,@RequestParam(required = false,value = "search_todate") String search_todate
    ,@RequestParam(value = "pageNo", required = false) String pageNo
    ){

        pagingDTO.setPageSize(5);  // 한 페이지에 보일 게시글 수
        pagingDTO.setPageNo(1);     // 현재 페이지 번호

        if(StringUtils.isNotEmpty(search_fromdate) && StringUtils.isNotEmpty(search_todate)){
            pagingDTO.setFromdate(search_fromdate);
            pagingDTO.setTodate(search_todate);
        }

        if(StringUtils.isNotEmpty(exclass)){
            pagingDTO.setExclass(exclass);
        }

        if(StringUtils.isNotEmpty(positioncode)){
            pagingDTO.setPositioncode(positioncode);
        }

        if(StringUtils.isNotEmpty(status)){
            pagingDTO.setStatus(status);
        }

        if(StringUtils.isNotEmpty(pageNo)){
            pagingDTO.setPageNo(Integer.parseInt(pageNo));
        }

        pagingDTO.setBlockSize(5);

        PlyearDao plyearDao = sqlSession.getMapper(PlyearDao.class);
        String userid = SecurityContextHolder.getContext().getAuthentication().getName();
        UserDao userDao = sqlSession.getMapper(UserDao.class);

        int userkey = userDao.getuserkey(userid);
        TeamDao teamDao = sqlSession.getMapper(TeamDao.class);
        int teamId  = teamDao.getTeamid(userkey);

        pagingDTO.setTeamid(teamId);


        pagingDTO.setTotalCount(plyearDao.getPlayersCount(pagingDTO));
        ArrayList<PlayerVo> playerList = plyearDao.PlayerList(pagingDTO);


        model.addAttribute("paging", pagingDTO);
        model.addAttribute("userkey", userkey);
        model.addAttribute("list", playerList);


        return "/player/playermain";
    }


    @RequestMapping(value = "player/playerupdate", method = RequestMethod.POST)
    public String dbUpdatePlayer(HttpServletRequest request,HttpSession session,
                                 @RequestParam("file") MultipartFile file,
                                 @RequestParam("playername") String playername,
                                 @RequestParam("positioncategory") String positioncategory,
                                 @RequestParam("positioncode") String positioncode,
                                 @RequestParam("status") String status,
                                 @RequestParam("joindate") Date joindate,
                                 @RequestParam("exclass") String exclass,
                                 @RequestParam("description") String description,
                                 @RequestParam("playerid") int playerid,
                                 @RequestParam("backnumber") int backnumber,
                                 @RequestParam("date") String date
    ) throws ParseException {
        logger.info("PlayerCtt.dbUpdatePlayer Start");

        PlyearDao dao = sqlSession.getMapper(PlyearDao.class);

        PlayerVo playerVo = new PlayerVo();
        int teamid = (Integer) session.getAttribute("teamid");

        playerVo.setTeamid(teamid);
        playerVo.setPlayername(playername);
        playerVo.setPositioncategory(positioncategory);
        playerVo.setPositioncode(positioncode);
        playerVo.setStatus(status);
        playerVo.setJoindate(joindate);
        playerVo.setDescription(description);
        playerVo.setExclass(exclass);
        playerVo.setPlayerid(playerid);
        playerVo.setBacknumber(backnumber);

        if(StringUtils.isNotEmpty(date)){
            java.text.SimpleDateFormat format = new java.text.SimpleDateFormat("yyyy-MM-dd");
            java.util.Date withdrawdate = format.parse(date);
            playerVo.setWithdrawdate(withdrawdate);
        }


        String upfileName = file.getOriginalFilename(); //get file name

        if (!file.isEmpty()) {

            int fileInt = upfileName.indexOf('.');
            String fileType = (upfileName.substring(fileInt, upfileName.length())).toLowerCase(); //get fileType string ==> .jpg
            String picture = playerVo.getPlayerid() + fileType;

            playerVo.setPicture(picture);

            //서버에 올리때는 아래 경로를 로컬일때는 target 폴더임..
            String rootPath = request.getSession().getServletContext().getRealPath("/")+"/"+"resources/img/player/";
            UploadFunction uploadFunction = new UploadFunction();
            uploadFunction.writeFile(file,picture,request,rootPath);
        }

        dao.updatePlayer(playerVo);
        //선수업데이트 collrabs를 위한 정보
        String grap="playerup";
        logger.info("PlayerCtt.dbUpdatePlayer End");

        return "redirect:" +"/player/playerinfo?playerid="+playerVo.getPlayerid()+"&grap="+grap;
    }

    @RequestMapping(value = "player/playerinsert", method = RequestMethod.POST)
    public String dBplyearInsert(HttpServletRequest request,
                                 @RequestParam("file") MultipartFile file,
                                 @RequestParam("playername") String playername,
                                 @RequestParam("positioncategory") String positioncategory,
                                 @RequestParam("positioncode") String positioncode,
                                 @RequestParam("status") String status,
                                 @RequestParam("joindate") Date joindate,
                                 @RequestParam("teamid") int teamid,
                                 @RequestParam("exclass") String exclass,
                                 @RequestParam("backnumber") int backnumber,
                                 @RequestParam("date") String date
    ) throws ParseException {

        PlyearDao dao = sqlSession.getMapper(PlyearDao.class);

        PlayerVo playerVo = new PlayerVo();

        playerVo.setTeamid(teamid);
        playerVo.setPlayername(playername);
        playerVo.setPositioncategory(positioncategory);
        playerVo.setPositioncode(positioncode);
        playerVo.setStatus(status);
        playerVo.setJoindate(joindate);
        playerVo.setDescription(request.getParameter("description"));
        playerVo.setExclass(exclass);
        playerVo.setBacknumber(backnumber);

        if(StringUtils.isNotEmpty(date)){
            java.text.SimpleDateFormat format = new java.text.SimpleDateFormat("yyyy-MM-dd");
            java.util.Date withdrawdate = format.parse(date);
            playerVo.setWithdrawdate(withdrawdate);
        }

        dao.InsertPlyear(playerVo);

        String upfileName = file.getOriginalFilename(); //get file name

        if (!file.isEmpty()) {

            int fileInt = upfileName.indexOf('.');
            String fileType = (upfileName.substring(fileInt, upfileName.length())).toLowerCase(); //get fileType string ==> .jpg
            String picture = playerVo.getPlayerid() + fileType;

            dao.UpdatePicture(playerVo.getPlayerid(), picture);

            //서버에 올리때는 아래 경로를 로컬일때는 target 폴더임..
            String rootPath = request.getSession().getServletContext().getRealPath("/")+"/"+"resources/img/player/";
            UploadFunction uploadFunction = new UploadFunction();
            uploadFunction.writeFile(file,picture,request,rootPath);
        }

        return "redirect:" +"/player/playermain";
    }

    @RequestMapping("player/playerper")
    public String playerPer(@ModelAttribute("GrappaingDTO") GrappaingDTO grappaingDTO,
                            Model model,
                            @RequestParam("playerid") int playerid,
                            @RequestParam(value = "pageNo", required = false) String pageNo
                            ){

        grappaingDTO.setPageSize(5);  // 한 페이지에 보일 게시글 수
        grappaingDTO.setPageNo(1);     // 현재 페이지 번호

        if(StringUtils.isNotEmpty(pageNo)){
            grappaingDTO.setPageNo(Integer.parseInt(pageNo));
        }

        grappaingDTO.setBlockSize(5);

        EvaluationPlayerDao dao = sqlSession.getMapper(EvaluationPlayerDao.class);

        grappaingDTO.setPlayerid(playerid);
        grappaingDTO.setTotalCount(dao.getTotalCount(playerid));

        JSONArray jsonArray = new JSONArray();

        ArrayList<EvalrecordVo> jsonList = dao.getperRecord(grappaingDTO);

        System.out.println("Check Point");

        System.out.println("총 카운터는 :"+ grappaingDTO.getTotalCount());
        System.out.println("pid : " + grappaingDTO.getPlayerid());
        System.out.println("start num : " + grappaingDTO.getStartRowNum());
        System.out.println("page num : " + grappaingDTO.getPageSize());
        System.out.println("end page num : " + grappaingDTO.getEndPageNo());

        ArrayList<EvalpartoneVo> plist = dao.getRecordPlayer(grappaingDTO);

        model.addAttribute("jsonList", jsonArray.fromObject(jsonList));
        model.addAttribute("plist", jsonArray.fromObject(plist));
        model.addAttribute("list", jsonList);
        model.addAttribute("playerName", dao.getPlayerName(playerid));
        model.addAttribute("paging", grappaingDTO);


        return "/player/playerper";
    }

    @RequestMapping(value = "test.json", method = RequestMethod.GET)
    public ModelAndView test(@RequestParam("playerid") int playerid){
        ModelAndView modelAndView = new ModelAndView("jsonView");
        EvaluationPlayerDao dao = sqlSession.getMapper(EvaluationPlayerDao.class);
        //ArrayList<EvalrecordVo> jsonList = dao.getperRecord(playerid);
        Map map = new HashMap();
        //map.put("jsonlists",jsonList);
        modelAndView.addAllObjects(map);
        return modelAndView;
    }


    @RequestMapping("player/playerinfo")
    public String playerView(@ModelAttribute("GrappaingDTO") GrappaingDTO grappaingDTO,
                           Model model,
                           @RequestParam("playerid") int playerid,
                           @RequestParam(value = "pageNo", required = false) String pageNo,
                           @RequestParam(value = "grap", required = false) String grap,
                           @RequestParam(value = "seach_con", required = false) String seach_con,
                             HttpSession session
    ){

        int teamid = (Integer) session.getAttribute("teamid");

        logger.info("그래픽 : " + seach_con);

        if(seach_con == null){
            seach_con="all";
            logger.info("초기 값 셋팅 : " + seach_con);
        }

        grappaingDTO.setPageSize(5);  // 한 페이지에 보일 게시글 수
        grappaingDTO.setPageNo(1);     // 현재 페이지 번호

        if(StringUtils.isNotEmpty(pageNo)){
            grappaingDTO.setPageNo(Integer.parseInt(pageNo));
        }

        grappaingDTO.setBlockSize(5);

        EvaluationPlayerDao dao = sqlSession.getMapper(EvaluationPlayerDao.class);
        
        PlayerGameDao playerGameDao = sqlSession.getMapper(PlayerGameDao.class);
        PlayerInfoAvgVo playerInfoAvgVo = new PlayerInfoAvgVo();
        playerInfoAvgVo.setTeamid(teamid);
        playerInfoAvgVo.setPlayerid(playerid);



        grappaingDTO.setPlayerid(playerid);
        grappaingDTO.setTotalCount(dao.getTotalCount(playerid));

        JSONArray jsonArray = new JSONArray();
        JSONArray array = new JSONArray();

        ArrayList<EvalrecordVo> jsonList = dao.getperRecord(grappaingDTO);

        ArrayList<EvalpartoneVo> plist = dao.getRecordPlayer(grappaingDTO);
        ArrayList<EvalpartoneVo> resultList = null;

        if(seach_con.equals("all")){
            plist = dao.getRecordPlayer(grappaingDTO);
            model.addAttribute("plist", jsonArray.fromObject(plist));
            logger.info("전체 컬럼을 조회합니다.");
        }else{
            if(seach_con.equals("pass")){
                resultList = dao.getRecordpass(grappaingDTO);
            }else if(seach_con.equals("game")){
                resultList = dao.getRecordgame(grappaingDTO);
            }else if(seach_con.equals("kick")){
                resultList = dao.getRecordkick(grappaingDTO);
            }else if(seach_con.equals("leadings")){
                resultList = dao.getRecordleadings(grappaingDTO);
            }else if(seach_con.equals("shooting")){
                resultList = dao.getRecordshooting(grappaingDTO);
            }else if(seach_con.equals("tactics")){
                resultList = dao.getRecordtactics(grappaingDTO);
            }else if(seach_con.equals("dribble")){
                resultList = dao.getRecorddribble(grappaingDTO);
            }
            model.addAttribute("plist", jsonArray.fromObject(resultList));
        }

        model.addAttribute("jsonList", jsonArray.fromObject(jsonList));
        model.addAttribute("list", jsonList);
        model.addAttribute("playerName", dao.getPlayerName(playerid));
        model.addAttribute("paging", grappaingDTO);

        //차트를 클릭해서 넘어왔다면...
        model.addAttribute("seach_con",seach_con);
        model.addAttribute("grap",grap);

        model.addAttribute("playerid",playerid);
        model.addAttribute("teamid",teamid);

        //연습경기,대회경기 선수 보조정보
        model.addAttribute("exgameAvg",playerGameDao.playerInfoAvgexgame(playerInfoAvgVo));
        model.addAttribute("gameAvg",playerGameDao.playerInfoAvggame(playerInfoAvgVo));

        //코칭 및 일일훈련정보
        PlyearDao plyearDao = sqlSession.getMapper(PlyearDao.class);
        PlayerCoTrVo coTrVo = plyearDao.getPlayerRec(playerid);
        model.addAttribute("coachRec",coTrVo);
        return "/player/playerinfo";
    }


}
