package com.jui.stm.vo;

/**
 * Created by sungbo on 2015-12-21.
 */
public class TrJrPlayerVo {

    private int trjournalplid;
    private int playerid;
    private String status;      //참여여부
    private int satisfaction; //만족점수
    private String injury;  //부상여부
    private String injurydesc; //부상의 종류
    private String description; //선수의 일일 훈련 특별 사항
    private int jeid;
    private int teamid;
    private String playername;

    public TrJrPlayerVo(){}

    public TrJrPlayerVo(int trjournalplid, int playerid, String status, int satisfaction, String injury, String injurydesc, String description, int jeid, int teamid, String playername) {
        this.trjournalplid = trjournalplid;
        this.playerid = playerid;
        this.status = status;
        this.satisfaction = satisfaction;
        this.injury = injury;
        this.injurydesc = injurydesc;
        this.description = description;
        this.jeid = jeid;
        this.teamid = teamid;
        this.playername = playername;
    }

    public String getPlayername() {
        return playername;
    }

    public void setPlayername(String playername) {
        this.playername = playername;
    }

    public int getTrjournalplid() {
        return trjournalplid;
    }

    public void setTrjournalplid(int trjournalplid) {
        this.trjournalplid = trjournalplid;
    }

    public int getPlayerid() {
        return playerid;
    }

    public void setPlayerid(int playerid) {
        this.playerid = playerid;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getSatisfaction() {
        return satisfaction;
    }

    public void setSatisfaction(int satisfaction) {
        this.satisfaction = satisfaction;
    }

    public String getInjury() {
        return injury;
    }

    public void setInjury(String injury) {
        this.injury = injury;
    }

    public String getInjurydesc() {
        return injurydesc;
    }

    public void setInjurydesc(String injurydesc) {
        this.injurydesc = injurydesc;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getJeid() {
        return jeid;
    }

    public void setJeid(int jeid) {
        this.jeid = jeid;
    }

    public int getTeamid() {
        return teamid;
    }

    public void setTeamid(int teamid) {
        this.teamid = teamid;
    }
}
