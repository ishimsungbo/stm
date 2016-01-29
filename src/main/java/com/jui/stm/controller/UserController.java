package com.jui.stm.controller;

import com.jui.stm.common.AutoLogin;
import com.jui.stm.common.JoinValidator;
import com.jui.stm.dao.RolleDao;
import com.jui.stm.dao.UserDao;
import com.jui.stm.vo.UserVo;
import org.apache.commons.lang.StringUtils;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.security.crypto.password.StandardPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

/**
 * Created by sungbo on 2015-10-12.
 */
@Controller
public class UserController {

    @Autowired
    private SqlSession sqlSession;

    @Autowired
    private MailSender mailSender;

    @Autowired
    private AutoLogin autoLogin;

    private static final Logger logger = LoggerFactory.getLogger(CoachingController.class);

    @RequestMapping("snsUserJoin")
    public String snsUserJoin(
            @RequestParam("snsName") String snsName,
            @RequestParam("userid") String userid,
            @RequestParam("snsusername") String snsusername,
            Model model
    ){

        UserVo vo=new UserVo();

        vo.setUserid(userid);
        vo.setSnsname(snsusername);
        vo.setSnsprovider(snsName);
        vo.setPassword(userid);
        model.addAttribute("userVo",vo);
        return "/user/snsUserJoin";
    }


    @RequestMapping(value = "userjoin",method = RequestMethod.GET)
    public String userJoin(Model model,HttpServletRequest request,
                            @RequestParam(required = false,value = "snsName") String snsName,
                           @RequestParam(required = false,value = "userid") String userid,
                           @RequestParam(required = false,value = "snsusername") String snsusername
    ){

        int teamCount = 0;

        String param = request.getParameter("fail");

        if(param == null){
            model.addAttribute("uidcheck",param);
        }else{
            model.addAttribute("uidcheck",param);
        }

        if(StringUtils.isEmpty(snsName)){
            snsName="STM";
        }


        model.addAttribute("teamCount",teamCount);
        model.addAttribute("snsName", snsName);
        model.addAttribute("userid",userid);
        model.addAttribute("snsusername",snsusername);
        return "/user/userjoin";
    }

    @RequestMapping(value="/insert", method= RequestMethod.POST)
    public String doJoin(Model model,
                         UserVo userVo,
                         BindingResult bindingResult,
                         HttpServletRequest request){

        logger.info("몬제 걸리지비?");

        JoinValidator joinValidator = new JoinValidator();
        joinValidator.setSqlSession(sqlSession); //프로그램 흐름상 먼저 sqlSession이 등록되어야 한다.
        joinValidator.validate(userVo,bindingResult);

        if(bindingResult.hasErrors()){

            model.addAttribute("userVo", userVo);

            if(userVo.getSnsflag().equals("Y")){
                return "/user/snsUserJoin";
            }else if(userVo.getSnsflag().equals("N")){
                    return "/user/userjoin";
            }
            return "";

        } else {

            UserDao userDao = sqlSession.getMapper(UserDao.class);
            RolleDao rolleDao = sqlSession.getMapper(RolleDao.class);

            //올바르게 정보를 입력했다면...
            StandardPasswordEncoder encoder = new StandardPasswordEncoder();
            String secretPwd = encoder.encode(userVo.getPassword());

            //password 암호화 작업
            userVo.setPassword(secretPwd);

            userDao.insertUser(userVo);
            rolleDao.insertRolle("ROLE_GUEST", userVo.getUserkey(), "Y");

            //씨큐리티 로그인 작업 해주기.
            autoLogin.setUserid(userVo.getUserid());
            autoLogin.setUserpwd(userVo.getPassword());

            autoLogin.setRequest(request);
            autoLogin.setSqlSession(sqlSession);
            autoLogin.setAuthentication(autoLogin.getRequest(),autoLogin.getUserid(),autoLogin.getUserpwd());


            model.addAttribute("userkey", userVo.getUserkey());
            return "redirect:/";
        }
    }

    //사용안함.insert으로 옮김.. 그리고 sns은 따로 페이지를 만듬.
    @RequestMapping(value = "userdbjoin",method = RequestMethod.POST)
    public String userInsertdb(@Valid UserVo userVo,
                               BindingResult result,
                               Model model,
                               HttpSession session){


        if(result.hasErrors()){
            int teamCount = 0;
            model.addAttribute("teamCount",teamCount);
            return "/user/userjoin";
        }

        UserDao userDao = sqlSession.getMapper(UserDao.class);

/*        int usercount =  userDao.usercheck(userVo.getUserid());

        if(usercount > 0){
            System.out.println("값은  : "+usercount);
          return "redirect:" +"/userjoin?fail=idcheck";
        }*/

        StandardPasswordEncoder encoder = new StandardPasswordEncoder();
        String secretPwd = encoder.encode(userVo.getPassword());

        logger.info("패스워드 암호화 작업을 합니다 : "+ secretPwd);

        //password 암호화 작업
        userVo.setPassword(secretPwd);

        userDao.insertUser(userVo);

        model.addAttribute("userkey", userVo.getUserkey());

        RolleDao rolleDao = sqlSession.getMapper(RolleDao.class);
        rolleDao.insertRolle("ROLE_GUEST", userVo.getUserkey(), "Y");

        int teamCount = (Integer) session.getAttribute("teamCount");
        model.addAttribute("teamCount", teamCount);

        return "redirect:" +"/joinsucces";

    }

    @RequestMapping(value = "joinsucces",method = RequestMethod.GET)
    public String userWelcome(@RequestParam("userkey") int userkey,Model model){
        System.out.println("joinsucces()");

        UserDao userDao = sqlSession.getMapper(UserDao.class);
        UserVo userVo = userDao.selectOnerow(userkey);
        model.addAttribute("UserVo", userVo);

        int teamCount = 0;
        model.addAttribute("teamCount", teamCount);

        //회원가입에 대한 인사메일 보내기
        String subject = "Sport Team manager Soccer 사용 가입 안내 메일입니다";

        String content = " ["+userVo.getUserid() +"]님의 가입을 진심으로 감사드립니다.\n" +
                         "추가될만한 참신한 아이디어가 있으시다면 언제든지 제안해주세요.\n" +
                         "STM은 지도자 여러분들의 적극적인 참여로 함께 발전해 나가길 바랍니다.";


        SimpleMailMessage message = new SimpleMailMessage();

        message.setFrom("stmadmin@stm.com");
        message.setTo(userVo.getEmail());
        message.setSubject(subject);
        message.setText(content);
        mailSender.send(message);


        return "/user/joinsucces";
    }

    @RequestMapping("user/findinfo")
    public String findinfo(@RequestParam(required = false) String getflag,
                           Model model
                           ){
        // !값이 있다면 유저는 처음 페이지를 실행했다.


        model.addAttribute("getflag",getflag);

        return "/user/findinfo";
    }

    @RequestMapping(value = "find", method = RequestMethod.GET)
    public String sendRequestUser()
    {


        /*
        SimpleMailMessage message = new SimpleMailMessage();

        message.setFrom("stmadmin@stm.com");
        message.setTo(userVo.getEmail());
        message.setSubject(subject);
        message.setText(content);
        mailSender.send(message);
        */

        return "redirect:" +"/";
    }


}