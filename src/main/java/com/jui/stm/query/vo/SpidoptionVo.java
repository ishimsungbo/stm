package com.jui.stm.query.vo;

/**
 * Created by sungbo on 2015-12-14.
 */
public class SpidoptionVo {

    private String  textdisp;
    private int sptrid;

    public SpidoptionVo(){}

    public SpidoptionVo(String textdisp, int sptrid) {
        this.textdisp = textdisp;
        this.sptrid = sptrid;
    }

    public String getTextdisp() {
        return textdisp;
    }

    public void setTextdisp(String textdisp) {
        this.textdisp = textdisp;
    }

    public int getSptrid() {
        return sptrid;
    }

    public void setSptrid(int sptrid) {
        this.sptrid = sptrid;
    }
}
