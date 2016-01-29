package com.jui.stm.controller;

import com.jui.stm.common.UploadFunction;
import com.jui.stm.dao.RolleDao;
import com.jui.stm.dao.TeamDao;
import com.jui.stm.dao.UserDao;
import com.jui.stm.vo.TeamVo;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.sql.Date;


@Controller
public class TeamController {

    @Autowired
    private SqlSession sqlSession;

    @RequestMapping(value = "team/teamjoin",method = RequestMethod.GET)
    public String TeamJoin(Model model){


        String userid = SecurityContextHolder.getContext().getAuthentication().getName();
        int userkey=0;
        UserDao userDao = sqlSession.getMapper(UserDao.class);

        userkey = userDao.getuserkey(userid);
        model.addAttribute("userkey",userkey);

        int teamCount=0;
        if(userid != "anonymousUser" ){
            teamCount = userDao.getTeamcount(userid);
        }else{
            teamCount=0;
        }
        model.addAttribute("teamCount",teamCount);

        return "/team/teamjoin";
    }

    @RequestMapping(value = "dbwork/teaminsert", method = RequestMethod.POST)
    public String TeamInsert(HttpServletRequest request,
                             @RequestParam("file") MultipartFile file,
                             @RequestParam("name") String name,
                             @RequestParam("addr") String addr,
                             @RequestParam("teamtype") String teamtype,
                             @RequestParam("type") String type,
                             @RequestParam("phone") String phone,
                             @RequestParam("foundationDate") Date foundationDate,
                             @RequestParam("userkey") int userkey)
    {

        System.out.println("Team insert page");

        TeamDao dao = sqlSession.getMapper(TeamDao.class);

        TeamVo teamVo = new TeamVo();

        teamVo.setName(name);
        teamVo.setAddr(addr);
        teamVo.setTeamtype(teamtype);
        teamVo.setType(type);
        teamVo.setPhone(phone);
        teamVo.setFoundationDate(foundationDate);
        teamVo.setDescription(request.getParameter("description"));
        teamVo.setUserkey(userkey);

        dao.InsertTeamDao(teamVo);

        String upfileName = file.getOriginalFilename(); //get file name

        if (!file.isEmpty()) {

            int fileInt = upfileName.indexOf('.');  //get . <== location
            String fileType = (upfileName.substring(fileInt,upfileName.length())).toLowerCase(); //get fileType string ==> .jpg
            String emblem = teamVo.getTeamid()+fileType;
            dao.UpdateEmblem(teamVo.getTeamid(), emblem);

            String rootPath = request.getSession().getServletContext().getRealPath("/")+"/"+"resources/img/team/";

            UploadFunction uploadFunction = new UploadFunction();
            uploadFunction.writeFile(file,emblem,request,rootPath);
        }


        RolleDao rolleDao = sqlSession.getMapper(RolleDao.class);
        rolleDao.insertRolle("ROLE_MANAGER",userkey,"Y");

        return "redirect:" +"/";
    }

    @RequestMapping("team/teammain")
    public String teamMain(HttpSession session,Model model){

        int teamCount = (Integer) session.getAttribute("teamCount");
        model.addAttribute("teamCount",teamCount);
        return "/team/teammain";
    }



}
