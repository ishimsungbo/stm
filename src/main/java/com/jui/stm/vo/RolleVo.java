package com.jui.stm.vo;

import java.util.Date;

/**
 * Created by sungbo on 2015-10-12.
 */
public class RolleVo {

    private int roll_id;
    private String roll_name;
    private  int userkey;
    private  String enabled;
    private Date creationdate;
    private Date lastupdatedate;

    public RolleVo() {
    }

    public RolleVo(int roll_id, String roll_name, int userkey, String enabled, Date creationdate, Date lastupdatedate) {
        this.roll_id = roll_id;
        this.roll_name = roll_name;
        this.userkey = userkey;
        this.enabled = enabled;
        this.creationdate = creationdate;
        this.lastupdatedate = lastupdatedate;
    }

    public int getRoll_id() {
        return roll_id;
    }

    public void setRoll_id(int roll_id) {
        this.roll_id = roll_id;
    }

    public String getRoll_name() {
        return roll_name;
    }

    public void setRoll_name(String roll_name) {
        this.roll_name = roll_name;
    }

    public int getUserkey() {
        return userkey;
    }

    public void setUserkey(int userkey) {
        this.userkey = userkey;
    }

    public String getEnabled() {
        return enabled;
    }

    public void setEnabled(String enabled) {
        this.enabled = enabled;
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
}
