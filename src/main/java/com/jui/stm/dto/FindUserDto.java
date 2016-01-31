package com.jui.stm.dto;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by sungbo on 2015-11-30.
 */
public class FindUserDto {

    private String userid;
    private String email;
    private String phone;
    private String password;
    private String snsprovider;
    private int    pageflag;
    private Date   creationdate;
    private String joindate;
    private String emailchecknum;
    private String pwdclone;



    public String getJoindate() {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        joindate = dateFormat.format(creationdate);
        return joindate;
    }

    public void setJoindate(String joindate) {
        this.joindate = joindate;
    }

    public FindUserDto(){}

    public FindUserDto(String userid, String email, String phone, String password, String snsprovider, int pageflag, Date creationdate, String emailchecknum, String pwdclone) {
        this.userid = userid;
        this.email = email;
        this.phone = phone;
        this.password = password;
        this.snsprovider = snsprovider;
        this.pageflag = pageflag;
        this.creationdate = creationdate;
        this.emailchecknum = emailchecknum;
        this.pwdclone = pwdclone;
    }

    public String getEmailchecknum() {
        return emailchecknum;
    }

    public void setEmailchecknum(String emailchecknum) {
        this.emailchecknum = emailchecknum;
    }

    public String getPwdclone() {
        return pwdclone;
    }

    public void setPwdclone(String pwdclone) {
        this.pwdclone = pwdclone;
    }

    public Date getCreationdate() {
        return creationdate;
    }

    public void setCreationdate(Date creationdate) {
        this.creationdate = creationdate;
    }

    public String getSnsprovider() {
        return snsprovider;
    }

    public void setSnsprovider(String snsprovider) {
        this.snsprovider = snsprovider;
    }

    public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getPageflag() {
        return pageflag;
    }

    public void setPageflag(int pageflag) {
        this.pageflag = pageflag;
    }
}
