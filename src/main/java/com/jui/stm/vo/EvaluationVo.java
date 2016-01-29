package com.jui.stm.vo;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by Administrator on 2015-09-15.
 */
public class EvaluationVo {

    private int evaluationid;
    private int teamid;
    private Date date;
    private String subject;
    private String location;
    private String weather;
    private int playercount;
    private String description;
    private String performer;
    private String evalrason;
    private String exclass;
    private String exclassdisp;

    private String exdate;


    public EvaluationVo(int evaluationid, int teamid, Date date, String subject, String location, String weather, int playercount, String description, String performer, String evalrason, String exclass, String exdate) {
        this.evaluationid = evaluationid;
        this.teamid = teamid;
        this.date = date;
        this.subject = subject;
        this.location = location;
        this.weather = weather;
        this.playercount = playercount;
        this.description = description;
        this.performer = performer;
        this.evalrason = evalrason;
        this.exclass = exclass;
        this.exdate = exdate;
    }

    public String getExclassdisp() {


        if(exclass.equals("A")){
            exclassdisp="Class A";
        }else if(exclass.equals("B")){
            exclassdisp="Class B";
        }else if(exclass.equals("C")) {
            exclassdisp = "Class C";
        }else if(exclass.equals("D")) {
            exclassdisp="Class D";
        }else{
            exclassdisp="No Class";
        }
        return exclassdisp;
    }

    public void setExclassdisp(String exclassdisp) {
        this.exclassdisp = exclassdisp;
    }

    public String getExclass() {
        return exclass;
    }

    public void setExclass(String exclass) {
        this.exclass = exclass;
    }

    public String getExdate() {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        exdate = dateFormat.format(date);

        return exdate;
    }

    public void setExdate(String exdate) {
        this.exdate = exdate;
    }

    public String getPerformer() {
        return performer;
    }

    public void setPerformer(String performer) {
        this.performer = performer;
    }

    public EvaluationVo() {
    }

    public String getEvalrason() {
        return evalrason;
    }

    public void setEvalrason(String evalrason) {
        this.evalrason = evalrason;
    }

    public int getEvaluationid() {
        return evaluationid;
    }

    public void setEvaluationid(int evaluationid) {
        this.evaluationid = evaluationid;
    }

    public int getTeamid() {
        return teamid;
    }

    public void setTeamid(int teamid) {
        this.teamid = teamid;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
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

    public String getWeather() {
        return weather;
    }

    public void setWeather(String weather) {
        this.weather = weather;
    }

    public int getPlayercount() {
        return playercount;
    }

    public void setPlayercount(int playercount) {
        this.playercount = playercount;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
