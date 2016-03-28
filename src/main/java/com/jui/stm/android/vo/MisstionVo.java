package com.jui.stm.android.vo;

/**
 * Created by Sungbo on 2016-03-22.
 */
public class MisstionVo {

    private int youid;
    private String  youpath;
    private String  mname;
    private String  description;

    public MisstionVo(){}

    public MisstionVo(int youid, String youpath, String mname, String description) {
        this.youid = youid;
        this.youpath = youpath;
        this.mname = mname;
        this.description = description;
    }

    public int getYouid() {
        return youid;
    }

    public void setYouid(int youid) {
        this.youid = youid;
    }

    public String getYoupath() {
        return youpath;
    }

    public void setYoupath(String youpath) {
        this.youpath = youpath;
    }

    public String getMname() {
        return mname;
    }

    public void setMname(String mname) {
        this.mname = mname;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
