package com.jui.stm.query.vo;

/**
 * Created by Administrator on 2016-01-19.
 */
public class MatchForgameVo {
    private int matchid;
    private String name;

    public MatchForgameVo() {
    }

    public MatchForgameVo(int matchid, String name) {
        this.matchid = matchid;
        this.name = name;
    }

    public int getMatchid() {
        return matchid;
    }

    public void setMatchid(int matchid) {
        this.matchid = matchid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
