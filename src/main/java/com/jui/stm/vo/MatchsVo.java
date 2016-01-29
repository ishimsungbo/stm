package com.jui.stm.vo;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by Administrator on 2016-01-11.
 */
public class MatchsVo {

    private int matchid;
    private String name;
    private Date fromdate;
    private Date todate;
    private String location;
    private String description;
    private int teamid;
    private String exclass;

    private String goal;
    private String preparation;
    private String satisfaction;
    private String lack;
    private String formation;

    private String efromdate;
    private String etodate;

    private String wincount;
    private String losscount;

    public MatchsVo(){}

    public MatchsVo(int matchid, String name, Date fromdate, Date todate, String location, String description, int teamid, String exclass, String goal, String preparation, String satisfaction, String lack, String formation, String efromdate, String etodate) {
        this.matchid = matchid;
        this.name = name;
        this.fromdate = fromdate;
        this.todate = todate;
        this.location = location;
        this.description = description;
        this.teamid = teamid;
        this.exclass = exclass;
        this.goal = goal;
        this.preparation = preparation;
        this.satisfaction = satisfaction;
        this.lack = lack;
        this.formation = formation;
        this.efromdate = efromdate;
        this.etodate = etodate;
    }

    public String getWincount() {
        return wincount;
    }

    public void setWincount(String wincount) {
        this.wincount = wincount;
    }

    public String getLosscount() {
        return losscount;
    }

    public void setLosscount(String losscount) {
        this.losscount = losscount;
    }

    public String getFormation() {
        return formation;
    }

    public void setFormation(String formation) {
        this.formation = formation;
    }

    public String getGoal() {
        return goal;
    }

    public void setGoal(String goal) {
        this.goal = goal;
    }

    public String getPreparation() {
        return preparation;
    }

    public void setPreparation(String preparation) {
        this.preparation = preparation;
    }

    public String getSatisfaction() {
        return satisfaction;
    }

    public void setSatisfaction(String satisfaction) {
        this.satisfaction = satisfaction;
    }

    public String getLack() {
        return lack;
    }

    public void setLack(String lack) {
        this.lack = lack;
    }

    public String getEfromdate() {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        efromdate = dateFormat.format(fromdate);
        return efromdate;
    }

    public void setEfromdate(String efromdate) {
        this.efromdate = efromdate;
    }

    public String getEtodate() {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        etodate = dateFormat.format(todate);
        return etodate;
    }

    public void setEtodate(String etodate) {
        this.etodate = etodate;
    }


    public String getExclass() {
        return exclass;
    }

    public void setExclass(String exclass) {
        this.exclass = exclass;
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

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getTeamid() {
        return teamid;
    }

    public void setTeamid(int teamid) {
        this.teamid = teamid;
    }
}
