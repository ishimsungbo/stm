package com.jui.stm.vo;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by sungbo on 2015-12-21.
 */
public class TrJrPlayerList {

    private List<TrJrPlayerVo> trJrPlayerVos = new ArrayList<TrJrPlayerVo>();

    public List<TrJrPlayerVo> getTrJrPlayerVos() {
        return trJrPlayerVos;
    }

    public void setTrJrPlayerVos(List<TrJrPlayerVo> trJrPlayerVos) {
        this.trJrPlayerVos = trJrPlayerVos;
    }
}
