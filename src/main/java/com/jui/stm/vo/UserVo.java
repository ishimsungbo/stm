package com.jui.stm.vo;

import org.hibernate.validator.constraints.NotEmpty;

/**
 * Created by Administrator on 2015-10-01.
 */
public class UserVo {

    private int userkey;

    @NotEmpty(message="아이디는 필수입력 항목입니다")
    private String userid;

    @NotEmpty(message="비밀번호는 필수입력 항목입니다")
    private String password;

    @NotEmpty(message="비밀번호는 필수입력 항목입니다")
    private String email;

    private String phone;

    private String enabled;

    private String snsflag;

    private String snsname;

    private String snsprovider;

    public UserVo(){}

    public UserVo(int userkey, String userid, String password, String email, String phone, String enabled, String snsflag, String snsname, String snsprovider) {
        this.userkey = userkey;
        this.userid = userid;
        this.password = password;
        this.email = email;
        this.phone = phone;
        this.enabled = enabled;
        this.snsflag = snsflag;
        this.snsname = snsname;
        this.snsprovider = snsprovider;
    }

    public String getSnsprovider() {
        return snsprovider;
    }

    public void setSnsprovider(String snsprovider) {
        this.snsprovider = snsprovider;
    }


    public String getSnsname() {
        return snsname;
    }

    public void setSnsname(String snsname) {
        this.snsname = snsname;
    }

    public String getSnsflag() {
        return snsflag;
    }

    public void setSnsflag(String snsflag) {
        this.snsflag = snsflag;
    }

    public int getUserkey() {
        return userkey;
    }

    public void setUserkey(int userkey) {
        this.userkey = userkey;
    }

    public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
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

    public String getEnabled() {
        return enabled;
    }

    public void setEnabled(String enabled) {
        this.enabled = enabled;
    }
}
