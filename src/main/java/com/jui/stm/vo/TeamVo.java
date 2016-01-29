package com.jui.stm.vo;

import java.util.Date;

/**
 * Created by DIT213103 on 2015-09-03.
 */
public class TeamVo {
    private int teamid;
    private String name;
    private String addr;
    private String phone;
    private String type;
    private Date foundationDate;
    private String teamtype;
    private String emblem;
    private String description;
    private Date creationdate;
    private Date lastupdatedate;
    private int userkey;

    public TeamVo() {
    }

    public TeamVo(int teamid, String name, String addr, String phone, String type, Date foundationDate, String teamtype, String emblem, String description, Date creationdate, Date lastupdatedate, int userkey) {
        this.teamid = teamid;
        this.name = name;
        this.addr = addr;
        this.phone = phone;
        this.type = type;
        this.foundationDate = foundationDate;
        this.teamtype = teamtype;
        this.emblem = emblem;
        this.description = description;
        this.creationdate = creationdate;
        this.lastupdatedate = lastupdatedate;
        this.userkey = userkey;
    }

    public int getTeamid() {
        return teamid;
    }

    public void setTeamid(int teamid) {
        this.teamid = teamid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddr() {
        return addr;
    }

    public void setAddr(String addr) {
        this.addr = addr;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public Date getFoundationDate() {
        return foundationDate;
    }

    public void setFoundationDate(Date foundationDate) {
        this.foundationDate = foundationDate;
    }

    public String getTeamtype() {
        return teamtype;
    }

    public void setTeamtype(String teamtype) {
        this.teamtype = teamtype;
    }

    public String getEmblem() {
        return emblem;
    }

    public void setEmblem(String emblem) {
        this.emblem = emblem;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
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

    public int getUserkey() {
        return userkey;
    }

    public void setUserkey(int userkey) {
        this.userkey = userkey;
    }
}
