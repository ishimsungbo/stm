package com.spring.xml;

import com.spring.bean.HelloBean;

/**
 * Created by sungbo on 2015-11-02.
 */
public class XmlBean implements HelloBean {

    @Override
    public void sayHello(){
        System.out.println("안녕하세요. 나는 XML Bean 입니다.");
    }

}
