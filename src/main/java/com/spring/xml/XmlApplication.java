package com.spring.xml;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

/**
 * Created by sungbo on 2015-11-02.
 */
//@ImportResource("classpath*:spring/spring-config.xml")
public class XmlApplication {
    public static void main(String[] args){

        ApplicationContext context = new ClassPathXmlApplicationContext("spring/spring-config.xml");
        XmlBean bean = (XmlBean)context.getBean("xmlBean");

        bean.sayHello();
    }
}
