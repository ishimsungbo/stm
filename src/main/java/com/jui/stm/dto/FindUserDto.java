package com.jui.stm.dto;

/**
 * Created by sungbo on 2015-11-30.
 */
public class FindUserDto {

    private String userid;
    private String email;
    private String phone;
    private String password;
    private int     pageflag;

    public FindUserDto(){}

    public FindUserDto(String userid, String email, String phone, String password, int pageflag) {
        this.userid = userid;
        this.email = email;
        this.phone = phone;
        this.password = password;
        this.pageflag = pageflag;
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
