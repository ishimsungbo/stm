package com.jui.stm.controller;

import com.jui.stm.dao.PhyplayerDao;
import com.jui.stm.vo.PhysicalHeaderVo;
import com.jui.stm.vo.PhysicalLineList;
import com.jui.stm.vo.PhysicalLineVo;
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
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by sungbo on 2016-01-03.
 */

@Controller
public class PhyplayeController {


    @Autowired
    private SqlSession sqlSession;

    private static final Logger logger = LoggerFactory.getLogger(PhyplayeController.class);


    @RequestMapping("evaluation/phyplayermain")
    public String phyPlayerMain(HttpSession session,
                                Model model,HttpServletRequest request,
                                @RequestParam(required = false,value = "upflag") String upflag){


        int teamid = (Integer) session.getAttribute("teamid");

        PhyplayerDao dao = sqlSession.getMapper(PhyplayerDao.class);


        logger.info("Select Count : " + dao.selectHeader(teamid).size());

        model.addAttribute("listHeader", dao.selectHeader(teamid));
        model.addAttribute("teamid",teamid);
        model.addAttribute("upflag",upflag);

        return "/evaluation/phyplayermain";
    }

    @RequestMapping("evaluation/phyplayerinsert")
    public String phyInsert(){




        return "/evaluation/phyplayerinsert";
    }

    @RequestMapping("evaluation/phycreate")
    public String phyInsertDb(@ModelAttribute PhysicalHeaderVo headerVo,
                              @RequestParam("extdate") String extdate,
                              @ModelAttribute PhysicalLineList lineVos,
                              HttpSession session){


        int teamid = (Integer) session.getAttribute("teamid");
        headerVo.setTeamid(teamid);

        SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");

        try {
            // 스트링 타입을 => 데이트 타입으로 변경해준다.
            headerVo.setExdate(transFormat.parse(extdate));
        } catch (ParseException e) {
            e.printStackTrace();
        }

        //헤더인설트
        PhyplayerDao dao =  sqlSession.getMapper(PhyplayerDao.class);
        dao.headerInsert(headerVo);

        for(int i=0; i< lineVos.getLineVos().size();i++){
            logger.info("선수아이디 및 이름은 :" + lineVos.getLineVos().get(i).getPlayername() + " : " + lineVos.getLineVos().get(i).getPlayerid());
            lineVos.getLineVos().get(i).setHeaderid(headerVo.getHeaderid());

            PhysicalLineVo vo = new PhysicalLineVo();

            vo.setHeaderid(lineVos.getLineVos().get(i).getHeaderid());
            vo.setPlayerid(lineVos.getLineVos().get(i).getPlayerid());
            vo.setHeight(lineVos.getLineVos().get(i).getHeight());
            vo.setWeight(lineVos.getLineVos().get(i).getWeight());
            vo.setBodyfat(lineVos.getLineVos().get(i).getBodyfat());
            vo.setBodysize(lineVos.getLineVos().get(i).getBodysize());
            vo.setFifty(lineVos.getLineVos().get(i).getFifty());
            vo.setOnehundred(lineVos.getLineVos().get(i).getOnehundred());
            vo.setTwohundred(lineVos.getLineVos().get(i).getTwohundred());
            vo.setFourhundred(lineVos.getLineVos().get(i).getFourhundred());
            vo.setFootsize(lineVos.getLineVos().get(i).getFootsize());

            dao.lineInsert(vo);
        }

        logger.info("헤더 인설트 종료");

        return "redirect:" +"/evaluation/phyplayermain?upflag=I";
    }

    @RequestMapping("evaluation/phyplayerupdate")
    public String upDate(@RequestParam("headerid") int headerid,
                         HttpSession session,
                         Model model){

        PhyplayerDao dao = sqlSession.getMapper(PhyplayerDao.class);

        PhysicalLineList physicalLineList = new PhysicalLineList();

        physicalLineList.setLineVos(dao.selectLines(headerid));
        PhysicalHeaderVo headerVo = dao.selectHeaderRow(headerid);

        model.addAttribute("headerVo", headerVo);
        model.addAttribute("phylines", physicalLineList);

        List<String> mySelectValues = new ArrayList<String>();
        mySelectValues.add("S");
        mySelectValues.add("M");
        mySelectValues.add("L");
        mySelectValues.add("XL");
        mySelectValues.add("XXL");
        mySelectValues.add("XXXL");
        model.addAttribute("mySelectValues", mySelectValues);


        return "evaluation/phyplayerupdate";
    }
    @RequestMapping("evaluation/phyupdate")
    public String updateDb(@ModelAttribute PhysicalHeaderVo headerVo,
                           @RequestParam("extdate") String extdate,
                           @ModelAttribute PhysicalLineList lineVos,
                           HttpSession session,
                           Model model){

        logger.info("header id : " + headerVo.getHeaderid());

        SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");

        try {
            headerVo.setExdate(transFormat.parse(extdate));
        } catch (ParseException e) {
            logger.info("문제 발생?");
            e.printStackTrace();
        }

        PhyplayerDao dao = sqlSession.getMapper(PhyplayerDao.class);
        dao.headerUpdate(headerVo);


        for(int i=0 ; i < lineVos.getLineVos().size();i++){

            PhysicalLineVo lineVo = new PhysicalLineVo();

            lineVo.setHeight(lineVos.getLineVos().get(i).getHeight());
            lineVo.setWeight(lineVos.getLineVos().get(i).getWeight());
            lineVo.setBodyfat(lineVos.getLineVos().get(i).getBodyfat());
            lineVo.setFootsize(lineVos.getLineVos().get(i).getFootsize());
            lineVo.setBodysize(lineVos.getLineVos().get(i).getBodysize());
            lineVo.setFifty(lineVos.getLineVos().get(i).getFifty());
            lineVo.setOnehundred(lineVos.getLineVos().get(i).getOnehundred());
            lineVo.setTwohundred(lineVos.getLineVos().get(i).getTwohundred());
            lineVo.setFourhundred(lineVos.getLineVos().get(i).getFourhundred());

            lineVo.setLineid(lineVos.getLineVos().get(i).getLineid());
            dao.lineUpdate(lineVo);

        }

        return "redirect:" +"/evaluation/phyplayermain?upflag=U";
    }

    @RequestMapping("evaluation/delete")
    public String updateDb(@RequestParam("headerid") int headerid){
        PhyplayerDao dao = sqlSession.getMapper(PhyplayerDao.class);

        dao.headerDelete(headerid);
        dao.lineDelete(headerid);

        return "redirect:" +"/evaluation/phyplayermain?upflag=D";

    }

}
