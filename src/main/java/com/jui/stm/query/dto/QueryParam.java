package com.jui.stm.query.dto;

import java.util.Date;

/**
 * Created by Administrator on 2016-01-15.
 */
public class QueryParam {

    private int teamid;
    private int playerid;
    private Date date;
    private String exclass;

    private Date fromdate;
    private Date todate;

    public QueryParam(){}

    public QueryParam(int teamid, int playerid, Date date, String exclass, Date fromdate, Date todate) {
        this.teamid = teamid;
        this.playerid = playerid;
        this.date = date;
        this.exclass = exclass;
        this.fromdate = fromdate;
        this.todate = todate;
    }

    public String getExclass() {
        return exclass;
    }

    public void setExclass(String exclass) {
        this.exclass = exclass;
    }

    public int getTeamid() {
        return teamid;
    }

    public void setTeamid(int teamid) {
        this.teamid = teamid;
    }

    public int getPlayerid() {
        return playerid;
    }

    public void setPlayerid(int playerid) {
        this.playerid = playerid;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public Date getFromdate() {
        return fromdate;
    }

    public void setFromdate(Date fromdate) {
        this.fromdate = fromdate;
    }

    public Date getTodate() {
        return todate;
    }

    public void setTodate(Date todate) {
        this.todate = todate;
    }

}
