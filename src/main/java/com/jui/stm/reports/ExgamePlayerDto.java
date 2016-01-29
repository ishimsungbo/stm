package com.jui.stm.reports;

/**
 * Created by sungbo on 2016-01-08.
 */
public class ExgamePlayerDto {

    private int creativity;
    private int tactics;
    private int strength;
    private int offensive;
    private int defensive;
    private int pass;
    private int controll;

    public ExgamePlayerDto(){}

    public ExgamePlayerDto(int creativity, int tactics, int strength, int offensive, int defensive, int pass, int controll) {
        this.creativity = creativity;
        this.tactics = tactics;
        this.strength = strength;
        this.offensive = offensive;
        this.defensive = defensive;
        this.pass = pass;
        this.controll = controll;
    }

    public int getCreativity() {
        return creativity;
    }

    public void setCreativity(int creativity) {
        this.creativity = creativity;
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
}
