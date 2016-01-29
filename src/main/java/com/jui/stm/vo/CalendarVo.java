package com.jui.stm.vo;

/**
 * Created by sungbo on 2015-11-18.
 */
public class CalendarVo {

    private int calendarid;
    private String title;
    private String start;
    private String end;
    private int teamid;
    private String content;
    private String flag;
    private String color;

    public CalendarVo(){}

    public CalendarVo(int calendarid, String title, String start, String end, int teamid, String content, String flag, String color) {
        this.calendarid = calendarid;
        this.title = title;
        this.start = start;
        this.end = end;
        this.teamid = teamid;
        this.content = content;
        this.flag = flag;
        this.color = color;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getFlag() {
        return flag;
    }
    public void setFlag(String flag) {
        this.flag = flag;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getCalendarid() {
        return calendarid;
    }

    public void setCalendarid(int calendarid) {
        this.calendarid = calendarid;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getStart() {
        return start;
    }

    public void setStart(String start) {
        this.start = start;
    }

    public String getEnd() {
        return end;
    }

    public void setEnd(String end) {
        this.end = end;
    }

    public int getTeamid() {
        return teamid;
    }

    public void setTeamid(int teamid) {
        this.teamid = teamid;
    }
}
