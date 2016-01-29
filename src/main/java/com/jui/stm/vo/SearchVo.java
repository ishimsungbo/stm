package com.jui.stm.vo;

/**
 * Created by sungbo on 2015-11-06.
 */
public class SearchVo {

    private int teamid;
    private String playername;
    private int playerid;
    private String teamname;
    private String  textdisp;
    private int sptrid;

    public SearchVo(){}

    public SearchVo(int teamid, String playername, int playerid, String teamname, String textdisp, int sptrid) {
        this.teamid = teamid;
        this.playername = playername;
        this.playerid = playerid;
        this.teamname = teamname;
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

    public int getTeamid() {
        return teamid;
    }

    public void setTeamid(int teamid) {
        this.teamid = teamid;
    }

    public String getPlayername() {
        return playername;
    }

    public void setPlayername(String playername) {
        this.playername = playername;
    }

    public int getPlayerid() {
        return playerid;
    }

    public void setPlayerid(int playerid) {
        this.playerid = playerid;
    }

    public String getTeamname() {
        return teamname;
    }

    public void setTeamname(String teamname) {
        this.teamname = teamname;
    }


}
