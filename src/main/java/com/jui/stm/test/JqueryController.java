package com.jui.stm.test;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * Created by sungbo on 2015-10-31.
 */
@Controller
public class JqueryController {

    @RequestMapping("test/css")
    public String Css(@RequestParam("param") String param){



        return "/test/css";
    }

}
