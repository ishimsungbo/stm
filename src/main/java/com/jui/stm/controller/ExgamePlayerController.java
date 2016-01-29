package com.jui.stm.controller;

import com.jui.stm.dao.PlayerGameDao;
import com.jui.stm.vo.PlayerGameList;
import com.jui.stm.vo.PlayerGameVo;
import net.sf.json.JSONArray;
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
import java.util.List;

/**
 * Created by sungbo on 2015-12-28.
 */

@Controller
public class ExgamePlayerController {

    @Autowired
    private SqlSession sqlSession;
    private static final Logger logger = LoggerFactory.getLogger(CommonController.class);

    @RequestMapping("playergame/playerinsert")
    public String insertView(HttpSession session,
                             Model model,
                             @RequestParam(required = false,value = "exgameid") int exgameid,
                             @RequestParam(required = false,value = "playercount") int playercount){

        logger.info("입력시작" + playercount);
        int teamid = (Integer) session.getAttribute("teamid");

        PlayerGameDao playerGameDao = sqlSession.getMapper(PlayerGameDao.class);
        JSONArray jsonArray = new JSONArray();

        if(playercount == 0) {
            List<PlayerGameVo> playerGameVos = playerGameDao.exgamePlayer(teamid, exgameid);
            for (int i = 0; i < playerGameVos.size(); i++) {
                playerGameVos.get(i).setExgameid(exgameid);
            }
            model.addAttribute("playerGameVos", jsonArray.fromObject(playerGameVos));
        }else{
            model.addAttribute("UpplayerGameVos", jsonArray.fromObject(playerGameDao.getExgamePlayerList(exgameid)));
        }

        model.addAttribute("teamid");
        model.addAttribute("exgameid",exgameid);
        model.addAttribute("playercount",playercount);

        logger.info("입력종료");
        return "/playergame/playerinsert";
    }

    @RequestMapping("playergame/dbinsert")
    public String insertDb(@ModelAttribute PlayerGameList playerGameList,
                           HttpServletRequest request,
                           HttpSession session){

        int teamid = (Integer) session.getAttribute("teamid");
        String pageflag = request.getParameter("pageflag");

        logger.info("플레이어 연습경기 정보 인설트 시작");
        logger.info("총 레코드 수는: "+playerGameList.getPlayerGameVos().size());
        logger.info("신규 or 수정: "+pageflag);

        PlayerGameDao playerGameDao = sqlSession.getMapper(PlayerGameDao.class);

        if(pageflag.equals("update")){
            logger.info("기존자료를 삭제합니다.");
            playerGameDao.delete(playerGameList.getPlayerGameVos().get(0).getExgameid());
        }

        for(int i=0; i < playerGameList.getPlayerGameVos().size(); i++){

                PlayerGameVo playerGameVo = new PlayerGameVo();
                playerGameVo.setTeamid(teamid);
                playerGameVo.setPlayerid(playerGameList.getPlayerGameVos().get(i).getPlayerid());
                playerGameVo.setExgameid(playerGameList.getPlayerGameVos().get(i).getExgameid());
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
        return "redirect:/exgame/exgamemain?upflag=I";
    }

}
