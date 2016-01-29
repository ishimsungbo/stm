package com.jui.stm.reports;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by sungbo on 2016-01-11.
 */
public class PlayerAvgDto {

    private Date date;
    private int pass;
    private int shooting;
    private int kick;
    private int dribble;
    private int game;
    private int tactics;
    private int leadings;
    private int creativity;
    private int controll;

    private String yyyymmdd;
    private String subject;

    private int teamid;
    private int playerid;

    private String fromdate;
    private String todate;

    public PlayerAvgDto(){}

    public PlayerAvgDto(Date date, int pass, int shooting, int kick, int dribble, int game, int tactics, int leadings, int creativity, int controll, String subject, int teamid, int playerid) {
        this.date = date;
        this.pass = pass;
        this.shooting = shooting;
        this.kick = kick;
        this.dribble = dribble;
        this.game = game;
        this.tactics = tactics;
        this.leadings = leadings;
        this.creativity = creativity;
        this.controll = controll;
        this.subject = subject;
        this.teamid = teamid;
        this.playerid = playerid;
    }

    public String getFromdate() {
        return fromdate;
    }

    public void setFromdate(String fromdate) {
        this.fromdate = fromdate;
    }

    public String getTodate() {
        return todate;
    }

    public void setTodate(String todate) {
        this.todate = todate;
    }

    public int getCreativity() {
        return creativity;
    }

    public void setCreativity(int creativity) {
        this.creativity = creativity;
    }

    public int getControll() {
        return controll;
    }

    public void setControll(int controll) {
        this.controll = controll;
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

    public String getYyyymmdd() {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        yyyymmdd = dateFormat.format(date);
        return yyyymmdd;
    }

    public void setYyyymmdd(String yyyymmdd) {
        this.yyyymmdd = yyyymmdd;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
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
}
