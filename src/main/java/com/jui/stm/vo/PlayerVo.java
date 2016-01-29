package com.jui.stm.vo;

import org.springframework.web.multipart.MultipartFile;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by Administrator on 2015-09-05.
 */
public class PlayerVo {

    private int    teamid;
    private int    playerid;
    private String picture;
    private String playername;
    private String positioncategory;
    private String positioncode;
    private Date   joindate;
    private String status;
    private String description;
    private Date   withdrawdate;
    private Date   creationdate;
    private Date   lastupdatedate;
    private String exclass;
    private String exclass_disp;
    private String joinFormatdate;
    private int    backnumber;
    private MultipartFile file;
    private int exgamecount;
    private int gamecount;

    private String enddate;

    //조회전용
    private int coachingcount;
    protected int evcount;

    public PlayerVo(){}

    public PlayerVo(int teamid, int playerid, String picture, String playername, String positioncategory, String positioncode, Date joindate, String status, String description, Date withdrawdate, Date creationdate, Date lastupdatedate, String exclass, String exclass_disp, String joinFormatdate, int backnumber, MultipartFile file, String enddate, int coachingcount, int evcount) {
        this.teamid = teamid;
        this.playerid = playerid;
        this.picture = picture;
        this.playername = playername;
        this.positioncategory = positioncategory;
        this.positioncode = positioncode;
        this.joindate = joindate;
        this.status = status;
        this.description = description;
        this.withdrawdate = withdrawdate;
        this.creationdate = creationdate;
        this.lastupdatedate = lastupdatedate;
        this.exclass = exclass;
        this.exclass_disp = exclass_disp;
        this.joinFormatdate = joinFormatdate;
        this.backnumber = backnumber;
        this.file = file;
        this.enddate = enddate;
        this.coachingcount = coachingcount;
        this.evcount = evcount;
    }

    public int getExgamecount() {
        return exgamecount;
    }

    public void setExgamecount(int exgamecount) {
        this.exgamecount = exgamecount;
    }

    public int getGamecount() {
        return gamecount;
    }

    public void setGamecount(int gamecount) {
        this.gamecount = gamecount;
    }

    public MultipartFile getFile() {
        return file;
    }

    public void setFile(MultipartFile file) {
        this.file = file;
    }

    public int getEvcount() {
        return evcount;
    }

    public void setEvcount(int evcount) {
        this.evcount = evcount;
    }

    public String getJoinFormatdate() {

        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        joinFormatdate = dateFormat.format(joindate);

        return joinFormatdate;
    }

    public void setJoinFormatdate(String joinFormatdate) {
        this.joinFormatdate = joinFormatdate;
    }

    public String getEnddate() {
        if (withdrawdate==null) {
            return enddate;
        }
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        enddate = dateFormat.format(withdrawdate);
        return enddate;
    }

    public void setEnddate(String enddate) {
        this.enddate = enddate;
    }

    public int getBacknumber() {
        return backnumber;
    }

    public void setBacknumber(int backnumber) {
        this.backnumber = backnumber;
    }

    public int getCoachingcount() {
        return coachingcount;
    }

    public void setCoachingcount(int coachingcount) {
        this.coachingcount = coachingcount;
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

    public String getPicture() {
        return picture;
    }

    public void setPicture(String picture) {
        this.picture = picture;
    }

    public String getPlayername() {
        return playername;
    }

    public void setPlayername(String playername) {
        this.playername = playername;
    }

    public String getPositioncategory() {
        return positioncategory;
    }

    public void setPositioncategory(String positioncategory) {
        this.positioncategory = positioncategory;
    }

    public String getPositioncode() {
        return positioncode;
    }

    public void setPositioncode(String positioncode) {
        this.positioncode = positioncode;
    }

    public Date getJoindate() {
        return joindate;
    }

    public void setJoindate(Date joindate) {
        this.joindate = joindate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getWithdrawdate() {
        return withdrawdate;
    }

    public void setWithdrawdate(Date withdrawdate) {
        this.withdrawdate = withdrawdate;
    }

    public Date getCreationdate() {
        return creationdate;
    }

    public void setCreationdate(Date creationdate) {
        this.creationdate = creationdate;
    }

    public Date getLastupdatedate() {
        return lastupdatedate;
    }

    public void setLastupdatedate(Date lastupdatedate) {
        this.lastupdatedate = lastupdatedate;
    }

    public String getExclass() {
        return exclass;
    }

    public void setExclass(String exclass) {
        this.exclass = exclass;
    }

    public String getExclass_disp() {
        return exclass_disp;
    }

    public void setExclass_disp(String exclass_disp) {
        this.exclass_disp = exclass_disp;
    }



}
