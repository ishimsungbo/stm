package com.jui.stm.android.vo;

/**
 * Created by Sungbo on 2016-03-22.
 */
public class User {
    private String userid;
    private String pwd;
    private String email;
    private String snstype;
    private String snsid;
    private String enable;
    private String regionid;

    public User() {
    }

    public User(String userid) {
        this.userid = userid;
    }

    public User(String userid, String pwd, String email) {
        this.userid = userid;
        this.pwd = pwd;
        this.email = email;
    }

    public User(String userid, String pwd, String email, String snstype, String snsid, String enable, String regionid) {
        this.userid = userid;
        this.pwd = pwd;
        this.email = email;
        this.snstype = snstype;
        this.snsid = snsid;
        this.enable = enable;
        this.regionid = regionid;
    }

    public String getUserid() {
        return userid;
    }
    public void setUserid(String userid) {
        this.userid = userid;
    }
    public String getPwd() {
        return pwd;
    }
    public void setPwd(String pwd) {
        this.pwd = pwd;
    }
    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }
    public String getSnstype() {
        return snstype;
    }
    public void setSnstype(String snstype) {
        this.snstype = snstype;
    }
    public String getSnsid() {
        return snsid;
    }
    public void setSnsid(String snsid) {
        this.snsid = snsid;
    }
    public String getEnable() {
        return enable;
    }
    public void setEnable(String enable) {
        this.enable = enable;
    }
    public String getRegionid() {
        return regionid;
    }
    public void setRegionid(String regionid) {
        this.regionid = regionid;
    }

    @Override
    public String toString() {
        return "User [userid=" + userid + ", pwd=" + pwd + ", email=" + email + ", snstype=" + snstype + ", snsid="
                + snsid + ", enable=" + enable + ", regionid=" + regionid + "]";
    }

}
