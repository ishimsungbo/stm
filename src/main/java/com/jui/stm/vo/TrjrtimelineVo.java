package com.jui.stm.vo;

/**
 * Created by sungbo on 2015-12-21.
 */
public class TrjrtimelineVo {

    private int jeid;
    private int timelineid;
    private int teamid;

    private int trminute;         //훈련시간(분)
    private int trainingid;       //훈련시간(프로그램 아이디)
    private String description;   //훈련복기
    private int satisfaction;     //부분훈련성과 점수
    private int linenum;
    private String trname;

    public TrjrtimelineVo(){}

    public TrjrtimelineVo(int timelineid) {
        this.timelineid = timelineid;
    }

    public TrjrtimelineVo(int jeid, int timelineid, int teamid, int trminute, int trainingid, String description, int satisfaction, int linenum, String trname) {
        this.jeid = jeid;
        this.timelineid = timelineid;
        this.teamid = teamid;
        this.trminute = trminute;
        this.trainingid = trainingid;
        this.description = description;
        this.satisfaction = satisfaction;
        this.linenum = linenum;
        this.trname = trname;
    }

    public String getTrname() {
        return trname;
    }

    public void setTrname(String trname) {
        this.trname = trname;
    }

    public int getJeid() {
        return jeid;
    }

    public int getLinenum() {
        return linenum;
    }

    public void setLinenum(int linenum) {
        this.linenum = linenum;
    }

    public void setJeid(int jeid) {
        this.jeid = jeid;
    }

    public int getTimelineid() {
        return timelineid;
    }

    public void setTimelineid(int timelineid) {
        this.timelineid = timelineid;
    }

    public int getTeamid() {
        return teamid;
    }

    public void setTeamid(int teamid) {
        this.teamid = teamid;
    }

    public int getTrminute() {
        return trminute;
    }

    public void setTrminute(int trminute) {
        this.trminute = trminute;
    }

    public int getTrainingid() {
        return trainingid;
    }

    public void setTrainingid(int trainingid) {
        this.trainingid = trainingid;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getSatisfaction() {
        return satisfaction;
    }

    public void setSatisfaction(int satisfaction) {
        this.satisfaction = satisfaction;
    }
}
