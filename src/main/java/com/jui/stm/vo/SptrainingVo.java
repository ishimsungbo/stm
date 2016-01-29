package com.jui.stm.vo;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by sungbo on 2015-12-14.
 */
public class SptrainingVo {

    private int sptrid;
    private Date fromdate;
    private Date todate;
    private String subject;
    private String location;
    private String object;
    private String addscflag;
    private String description;
    private int ballcount;
    private int conecount;
    private int platecount;
    private int vestuniform;
    private int polescount;
    private int hurdles;
    private int ladder;
    private int roundbases;
    private int participationplayer;
    private int teamid;

    private String exfromdate;
    private String extomdate;

    public String getExfromdate() {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        exfromdate = dateFormat.format(fromdate);
        return exfromdate;
    }

    public void setExfromdate(String exfromdate) {
        this.exfromdate = exfromdate;
    }

    public String getExtomdate() {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        extomdate = dateFormat.format(todate);
        return extomdate;
    }

    public void setExtomdate(String extomdate) {
        this.extomdate = extomdate;
    }

    public SptrainingVo(){}

    public SptrainingVo(int sptrid, Date fromdate, Date todate, String subject, String location, String object, String addscflag, String description, int ballcount, int conecount, int platecount, int vestuniform, int polescount, int hurdles, int ladder, int roundbases, int participationplayer, int teamid) {
        this.sptrid = sptrid;
        this.fromdate = fromdate;
        this.todate = todate;
        this.subject = subject;
        this.location = location;
        this.object = object;
        this.addscflag = addscflag;
        this.description = description;
        this.ballcount = ballcount;
        this.conecount = conecount;
        this.platecount = platecount;
        this.vestuniform = vestuniform;
        this.polescount = polescount;
        this.hurdles = hurdles;
        this.ladder = ladder;
        this.roundbases = roundbases;
        this.participationplayer = participationplayer;
        this.teamid = teamid;
    }

    public int getTeamid() {
        return teamid;
    }

    public void setTeamid(int teamid) {
        this.teamid = teamid;
    }

    public int getSptrid() {
        return sptrid;
    }

    public void setSptrid(int sptrid) {
        this.sptrid = sptrid;
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

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getObject() {
        return object;
    }

    public void setObject(String object) {
        this.object = object;
    }

    public String getAddscflag() {
        return addscflag;
    }

    public void setAddscflag(String addscflag) {
        this.addscflag = addscflag;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getBallcount() {
        return ballcount;
    }

    public void setBallcount(int ballcount) {
        this.ballcount = ballcount;
    }

    public int getConecount() {
        return conecount;
    }

    public void setConecount(int conecount) {
        this.conecount = conecount;
    }

    public int getPlatecount() {
        return platecount;
    }

    public void setPlatecount(int platecount) {
        this.platecount = platecount;
    }

    public int getVestuniform() {
        return vestuniform;
    }

    public void setVestuniform(int vestuniform) {
        this.vestuniform = vestuniform;
    }

    public int getPolescount() {
        return polescount;
    }

    public void setPolescount(int polescount) {
        this.polescount = polescount;
    }

    public int getHurdles() {
        return hurdles;
    }

    public void setHurdles(int hurdles) {
        this.hurdles = hurdles;
    }

    public int getLadder() {
        return ladder;
    }

    public void setLadder(int ladder) {
        this.ladder = ladder;
    }

    public int getRoundbases() {
        return roundbases;
    }

    public void setRoundbases(int roundbases) {
        this.roundbases = roundbases;
    }

    public int getParticipationplayer() {
        return participationplayer;
    }

    public void setParticipationplayer(int participationplayer) {
        this.participationplayer = participationplayer;
    }
}
