package com.jui.stm.vo;

/**
 * Created by sungbo on 2016-01-03.
 */
public class PhysicalLineVo {

    private String playername;
    private int headerid;
    private int playerid;
    private double height;
    private double weight;
    private int bodyfat;
    private int footsize;
    private String bodysize;
    private String description;
    private double fifty;
    private double onehundred;
    private double twohundred;
    private double fourhundred;
    private double lineid;

    public PhysicalLineVo(){}

    public String getPlayername() {
        return playername;
    }

    public void setPlayername(String playername) {
        this.playername = playername;
    }

    public int getHeaderid() {
        return headerid;
    }

    public void setHeaderid(int headerid) {
        this.headerid = headerid;
    }

    public int getPlayerid() {
        return playerid;
    }

    public void setPlayerid(int playerid) {
        this.playerid = playerid;
    }

    public double getHeight() {
        return height;
    }

    public void setHeight(double height) {
        this.height = height;
    }

    public double getWeight() {
        return weight;
    }

    public void setWeight(double weight) {
        this.weight = weight;
    }

    public int getBodyfat() {
        return bodyfat;
    }

    public void setBodyfat(int bodyfat) {
        this.bodyfat = bodyfat;
    }

    public int getFootsize() {
        return footsize;
    }

    public void setFootsize(int footsize) {
        this.footsize = footsize;
    }

    public String getBodysize() {
        return bodysize;
    }

    public void setBodysize(String bodysize) {
        this.bodysize = bodysize;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getFifty() {
        return fifty;
    }

    public void setFifty(double fifty) {
        this.fifty = fifty;
    }

    public double getOnehundred() {
        return onehundred;
    }

    public void setOnehundred(double onehundred) {
        this.onehundred = onehundred;
    }

    public double getTwohundred() {
        return twohundred;
    }

    public void setTwohundred(double twohundred) {
        this.twohundred = twohundred;
    }

    public double getFourhundred() {
        return fourhundred;
    }

    public void setFourhundred(double fourhundred) {
        this.fourhundred = fourhundred;
    }

    public double getLineid() {
        return lineid;
    }

    public void setLineid(double lineid) {
        this.lineid = lineid;
    }

    public PhysicalLineVo(String playername, int headerid, int playerid, double height, double weight, int bodyfat, int footsize, String bodysize, String description, double fifty, double onehundred, double twohundred, double fourhundred, double lineid) {

        this.playername = playername;
        this.headerid = headerid;
        this.playerid = playerid;
        this.height = height;
        this.weight = weight;
        this.bodyfat = bodyfat;
        this.footsize = footsize;
        this.bodysize = bodysize;
        this.description = description;
        this.fifty = fifty;
        this.onehundred = onehundred;
        this.twohundred = twohundred;
        this.fourhundred = fourhundred;
        this.lineid = lineid;
    }
}
