package com.jui.stm.test;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.jui.stm.controller.CommonController;
import com.jui.stm.testvo.SocialPerson;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by sungbo on 2015-12-07.
 */
@Controller
public class AjaxTestController {

    private static final Logger logger = LoggerFactory.getLogger(CommonController.class);

    // response객체에 문자열 담기
    // 첫번째 방법으로 aform 페이지에서 데이터를 생성하고 다시 되돌려 받기
    @RequestMapping("ajax/aform")
    public String A(){
        return "/ajax/aform";
    }

    @RequestMapping(value= "ajax/bform", method=RequestMethod.GET)
    public void bform(
            @RequestParam("id") String id,
            HttpServletResponse response)  {

        logger.info("ㅍ 프로그램시작");
        logger.info("Aform에서 보낸 id 값 : " + id);

        String personJson;

        SocialPerson person = new SocialPerson("ileanlife","심성보","ss1591","ileanlife@naver.com"); //dao.getPerson(id);
        if(person != null){
            personJson = "{\"id\":\""+person.getId()
                    +"\",\"name\":\""+person.getName()
                    +"\",\"password\":\""+person.getPassword()
                    +"\",\"email\":\""+person.getEmail()+"\"}";
        }
        else{
            personJson = "null";
        }
        try {
            logger.info("Aform에서 보낸 id 값 : " + id);
            response.getWriter().print(personJson);
        } catch (IOException e) {
            e.printStackTrace();
            logger.info("에러 발생합니다.");
        }
    }


    //2 번째 방법 ObjectMapper
    /*
    두번째로 살펴볼 방법은 ObjectMapper객체를 사용하는 방법입니다.
    ObjectMapper 객체를 사용하여도 HttpServletResponse 객체를 사용합니다.
    하지만 ObjectMapper객체를 사용하게되면 위 방법처럼 문자열을 개발자가 작성할 필요없이
    해당 객체를 Json형식의 문자열로 바꾸어주게 되어 개발자가 좀 더 간단하게 구현할 수 있습니다.
    ObjectMapper 객체를 사용 하기위해서는 구현에 앞서 jackson-databind 라이브러리를 프로젝트에 추가해야 합니다.
    jackson-databind라이브러리를 다운받아  lib폴더에 추가 시켜주거나 Maven 프로젝트 일경우 pom.xml경우에 아래와 같이 dependency 해주면 됩니다.
<dependency>
    <groupId>com.fasterxml.jackson.core</groupId>
    <artifactId>jackson-databind</artifactId>
    <version>버전</version>
</dependency>
    */
    @RequestMapping("ajax/aform02")
    public String aform02(){
        return "/ajax/aform02";
    }



    //Controller
    @RequestMapping(value= "ajax/bform02", method=RequestMethod.GET)
    public void AjaxView(
            @RequestParam("id") String id,
            HttpServletResponse response)  {

        logger.info("bform02 프로그램시작");
        logger.info("Aform02 에서 보낸 id 값 : " + id);

        ObjectMapper mapper = new ObjectMapper();

        SocialPerson person = new SocialPerson("ileanlife","심성보","ss1591","ileanlife@naver.com"); //dao.getPerson(id);

        try {
            response.getWriter().print(mapper.writeValueAsString(person));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    /*
    3. @ResponseBody 사용법
    위 코드는 @ResponseBody방식에 대한 간단한 예제 코드입니다.
    Script코드에서 서버(Controller)에 input태그에 입력된  id값을  전송하면  Controller에서는 해당 데이터를 parameter로 받고 그 id값으로 DB를 조회합니다.
    앞서 말하였듯 return형 앞에 @ResponseBody를 사용하고 해당 객체를 return해주기만 하면 ajax success함수의 data에 person객체가 Json객체로 변환 후 전송되어 파싱이 필요없습니다..

     <dependency>
	   <groupId>org.codehaus.jackson</groupId>
	   <artifactId>jackson-mapper-asl</artifactId>
	   <version>버전</version>
</dependency>
     */

    @RequestMapping("ajax/aform03")
    public String aform03(){
        logger.info("aform03 호출합니다.");
        return "/ajax/aform03";
    }

    //Controller  produces = "text/plain;charset=UTF-8"
    @RequestMapping(value= "ajax/bform03", method=RequestMethod.GET)
    public @ResponseBody SocialPerson AjaxView(
            @RequestParam(required = false,value="id") String id)  {

        logger.info("bform03 프로그램시작");
        logger.info("Aform03 에서 보낸 id 값 : " + id);

        SocialPerson person = new SocialPerson("ileanlife","심성보","ss1591","ileanlife@naver.com"); //dao.getPerson(id);

        logger.info("조회한 객체 값은 : "+ person.getName());

        //객체를 리턴한다.
        return person;
    }

    /*
    04. jsonView 사용
        설정 (maven, servlet context)
    */

    @RequestMapping("ajax/aform04")
    public String aform04(){
        logger.info("aform04 호출합니다.");
        return "/ajax/aform04";
    }



    @RequestMapping(value= "/ajax/bform04", method=RequestMethod.GET)
    public ModelAndView AjaxViewt( @RequestParam(required = false,value = "id") String id)  {

        logger.info("bform04 프로그램시작");
        logger.info("Aform04 에서 보낸 id 값 : " + id);

        ModelAndView mav= new ModelAndView();

        SocialPerson person = new SocialPerson("ileanlife","심성보","ss1591","ileanlife@naver.com"); //dao.getPerson(id);

        logger.info("조회한 객체 값은 : "+ person.getName());

        mav.addObject("person",person);
        mav.setViewName("/ajax/jsonView");
        return mav;
    }

//    @RequestMapping(value= "/ajax/bform04", method=RequestMethod.GET)
//    public String AjaxViewts(@RequestParam(required = false,value = "id") String id,Model model){
//        logger.info("bform04 프로그램시작");
//        logger.info("Aform04 에서 보낸 id 값 : " + id);
//        SocialPerson person = new SocialPerson("ileanlife","심성보","ss1591","ileanlife@naver.com"); //dao.getPerson(id);
//
//        JSONArray jsonArray = new JSONArray();
//        model.addAttribute("jsonList", jsonArray.fromObject(person));
//
//        model.addAttribute("person",person);
//        return "/ajax/jsonView";
//    }




}
