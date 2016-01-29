package com.jui.stm.vo;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by sungbo on 2015-11-09.
 */
public class CoachingVo {

    private int coachingid;
    private int playerid;
    private String  coachinglevel;
    private Date date;
    private String coachingtype;
    private int learnscore;
    private Date creationdate;
    private int teamid;
    private String recoachingflag;
    private String cause;
    private String problem;
    private String solution;
    private String playername;
    private String leveldisp;
    private String typedisp;
    private String subject;

    private String rgdate;

    public CoachingVo(){}

    public CoachingVo(int coachingid, int playerid, String coachinglevel, Date date, String coachingtype, int learnscore, Date creationdate, int teamid, String recoachingflag, String cause, String problem, String solution, String playername, String leveldisp, String typedisp, String subject, String rgdate) {
        this.coachingid = coachingid;
        this.playerid = playerid;
        this.coachinglevel = coachinglevel;
        this.date = date;
        this.coachingtype = coachingtype;
        this.learnscore = learnscore;
        this.creationdate = creationdate;
        this.teamid = teamid;
        this.recoachingflag = recoachingflag;
        this.cause = cause;
        this.problem = problem;
        this.solution = solution;
        this.playername = playername;
        this.leveldisp = leveldisp;
        this.typedisp = typedisp;
        this.subject = subject;
        this.rgdate = rgdate;
    }

    public String getRgdate() {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        rgdate = dateFormat.format(date);

        return rgdate;
    }

    public void setRgdate(String rgdate) {
        this.rgdate = rgdate;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public int getCoachingid() {
        return coachingid;
    }

    public void setCoachingid(int coachingid) {
        this.coachingid = coachingid;
    }

    public int getPlayerid() {
        return playerid;
    }

    public void setPlayerid(int playerid) {
        this.playerid = playerid;
    }

    public String getCoachinglevel() {
        return coachinglevel;
    }

    public void setCoachinglevel(String coachinglevel) {
        this.coachinglevel = coachinglevel;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getCoachingtype() {
        return coachingtype;
    }

    public void setCoachingtype(String coachingtype) {
        this.coachingtype = coachingtype;
    }

    public int getLearnscore() {
        return learnscore;
    }

    public void setLearnscore(int learnscore) {
        this.learnscore = learnscore;
    }

    public Date getCreationdate() {
        return creationdate;
    }

    public void setCreationdate(Date creationdate) {
        this.creationdate = creationdate;
    }

    public int getTeamid() {
        return teamid;
    }

    public void setTeamid(int teamid) {
        this.teamid = teamid;
    }

    public String getRecoachingflag() {
        return recoachingflag;
    }

    public void setRecoachingflag(String recoachingflag) {
        this.recoachingflag = recoachingflag;
    }

    public String getCause() {
        return cause;
    }

    public void setCause(String cause) {
        this.cause = cause;
    }

    public String getProblem() {
        return problem;
    }

    public void setProblem(String problem) {
        this.problem = problem;
    }

    public String getSolution() {
        return solution;
    }

    public void setSolution(String solution) {
        this.solution = solution;
    }

    public String getPlayername() {
        return playername;
    }

    public void setPlayername(String playername) {
        this.playername = playername;
    }

    public String getLeveldisp() {
        return leveldisp;
    }

    public void setLeveldisp(String leveldisp) {
        this.leveldisp = leveldisp;
    }

    public String getTypedisp() {
        return typedisp;
    }

    public void setTypedisp(String typedisp) {
        this.typedisp = typedisp;
    }
}
