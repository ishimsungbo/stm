package com.jui.stm.controller;

import com.jui.stm.dao.MainDao;
import com.jui.stm.dao.TeamDao;
import com.jui.stm.dao.UserDao;
import com.jui.stm.vo.TeamVo;
import com.jui.stm.vo.UserVo;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Created by sungbo on 2015-10-12.
 */
@Controller
public class MainController {

    private static final Logger logger = LoggerFactory.getLogger(MainController.class);

    @Autowired
    private SqlSession sqlSession;


    @RequestMapping(value = "/")
    public String index(
            Model model,
            HttpServletRequest request,
            HttpServletResponse response
    ){

        String error = request.getParameter("error");
        model.addAttribute("error",error);

        model.addAttribute("curlogname", SecurityContextHolder.getContext().getAuthentication().getName());
        model.addAttribute("curlogrole", SecurityContextHolder.getContext().getAuthentication().getAuthorities());

        String userid = SecurityContextHolder.getContext().getAuthentication().getName();


        Authentication auth = SecurityContextHolder.getContext().getAuthentication();


        UserDao userDao = sqlSession.getMapper(UserDao.class);

        HttpSession session = request.getSession();


        int teamCount=0;

        if(userid != "anonymousUser" ){

            teamCount = userDao.getTeamcount(userid);
            session.setAttribute("userid",userid);

        }else{
            teamCount=0;
        }

        //팀에 등록된 선수와 현 소속 선수 카운팅정보 전달
        if(teamCount > 0){
            int userkey = userDao.getuserkey(userid);

            MainDao mainDao = sqlSession.getMapper(MainDao.class);
            TeamDao teamDao = sqlSession.getMapper(TeamDao.class);

            int player_all_Count= mainDao.getAllplayer(userid);
            TeamVo teamVo = teamDao.userkeyTeam(userkey);


            model.addAttribute("teamvo", teamVo);
            model.addAttribute("playerallcount", player_all_Count);

            session.setAttribute("userkey", userkey);
            session.setAttribute("teamid", teamVo.getTeamid());


        }

        UserVo userVo = new UserVo();
        userVo.setUserid(userid);

        //session 정보를 담는다.
        session.setAttribute("teamCount", teamCount);
        model.addAttribute("teamCount", teamCount);


        return "index";
    }

    @ExceptionHandler(NullPointerException.class)
    public String handleNullNullPointerException(NullPointerException ex){

        System.out.println("에러가 발생됨" + ex);

        return "/error/NumberFormatError";
    }


}
