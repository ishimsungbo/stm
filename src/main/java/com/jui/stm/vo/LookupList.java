package com.jui.stm.vo;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by DIT213103 on 2015-08-17.
 */
public class LookupList {

    private List<LookupVo> lookupVos = new ArrayList<LookupVo>();

    public List<LookupVo> getLookupVos() {
        return lookupVos;
    }

    public void setLookupVos(List<LookupVo> lookupVos) {
        this.lookupVos = lookupVos;
    }
}
