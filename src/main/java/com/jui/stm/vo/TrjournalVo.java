package com.jui.stm.vo;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by sungbo on 2015-12-21.
 * 훈련일지 메인 View Object
 */
public class TrjournalVo {

    private int jeid;
    private Date jedatefrom;
    private Date jedateto;

    private String location;
    private String performer;
    private String exclass;
    private String concept;
    private String conceptobject;
    private String description;
    private int teamid;
    private Date trdate;

    private String  formattrdate;
    //훈련 실행 점수
    private int satisfaction;

    //view date
    private String fromdate;
    private String todate;
    private String good;
    private String insufficiency;
    private int playercount; //훈련참여선수 수
    private String weather;

    public int getPlayercount() {
        return playercount;
    }

    public void setPlayercount(int playercount) {
        this.playercount = playercount;
    }

    public String getFormattrdate() {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh: mm");
        formattrdate = dateFormat.format(trdate);
        return formattrdate;
    }

    public void setFormattrdate(String formattrdate) {
        this.formattrdate = formattrdate;
    }

    public String getFromdate() {              // yyyy년 MM월 dd일 hh시 mm분
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh: mm");
        fromdate = dateFormat.format(jedatefrom);
        return fromdate;
    }

    public String getTodate() {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh: mm");
        todate = dateFormat.format(jedateto);
        return todate;
    }

    public void setFromdate(String fromdate) {
        this.fromdate = fromdate;
    }

    public void setTodate(String todate) {
        this.todate = todate;
    }

    public Date getTrdate() {
        return trdate;
    }

    public void setTrdate(Date trdate) {
        this.trdate = trdate;
    }

    public TrjournalVo(){}

    public String getGood() {
        return good;
    }

    public void setGood(String good) {
        this.good = good;
    }

    public String getInsufficiency() {
        return insufficiency;
    }

    public void setInsufficiency(String insufficiency) {
        this.insufficiency = insufficiency;
    }

    public String getWeather() {
        return weather;
    }

    public void setWeather(String weather) {
        this.weather = weather;
    }

    public TrjournalVo(int jeid, Date jedatefrom, Date jedateto, String location, String performer, String exclass, String concept, String conceptobject, String description, int teamid, Date trdate, String formattrdate, int satisfaction, String fromdate, String todate, String good, String insufficiency, int playercount, String weather) {

        this.jeid = jeid;
        this.jedatefrom = jedatefrom;
        this.jedateto = jedateto;
        this.location = location;
        this.performer = performer;
        this.exclass = exclass;
        this.concept = concept;
        this.conceptobject = conceptobject;
        this.description = description;
        this.teamid = teamid;
        this.trdate = trdate;
        this.formattrdate = formattrdate;
        this.satisfaction = satisfaction;
        this.fromdate = fromdate;
        this.todate = todate;
        this.good = good;
        this.insufficiency = insufficiency;
        this.playercount = playercount;
        this.weather = weather;
    }

    public int getJeid() {
        return jeid;
    }

    public void setJeid(int jeid) {
        this.jeid = jeid;
    }

    public Date getJedatefrom() {
        return jedatefrom;
    }

    public void setJedatefrom(Date jedatefrom) {
        this.jedatefrom = jedatefrom;
    }

    public Date getJedateto() {
        return jedateto;
    }

    public void setJedateto(Date jedateto) {
        this.jedateto = jedateto;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getPerformer() {
        return performer;
    }

    public void setPerformer(String performer) {
        this.performer = performer;
    }

    public String getExclass() {
        return exclass;
    }

    public void setExclass(String exclass) {
        this.exclass = exclass;
    }

    public String getConcept() {
        return concept;
    }

    public void setConcept(String concept) {
        this.concept = concept;
    }

    public String getConceptobject() {
        return conceptobject;
    }

    public void setConceptobject(String conceptobject) {
        this.conceptobject = conceptobject;
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

    public int getSatisfaction() {
        return satisfaction;
    }

    public void setSatisfaction(int satisfaction) {
        this.satisfaction = satisfaction;
    }
}
