package com.jui.stm.vo;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by sungbo on 2015-11-09.
 */
public class ExGameVo {

    private int exgameid;
    private int teamid;
    private String exclass;
    private String oppoteam;
    private Date exgamedate;
    private String location;
    private String weather;
    private int fw;
    private int mf;
    private int df;
    private int org;
    private  int passing;
    private int fig;
    private int shooting;
    private int setplay;
    private int fhwrecord;
    private int fhorecord;
    private int shwrecord;
    private int shorecord;
    private String result;
    private String formation;
    private String objectpoint;
    private String fw_description;
    private String mf_description;
    private String df_description;
    private String description;
    private String youtubesource;
    private int    sptrid;
    private String extrgamedate;
    private String scheduleflag;
    private int playercount;


    public int getPlayercount() {
        return playercount;
    }

    public void setPlayercount(int playercount) {
        this.playercount = playercount;
    }

    public String getExtrgamedate() {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        extrgamedate = dateFormat.format(exgamedate);
        return extrgamedate;
    }

    public void setExtrgamedate(String extrgamedate) {
        this.extrgamedate = extrgamedate;
    }

    public ExGameVo() {}

    public ExGameVo(int exgameid, int teamid, String exclass, String oppoteam, Date exgamedate, String location, String weather, int fw, int mf, int df, int org, int passing, int fig, int shooting, int setplay, int fhwrecord, int fhorecord, int shwrecord, int shorecord, String result, String formation, String objectpoint, String fw_description, String mf_description, String df_description, String description, String youtubesource, int sptrid, String extrgamedate, String scheduleflag) {
        this.exgameid = exgameid;
        this.teamid = teamid;
        this.exclass = exclass;
        this.oppoteam = oppoteam;
        this.exgamedate = exgamedate;
        this.location = location;
        this.weather = weather;
        this.fw = fw;
        this.mf = mf;
        this.df = df;
        this.org = org;
        this.passing = passing;
        this.fig = fig;
        this.shooting = shooting;
        this.setplay = setplay;
        this.fhwrecord = fhwrecord;
        this.fhorecord = fhorecord;
        this.shwrecord = shwrecord;
        this.shorecord = shorecord;
        this.result = result;
        this.formation = formation;
        this.objectpoint = objectpoint;
        this.fw_description = fw_description;
        this.mf_description = mf_description;
        this.df_description = df_description;
        this.description = description;
        this.youtubesource = youtubesource;
        this.sptrid = sptrid;
        this.extrgamedate = extrgamedate;
        this.scheduleflag = scheduleflag;
    }

    public String getScheduleflag() {
        return scheduleflag;
    }

    public void setScheduleflag(String scheduleflag) {
        this.scheduleflag = scheduleflag;
    }

    public int getSptrid() {
        return sptrid;
    }

    public void setSptrid(int sptrid) {
        this.sptrid = sptrid;
    }

    public int getShooting() {
        return shooting;
    }

    public void setShooting(int shooting) {
        this.shooting = shooting;
    }

    public int getSetplay() {
        return setplay;
    }

    public void setSetplay(int setplay) {
        this.setplay = setplay;
    }

    public String getYoutubesource() {
        return youtubesource;
    }

    public void setYoutubesource(String youtubesource) {
        this.youtubesource = youtubesource;
    }

    public int getExgameid() {
        return exgameid;
    }

    public void setExgameid(int exgameid) {
        this.exgameid = exgameid;
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

    public String getOppoteam() {
        return oppoteam;
    }

    public void setOppoteam(String oppoteam) {
        this.oppoteam = oppoteam;
    }

    public Date getExgamedate() {
        return exgamedate;
    }

    public void setExgamedate(Date exgamedate) {
        this.exgamedate = exgamedate;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getWeather() {
        return weather;
    }

    public void setWeather(String weather) {
        this.weather = weather;
    }

    public int getFw() {
        return fw;
    }

    public void setFw(int fw) {
        this.fw = fw;
    }

    public int getMf() {
        return mf;
    }

    public void setMf(int mf) {
        this.mf = mf;
    }

    public int getDf() {
        return df;
    }

    public void setDf(int df) {
        this.df = df;
    }

    public int getOrg() {
        return org;
    }

    public void setOrg(int org) {
        this.org = org;
    }

    public int getPassing() {
        return passing;
    }

    public void setPassing(int passing) {
        this.passing = passing;
    }

    public int getFig() {
        return fig;
    }

    public void setFig(int fig) {
        this.fig = fig;
    }

    public int getFhwrecord() {
        return fhwrecord;
    }

    public void setFhwrecord(int fhwrecord) {
        this.fhwrecord = fhwrecord;
    }

    public int getFhorecord() {
        return fhorecord;
    }

    public void setFhorecord(int fhorecord) {
        this.fhorecord = fhorecord;
    }

    public int getShwrecord() {
        return shwrecord;
    }

    public void setShwrecord(int shwrecord) {
        this.shwrecord = shwrecord;
    }

    public int getShorecord() {
        return shorecord;
    }

    public void setShorecord(int shorecord) {
        this.shorecord = shorecord;
    }

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }

    public String getFormation() {
        return formation;
    }

    public void setFormation(String formation) {
        this.formation = formation;
    }

    public String getObjectpoint() {
        return objectpoint;
    }

    public void setObjectpoint(String objectpoint) {
        this.objectpoint = objectpoint;
    }

    public String getFw_description() {
        return fw_description;
    }

    public void setFw_description(String fw_description) {
        this.fw_description = fw_description;
    }

    public String getMf_description() {
        return mf_description;
    }

    public void setMf_description(String mf_description) {
        this.mf_description = mf_description;
    }

    public String getDf_description() {
        return df_description;
    }

    public void setDf_description(String df_description) {
        this.df_description = df_description;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}

