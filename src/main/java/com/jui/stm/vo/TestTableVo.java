package com.jui.stm.vo;

/**
 * Created by sungbo on 2015-12-02.
 */
public class TestTableVo {
    private int id;
    private  String youtubesource;

    public TestTableVo(){

    }

    public TestTableVo(int id, String youtubesource) {
        this.id = id;
        this.youtubesource = youtubesource;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getYoutubesource() {
        return youtubesource;
    }

    public void setYoutubesource(String youtubesource) {
        this.youtubesource = youtubesource;
    }
}
