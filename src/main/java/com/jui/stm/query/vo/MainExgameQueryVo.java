package com.jui.stm.query.vo;

/**
 * Created by sungbo on 2016-01-08.
 */
public class MainExgameQueryVo {
    private int teamid;
    private String exclass;
    private String fromdate;
    private String todate;
    private int playerid;
    private int gameid;
    private int matchid;

    public MainExgameQueryVo(){};

    public MainExgameQueryVo(int teamid, String exclass, String fromdate, String todate, int playerid, int gameid, int matchid) {
        this.teamid = teamid;
        this.exclass = exclass;
        this.fromdate = fromdate;
        this.todate = todate;
        this.playerid = playerid;
        this.gameid = gameid;
        this.matchid = matchid;
    }

    public int getMatchid() {
        return matchid;
    }

    public void setMatchid(int matchid) {
        this.matchid = matchid;
    }

    public int getGameid() {
        return gameid;
    }

    public void setGameid(int gameid) {
        this.gameid = gameid;
    }

    public int getPlayerid() {
        return playerid;
    }

    public void setPlayerid(int playerid) {
        this.playerid = playerid;
    }

    public String getFromdate() {
        return fromdate;
    }

    public void setFromdate(String fromdate) {
        this.fromdate = fromdate;
    }

    public String getTodate() {
        return todate;
    }

    public void setTodate(String todate) {
        this.todate = todate;
    }

    public int getTeamid() {
        return teamid;
    }

    public void setTeamid(int teamid) {
        this.teamid = teamid;
    }

    public String getExclass() {
        return exclass;
    }

    public void setExclass(String exclass) {
        this.exclass = exclass;
    }
}
