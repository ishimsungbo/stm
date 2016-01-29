package com.jui.stm.test;

import com.jui.stm.vo.EvaluationVo;

/**
 * Created by Administrator on 2016-01-25.
 */
public class Test {

    public static void main(String[] args)
    {
        EvaluationVo vo = new EvaluationVo();

        vo.setExclass("E");

        System.out.println(vo.getExclassdisp());
    }

}
