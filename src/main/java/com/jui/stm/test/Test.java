package com.jui.stm.test;

import java.util.Random;

/**
 * Created by Administrator on 2016-01-25.
 */
public class Test {

    public static void main(String[] args)
    {
        Random rd = new Random();

        System.out.print(rd.nextInt()*-10);
    }

}
