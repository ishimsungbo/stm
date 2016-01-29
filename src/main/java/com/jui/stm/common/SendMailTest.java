package com.jui.stm.common;


import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSenderImpl;

import java.util.Properties;

class Mailtest{

    public void mailSetting(){

        JavaMailSenderImpl mailSender = new JavaMailSenderImpl();

        try{
            mailSender.setHost("smtp.gmail.com");
            mailSender.setPort(587);
            mailSender.setUsername("ishimsungbo@gmail.com");
            mailSender.setPassword("ss780323s");
            mailSender.setDefaultEncoding("euc-kr");

            Properties properties = System.getProperties();
            properties.setProperty("mail.smtp.auth", "true");
            properties.setProperty("mail.smtp.starttls.enable", "true");
            mailSender.setJavaMailProperties(properties);

            SimpleMailMessage message = new SimpleMailMessage();
            message.setFrom("ishimsungbo@gmail.com");
            message.setTo("ileanlife@naver.com");
            message.setSubject("안녕나야나야");
            message.setText("본문 너무 반간답이자슥아");
            mailSender.send(message);

        }catch (Exception e){
            e.printStackTrace();
        }


    }
}

public class SendMailTest{




    public static void main( String[] args ){

        Mailtest mailtest = new Mailtest();
        mailtest.mailSetting();


    }

//    public static void main( String[] args )
//    {
//        ApplicationContext context =
//                new ClassPathXmlApplicationContext("/bean/Spring-Mail.xml");
//
//        MailMail mm = (MailMail) context.getBean("mailMail");
//        mm.sendMail("ishimsungbo@gmail.com",
//                "ileanlife@naver.com",
//                "안녕하세요",
//                "나 심이랍니다.");
//
//    }
}