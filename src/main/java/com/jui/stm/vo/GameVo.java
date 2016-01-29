package com.jui.stm.vo;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by Administrator on 2016-01-15.
 */
public class GameVo {

    private int gameid;
    private int teamid;
    private String scheduleflag;
    private int matchid;      //대회아이디
    private String exclass;  //선수레벨
    private String oppoteam; //상태팀
    private Date gamedate;
    private String location;
    private String weather;
    private int fw;
    private int mf;
    private int df;
    private int org;
    private int fig;
    private int setplay;
    private int fhwrecord;
    private int fhorecord;
    private int shwrecord;
    private int shorecord;
    private String result;
    private String formation;
    private String description;
    private String fw_description;
    private String mf_description;
    private String df_description;
    private String youtubesource;
    private String matchname;

    private String exclassdisp;
    private String egamedate;
    private int playercount;

    public int getPlayercount() {
        return playercount;
    }

    public void setPlayercount(int playercount) {
        this.playercount = playercount;
    }

    public String getMatchname() {
        return matchname;
    }

    public void setMatchname(String matchname) {
        this.matchname = matchname;
    }

    public GameVo() {
    }

    public GameVo(int gameid, int teamid, String scheduleflag, int matchid, String exclass, String oppoteam, Date gamedate, String location, String weather, int fw, int mf, int df, int org, int fig, int setplay, int fhwrecord, int fhorecord, int shwrecord, int shorecord, String result, String formation, String description, String fw_description, String mf_description, String df_description, String youtubesource, String exclassdisp, String egamedate) {
        this.gameid = gameid;
        this.teamid = teamid;
        this.scheduleflag = scheduleflag;
        this.matchid = matchid;
        this.exclass = exclass;
        this.oppoteam = oppoteam;
        this.gamedate = gamedate;
        this.location = location;
        this.weather = weather;
        this.fw = fw;
        this.mf = mf;
        this.df = df;
        this.org = org;
        this.fig = fig;
        this.setplay = setplay;
        this.fhwrecord = fhwrecord;
        this.fhorecord = fhorecord;
        this.shwrecord = shwrecord;
        this.shorecord = shorecord;
        this.result = result;
        this.formation = formation;
        this.description = description;
        this.fw_description = fw_description;
        this.mf_description = mf_description;
        this.df_description = df_description;
        this.youtubesource = youtubesource;
        this.exclassdisp = exclassdisp;
        this.egamedate = egamedate;
    }

    public int getGameid() {
        return gameid;
    }

    public void setGameid(int gameid) {
        this.gameid = gameid;
    }

    public int getTeamid() {
        return teamid;
    }

    public void setTeamid(int teamid) {
        this.teamid = teamid;
    }

    public String getScheduleflag() {
        return scheduleflag;
    }

    public void setScheduleflag(String scheduleflag) {
        this.scheduleflag = scheduleflag;
    }

    public int getMatchid() {
        return matchid;
    }

    public void setMatchid(int matchid) {
        this.matchid = matchid;
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

    public Date getGamedate() {
        return gamedate;
    }

    public void setGamedate(Date gamedate) {
        this.gamedate = gamedate;
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

    public int getFig() {
        return fig;
    }

    public void setFig(int fig) {
        this.fig = fig;
    }

    public int getSetplay() {
        return setplay;
    }

    public void setSetplay(int setplay) {
        this.setplay = setplay;
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
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

    public String getYoutubesource() {
        return youtubesource;
    }

    public void setYoutubesource(String youtubesource) {
        this.youtubesource = youtubesource;
    }

    public String getExclassdisp() {
        return exclassdisp;
    }

    public void setExclassdisp(String exclassdisp) {
        this.exclassdisp = exclassdisp;
    }

    public String getEgamedate() {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        egamedate = dateFormat.format(gamedate);
        return egamedate;
    }

    public void setEgamedate(String egamedate) {
        this.egamedate = egamedate;
    }

    @Override
    public String toString() {
        return "GameVo{" +
                "gameid=" + gameid +
                ", teamid=" + teamid +
                ", scheduleflag='" + scheduleflag + '\'' +
                ", matchid=" + matchid +
                ", exclass='" + exclass + '\'' +
                ", oppoteam='" + oppoteam + '\'' +
                ", gamedate=" + gamedate +
                ", location='" + location + '\'' +
                ", weather='" + weather + '\'' +
                ", fw=" + fw +
                ", mf=" + mf +
                ", df=" + df +
                ", org=" + org +
                ", fig=" + fig +
                ", setplay=" + setplay +
                ", fhwrecord=" + fhwrecord +
                ", fhorecord=" + fhorecord +
                ", shwrecord=" + shwrecord +
                ", shorecord=" + shorecord +
                ", result='" + result + '\'' +
                ", formation='" + formation + '\'' +
                ", description='" + description + '\'' +
                ", fw_description='" + fw_description + '\'' +
                ", mf_description='" + mf_description + '\'' +
                ", df_description='" + df_description + '\'' +
                ", youtubesource='" + youtubesource + '\'' +
                ", exclassdisp='" + exclassdisp + '\'' +
                ", egamedate='" + egamedate + '\'' +
                '}';
    }
}