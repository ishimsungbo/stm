package com.jui.stm.vo;

/**
 * Created by sungbo on 2015-12-21.
 */
public class TrProVo {

    private String trname;
    private int    trainingid;

    public TrProVo(){}

    public TrProVo(String trname, int trainingid) {
        this.trname = trname;
        this.trainingid = trainingid;
    }

    public String getTrname() {
        return trname;
    }

    public void setTrname(String trname) {
        this.trname = trname;
    }

    public int getTrainingid() {
        return trainingid;
    }

    public void setTrainingid(int trainingid) {
        this.trainingid = trainingid;
    }
}
