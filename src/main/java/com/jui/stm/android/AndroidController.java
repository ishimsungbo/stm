package com.jui.stm.android;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Sungbo on 2016-03-17.
 */

@Controller
public class AndroidController {

    private static final Logger logger = LoggerFactory.getLogger(AndroidController.class);


    @RequestMapping(value= "/api/sendname", method= RequestMethod.POST)
    public @ResponseBody String AjaxView(HttpServletRequest request)  {

        String name = request.getParameter("name");
        logger.info("넘어온 값은 : "+ name);

        return name;
    }

    @RequestMapping(value= "/api/getname")
    public @ResponseBody
    List<Test> Test()  {

        logger.info("서버를 호출했습니다.");

        List<Test> test = new ArrayList<Test>();

        test.add(new Test("sungbo1"));
        test.add(new Test("sungbo2"));
        test.add(new Test("sungbo3"));

        return test;
    }

    class Test {
        private String name;

        public Test(String name) {
            this.name = name;
        }
        public String getName() {
            return name;
        }
        public void setName(String name) {
            this.name = name;
        }
    }

/*    @RequestMapping(value = "/an/send", method = RequestMethod.POST)
    public String messagepost(@RequestParam(required = false,value = "name") String name){

        logger.info("서버로 넘어온 값은 : "+name);

        return "messagepost";
    }*/



    @RequestMapping(value = "/an/send", method = RequestMethod.POST)
    public @ResponseBody String messagepost(HttpServletRequest request){
        String name = request.getParameter("name");
        logger.info("서버로 넘어온 값은 : "+name);
        String text = request.getParameter("text");
        logger.info("넘어온 값은 : "+ text);
        return "messagepost";
    }



}
