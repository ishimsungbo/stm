package com.jui.stm.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.LocaleResolver;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Locale;

/**
 * Created by Administrator on 2016-01-19.
 */
@Controller
public class LocalChangeController {


    @Autowired
    private LocaleResolver localeResolver;

    @RequestMapping("/changeLanguage")
    public String changer(@RequestParam("lang") String language,
                          HttpServletRequest request,
                          HttpServletResponse response){

        Locale locale = new Locale(language);
        localeResolver.setLocale(request,response,locale);
        return "redirect:/";
    }

    public void setLocaleResolver(LocaleResolver localeResolver) {
        this.localeResolver = localeResolver;
    }
}
