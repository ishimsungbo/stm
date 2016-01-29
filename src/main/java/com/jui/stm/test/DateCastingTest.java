package com.jui.stm.test;

import java.text.SimpleDateFormat;

/**
 * Created by sungbo on 2015-11-16.
 */
public class DateCastingTest {





    public static void main(String[] args) {


        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-mm-dd");




        try{

            String intd="2015-01-01";

            System.out.println("날짠는 " + dateFormat.parse(intd));


        }catch (Exception e){
            e.printStackTrace();
        }


    }
}
