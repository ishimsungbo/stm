package com.jui.stm.vo;

/**
 * Created by Administrator on 2015-09-15.
 */
public class EvaluationPlayerVo {

    private int evalpkid;
    private int evaluationid;
    private int playerid;
    private String attend;  //평가 참석...
    private int pass;     //패싱
    private int shooting; //슈팅
    private int kick;    //킥
    private int dribble; //드리블
    private int creativity; //창의성
    private int controll;  //볼컨트롤능력

    private String playername;

    private int game;
    private int tactics;
    private int leadings;
    private String detailecount;

    public EvaluationPlayerVo() {
    }

    public EvaluationPlayerVo(int evalpkid, int evaluationid, int playerid, String attend, int pass, int shooting, int kick, int dribble, int creativity, int controll, String playername, int game, int tactics, int leadings, String detailecount) {
        this.evalpkid = evalpkid;
        this.evaluationid = evaluationid;
        this.playerid = playerid;
        this.attend = attend;
        this.pass = pass;
        this.shooting = shooting;
        this.kick = kick;
        this.dribble = dribble;
        this.creativity = creativity;
        this.controll = controll;
        this.playername = playername;
        this.game = game;
        this.tactics = tactics;
        this.leadings = leadings;
        this.detailecount = detailecount;
    }

    public String getDetailecount() {
        return detailecount;
    }

    public void setDetailecount(String detailecount) {
        this.detailecount = detailecount;
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

    public int getLeadings() {
        return leadings;
    }

    public void setLeadings(int leadings) {
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



    public int getEvalpkid() {
        return evalpkid;
    }

    public void setEvalpkid(int evalpkid) {
        this.evalpkid = evalpkid;
    }

    public int getEvaluationid() {
        return evaluationid;
    }

    public void setEvaluationid(int evaluationid) {
        this.evaluationid = evaluationid;
    }

    public int getPlayerid() {
        return playerid;
    }

    public void setPlayerid(int playerid) {
        this.playerid = playerid;
    }

    public String getAttend() {
        return attend;
    }

    public void setAttend(String attend) {
        this.attend = attend;
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


    public String getPlayername() {
        return playername;
    }

    public void setPlayername(String playername) {
        this.playername = playername;
    }
}