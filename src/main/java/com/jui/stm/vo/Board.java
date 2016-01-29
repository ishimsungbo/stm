package com.jui.stm.vo;

/**
 * Created by sungbo on 2015-10-30.
 */
public class Board {

    private int bid;
    private String content;
    private String writedate;

    public Board(){

    }

    public Board(int bid, String content, String writedate) {
        this.bid = bid;
        this.content = content;
        this.writedate = writedate;
    }

    public int getBid() {
        return bid;
    }

    public void setBid(int bid) {
        this.bid = bid;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getWritedate() {
        return writedate;
    }

    public void setWritedate(String writedate) {
        this.writedate = writedate;
    }
}
