package com.jui.stm.vo;

/**
 * Created by Administrator on 2016-01-26.
 */
public class EvalDetailVo {

    private int detailid;
    private int evaluationid;
    private int teamid;
    private int playerid;
    private String pass;
    private String shooting;
    private String kick;
    private String dribble;
    private String game;
    private String tactics;
    private String leadings;
    private String creativity;
    private String controll;

    public EvalDetailVo() {}

    public EvalDetailVo(int detailid, int evaluationid, int teamid, int playerid, String pass, String shooting, String kick, String dribble, String game, String tactics, String leadings, String creativity, String controll) {
        this.detailid = detailid;
        this.evaluationid = evaluationid;
        this.teamid = teamid;
        this.playerid = playerid;
        this.pass = pass;
        this.shooting = shooting;
        this.kick = kick;
        this.dribble = dribble;
        this.game = game;
        this.tactics = tactics;
        this.leadings = leadings;
        this.creativity = creativity;
        this.controll = controll;
    }

    public int getDetailid() {
        return detailid;
    }

    public void setDetailid(int detailid) {
        this.detailid = detailid;
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

    public int getPlayerid() {
        return playerid;
    }

    public void setPlayerid(int playerid) {
        this.playerid = playerid;
    }

    public String getPass() {
        return pass;
    }

    public void setPass(String pass) {
        this.pass = pass;
    }

    public String getShooting() {
        return shooting;
    }

    public void setShooting(String shooting) {
        this.shooting = shooting;
    }

    public String getKick() {
        return kick;
    }

    public void setKick(String kick) {
        this.kick = kick;
    }

    public String getDribble() {
        return dribble;
    }

    public void setDribble(String dribble) {
        this.dribble = dribble;
    }

    public String getGame() {
        return game;
    }

    public void setGame(String game) {
        this.game = game;
    }

    public String getTactics() {
        return tactics;
    }

    public void setTactics(String tactics) {
        this.tactics = tactics;
    }

    public String getLeadings() {
        return leadings;
    }

    public void setLeadings(String leadings) {
        this.leadings = leadings;
    }

    public String getCreativity() {
        return creativity;
    }

    public void setCreativity(String creativity) {
        this.creativity = creativity;
    }

    public String getControll() {
        return controll;
    }

    public void setControll(String controll) {
        this.controll = controll;
    }
}
