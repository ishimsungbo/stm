package com.jui.stm.vo;

import java.util.Date;

/**
 * Created by sungbo on 2015-10-19.
 */
public class EvalrecordVo {

    private int teamid;
    private String playername;
    private int playerid;
    private String subject;
    private Date date;

    private int pass;
    private int shooting;
    private int kick;
    private int dribble;
    private double twohundred;
    private double hundred;
    private double fifty;
    private String exdate;
    private int game;
    private int tactics;
    private int leadings;

    public EvalrecordVo(){}

    public EvalrecordVo(int teamid, String playername, int playerid, String subject, Date date, int pass, int shooting, int kick, int dribble, double twohundred, double hundred, double fifty, String exdate, int game, int tactics, int leadings) {
        this.teamid = teamid;
        this.playername = playername;
        this.playerid = playerid;
        this.subject = subject;
        this.date = date;
        this.pass = pass;
        this.shooting = shooting;
        this.kick = kick;
        this.dribble = dribble;
        this.twohundred = twohundred;
        this.hundred = hundred;
        this.fifty = fifty;
        this.exdate = exdate;
        this.game = game;
        this.tactics = tactics;
        this.leadings = leadings;
    }

    public int getGame() {
        return game;
    }

    public void setGame(int game) {
        this.game = game;
    }

    public int getTactics() {
        return tactics;
    }

    public void setTactics(int tactics) {
        this.tactics = tactics;
    }

    public int getLeadings() {
        return leadings;
    }

    public void setLeadings(int leadings) {
        this.leadings = leadings;
    }

    public int getTeamid() {
        return teamid;
    }

    public void setTeamid(int teamid) {
        this.teamid = teamid;
    }

    public String getPlayername() {
        return playername;
    }

    public void setPlayername(String playername) {
        this.playername = playername;
    }

    public int getPlayerid() {
        return playerid;
    }

    public void setPlayerid(int playerid) {
        this.playerid = playerid;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public int getPass() {
        return pass;
    }

    public void setPass(int pass) {
        this.pass = pass;
    }

    public int getShooting() {
        return shooting;
    }

    public void setShooting(int shooting) {
        this.shooting = shooting;
    }

    public int getKick() {
        return kick;
    }

    public void setKick(int kick) {
        this.kick = kick;
    }

    public int getDribble() {
        return dribble;
    }

    public void setDribble(int dribble) {
        this.dribble = dribble;
    }

    public double getTwohundred() {
        return twohundred;
    }

    public void setTwohundred(double twohundred) {
        this.twohundred = twohundred;
    }

    public double getHundred() {
        return hundred;
    }

    public void setHundred(double hundred) {
        this.hundred = hundred;
    }

    public double getFifty() {
        return fifty;
    }

    public void setFifty(double fifty) {
        this.fifty = fifty;
    }

    public String getExdate() {
        String indate = new java.text.SimpleDateFormat("yyyyMMdd").format(date);

        return indate;
    }

    public void setExdate(String exdate) {
        this.exdate = exdate;
    }
}
