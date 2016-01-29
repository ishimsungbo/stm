package com.jui.stm.vo;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by sungbo on 2016-01-03.
 */
public class PhysicalHeaderVo {

    private int headerid;
    private Date exdate;
    private int teamid;
    private String performer;
    private String exclass;
    private String description;
    private String extdate;

    public PhysicalHeaderVo(){}


    public PhysicalHeaderVo(int headerid, Date exdate, int teamid, String performer, String exclass, String description) {
        this.headerid = headerid;
        this.exdate = exdate;
        this.teamid = teamid;
        this.performer = performer;
        this.exclass = exclass;
        this.description = description;
    }

    public String getExtdate() {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        extdate = dateFormat.format(exdate);
        return extdate;
    }

    public void setExtdate(String extdate) {
        this.extdate = extdate;
    }

    public Date getExdate() {
        return exdate;
    }

    public void setExdate(Date exdate) {
        this.exdate = exdate;
    }

    public String getExclass() {
        return exclass;
    }

    public void setExclass(String exclass) {
        this.exclass = exclass;
    }

    public int getHeaderid() {
        return headerid;
    }

    public void setHeaderid(int headerid) {
        this.headerid = headerid;
    }

    public int getTeamid() {
        return teamid;
    }

    public void setTeamid(int teamid) {
        this.teamid = teamid;
    }

    public String getPerformer() {
        return performer;
    }

    public void setPerformer(String performer) {
        this.performer = performer;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }


}
