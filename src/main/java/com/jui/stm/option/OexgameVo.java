package com.jui.stm.option;

/**
 * Created by sungbo on 2015-12-28.
 */
public class OexgameVo {

    private int teamid;
    private int exgameid;
    private String exgamename;
    private String exclass;

    public int getExgameid() {
        return exgameid;
    }

    public void setExgameid(int exgameid) {
        this.exgameid = exgameid;
    }

    public String getExgamename() {
        return exgamename;
    }

    public void setExgamename(String exgamename) {
        this.exgamename = exgamename;
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
}
