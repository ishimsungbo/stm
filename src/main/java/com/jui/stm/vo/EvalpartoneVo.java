package com.jui.stm.vo;

/**
 * Created by sungbo on 2015-10-23.
 */
public class EvalpartoneVo {

    private int pass;
    private int shooting;
    private int kick;
    private int dribble;
    private int game;
    private int tactics;
    private int leadings;
    private int creativity;
    private int controll;

    public EvalpartoneVo() {
    }

    public EvalpartoneVo(int pass, int shooting, int kick, int dribble, int game, int tactics, int leadings, int creativity, int controll) {
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
}
