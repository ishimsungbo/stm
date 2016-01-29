package com.jui.stm.reports;

/**
 * Created by sungbo on 2016-01-07.
 * 연습경기 메인 페이지 리포팅을 위한 Dto
 */
public class ExgameDto {

    private int exgamecount;
    private int fw;
    private int mf;
    private int df;
    private int org;
    private int passing;
    private int fig;
    private int wgoal;
    private int ogoal;
    private int wincount;   //승리경기
    private int losscount;  //진경기
    private int nullcount;  //비긴수
    private int shooting;
    private int setplay;

    public ExgameDto(){}

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

    public ExgameDto(int exgamecount, int fw, int mf, int df, int org, int passing, int fig, int wgoal, int ogoal, int wincount, int losscount, int nullcount, int shooting, int setplay) {

        this.exgamecount = exgamecount;
        this.fw = fw;
        this.mf = mf;
        this.df = df;
        this.org = org;
        this.passing = passing;
        this.fig = fig;
        this.wgoal = wgoal;
        this.ogoal = ogoal;
        this.wincount = wincount;
        this.losscount = losscount;
        this.nullcount = nullcount;
        this.shooting = shooting;
        this.setplay = setplay;
    }

    public int getExgamecount() {
        return exgamecount;
    }

    public void setExgamecount(int exgamecount) {
        this.exgamecount = exgamecount;
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

    public int getWgoal() {
        return wgoal;
    }

    public void setWgoal(int wgoal) {
        this.wgoal = wgoal;
    }

    public int getOgoal() {
        return ogoal;
    }

    public void setOgoal(int ogoal) {
        this.ogoal = ogoal;
    }

    public int getWincount() {
        return wincount;
    }

    public void setWincount(int wincount) {
        this.wincount = wincount;
    }

    public int getLosscount() {
        return losscount;
    }

    public void setLosscount(int losscount) {
        this.losscount = losscount;
    }

    public int getNullcount() {
        return nullcount;
    }

    public void setNullcount(int nullcount) {
        this.nullcount = nullcount;
    }
}
