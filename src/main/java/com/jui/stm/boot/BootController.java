package com.jui.stm.boot;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by sungbo on 2015-11-20.
 */
@Controller
public class BootController {

    @RequestMapping("boot/verticality_list")
    public String verticality(){
        return "/boot/verticality_list";
    }
}
