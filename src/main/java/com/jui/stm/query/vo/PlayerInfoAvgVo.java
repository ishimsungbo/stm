package com.jui.stm.query.vo;

import java.util.Date;

/**
 * Created by Administrator on 2016-01-23.
 */
public class PlayerInfoAvgVo {

    private int teamid;
    private int playerid;
    private String exclass;
    private String positioncode;
    private String weather;
    private int exgameid;
    private int gameid;
    private int count;
    private int goal;
    private int asist;
    private int intime;
    private Date fromdate;
    private Date todate;

    public PlayerInfoAvgVo(){}

    public PlayerInfoAvgVo(int teamid, int playerid, String exclass, String positioncode, String weather, int exgameid, int gameid, int count, int goal, int asist, int intime, Date fromdate, Date todate) {
        this.teamid = teamid;
        this.playerid = playerid;
        this.exclass = exclass;
        this.positioncode = positioncode;
        this.weather = weather;
        this.exgameid = exgameid;
        this.gameid = gameid;
        this.count = count;
        this.goal = goal;
        this.asist = asist;
        this.intime = intime;
        this.fromdate = fromdate;
        this.todate = todate;
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

    public String getExclass() {
        return exclass;
    }

    public void setExclass(String exclass) {
        this.exclass = exclass;
    }

    public String getPositioncode() {
        return positioncode;
    }

    public void setPositioncode(String positioncode) {
        this.positioncode = positioncode;
    }

    public String getWeather() {
        return weather;
    }

    public void setWeather(String weather) {
        this.weather = weather;
    }

    public int getExgameid() {
        return exgameid;
    }

    public void setExgameid(int exgameid) {
        this.exgameid = exgameid;
    }

    public int getGameid() {
        return gameid;
    }

    public void setGameid(int gameid) {
        this.gameid = gameid;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }

    public int getGoal() {
        return goal;
    }

    public void setGoal(int goal) {
        this.goal = goal;
    }

    public int getAsist() {
        return asist;
    }

    public void setAsist(int asist) {
        this.asist = asist;
    }

    public int getIntime() {
        return intime;
    }

    public void setIntime(int intime) {
        this.intime = intime;
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

