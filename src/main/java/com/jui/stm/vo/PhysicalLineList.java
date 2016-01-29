package com.jui.stm.vo;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by sungbo on 2016-01-04.
 */
public class PhysicalLineList {

    List<PhysicalLineVo> lineVos = new ArrayList<PhysicalLineVo>();

    public PhysicalLineList(){}

    public PhysicalLineList(List<PhysicalLineVo> lineVos) {
        this.lineVos = lineVos;
    }

    public List<PhysicalLineVo> getLineVos() {
        return lineVos;
    }

    public void setLineVos(List<PhysicalLineVo> lineVos) {
        this.lineVos = lineVos;
    }
}
