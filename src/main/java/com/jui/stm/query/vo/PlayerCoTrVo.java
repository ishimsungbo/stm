package com.jui.stm.query.vo;

/**
 * Created by Administrator on 2016-01-27.
 */
public class PlayerCoTrVo {

    private int coachingcount;
    private int game;
    private int exgame;
    private int ex;
    private int learnscore;
    private int trcount;
    private int satipoint;
    private int injucount;

    public PlayerCoTrVo(){};

    public PlayerCoTrVo(int coachingcount, int game, int exgame, int ex, int learnscore, int trcount, int satipoint, int injucount) {
        this.coachingcount = coachingcount;
        this.game = game;
        this.exgame = exgame;
        this.ex = ex;
        this.learnscore = learnscore;
        this.trcount = trcount;
        this.satipoint = satipoint;
        this.injucount = injucount;
    }

    public int getCoachingcount() {
        return coachingcount;
    }

    public void setCoachingcount(int coachingcount) {
        this.coachingcount = coachingcount;
    }

    public int getGame() {
        return game;
    }

    public void setGame(int game) {
        this.game = game;
    }

    public int getExgame() {
        return exgame;
    }

    public void setExgame(int exgame) {
        this.exgame = exgame;
    }

    public int getEx() {
        return ex;
    }

    public void setEx(int ex) {
        this.ex = ex;
    }

    public int getLearnscore() {
        return learnscore;
    }

    public void setLearnscore(int learnscore) {
        this.learnscore = learnscore;
    }

    public int getTrcount() {
        return trcount;
    }

    public void setTrcount(int trcount) {
        this.trcount = trcount;
    }

    public int getSatipoint() {
        return satipoint;
    }

    public void setSatipoint(int satipoint) {
        this.satipoint = satipoint;
    }

    public int getInjucount() {
        return injucount;
    }

    public void setInjucount(int injucount) {
        this.injucount = injucount;
    }
}
