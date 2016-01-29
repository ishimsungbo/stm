package com.jui.stm.vo;

/**
 * Created by sungbo on 2015-12-28.
 * 선수들의 경기 자료
 */
public class PlayerGameVo {

    private int playergameid;
    private int playerid;
    private int teamid;
    private String positioncode;
    private int backnumber;

    private int exgameid;
    private int gameid;
    private int intime;

    //경기평가 점수
    private int tactics;
    private int strength;
    private int offensive;
    private int defensive;
    private int pass;
    private int controll;
    private int creativity; //창의성

    private String good;
    private String problem;
    private String review;

    private String playername;
    private int goal;
    private int asist;

    public PlayerGameVo(){}

    public PlayerGameVo(int playergameid, int playerid, int teamid, String positioncode, int backnumber, int exgameid, int gameid, int intime, int tactics, int strength, int offensive, int defensive, int pass, int controll, int creativity, String good, String problem, String review, String playername, int goal, int asist) {
        this.playergameid = playergameid;
        this.playerid = playerid;
        this.teamid = teamid;
        this.positioncode = positioncode;
        this.backnumber = backnumber;
        this.exgameid = exgameid;
        this.gameid = gameid;
        this.intime = intime;
        this.tactics = tactics;
        this.strength = strength;
        this.offensive = offensive;
        this.defensive = defensive;
        this.pass = pass;
        this.controll = controll;
        this.creativity = creativity;
        this.good = good;
        this.problem = problem;
        this.review = review;
        this.playername = playername;
        this.goal = goal;
        this.asist = asist;
    }

    public int getCreativity() {
        return creativity;
    }

    public void setCreativity(int creativity) {
        this.creativity = creativity;
    }

    public int getGoal() {
        return goal;
    }

    public void setGoal(int goal) {
        this.goal = goal;
    }

    public int getAsist() {
        return asist;
    }

    public void setAsist(int asist) {
        this.asist = asist;
    }

    public String getPlayername() {
        return playername;
    }

    public void setPlayername(String playername) {
        this.playername = playername;
    }

    public String getPositioncode() {
        return positioncode;
    }

    public void setPositioncode(String positioncode) {
        this.positioncode = positioncode;
    }

    public int getBacknumber() {
        return backnumber;
    }

    public void setBacknumber(int backnumber) {
        this.backnumber = backnumber;
    }

    public int getPlayergameid() {
        return playergameid;
    }

    public void setPlayergameid(int playergameid) {
        this.playergameid = playergameid;
    }

    public int getPlayerid() {
        return playerid;
    }

    public void setPlayerid(int playerid) {
        this.playerid = playerid;
    }

    public int getTeamid() {
        return teamid;
    }

    public void setTeamid(int teamid) {
        this.teamid = teamid;
    }

    public int getExgameid() {
        return exgameid;
    }

    public void setExgameid(int exgameid) {
        this.exgameid = exgameid;
    }

    public int getGameid() {
        return gameid;
    }

    public void setGameid(int gameid) {
        this.gameid = gameid;
    }

    public int getIntime() {
        return intime;
    }

    public void setIntime(int intime) {
        this.intime = intime;
    }

    public int getTactics() {
        return tactics;
    }

    public void setTactics(int tactics) {
        this.tactics = tactics;
    }

    public int getStrength() {
        return strength;
    }

    public void setStrength(int strength) {
        this.strength = strength;
    }

    public int getOffensive() {
        return offensive;
    }

    public void setOffensive(int offensive) {
        this.offensive = offensive;
    }

    public int getDefensive() {
        return defensive;
    }

    public void setDefensive(int defensive) {
        this.defensive = defensive;
    }

    public int getPass() {
        return pass;
    }

    public void setPass(int pass) {
        this.pass = pass;
    }

    public int getControll() {
        return controll;
    }

    public void setControll(int controll) {
        this.controll = controll;
    }

    public String getGood() {
        return good;
    }

    public void setGood(String good) {
        this.good = good;
    }

    public String getProblem() {
        return problem;
    }

    public void setProblem(String problem) {
        this.problem = problem;
    }

    public String getReview() {
        return review;
    }

    public void setReview(String review) {
        this.review = review;
    }
}
