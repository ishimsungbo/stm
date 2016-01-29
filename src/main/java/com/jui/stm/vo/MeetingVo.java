package com.jui.stm.vo;

import java.util.Date;

/**
 * Created by sungbo on 2015-12-25.
 * 회의
 */
public class MeetingVo {

    private int meetingid;
    private int teamid;
    private String subject;
    private Date fromdate;
    private Date todate;
    private String meetingtype;
    private String participant;
    private String content;
    private String scheduleflag;
    private String description;
    private int personcount;

    public MeetingVo(){}

    public MeetingVo(int meetingid, int teamid, String subject, Date fromdate, Date todate, String meetingtype, String participant, String content, String scheduleflag, String description, int personcount) {
        this.meetingid = meetingid;
        this.teamid = teamid;
        this.subject = subject;
        this.fromdate = fromdate;
        this.todate = todate;
        this.meetingtype = meetingtype;
        this.participant = participant;
        this.content = content;
        this.scheduleflag = scheduleflag;
        this.description = description;
        this.personcount = personcount;
    }

    public int getPersoncount() {
        return personcount;
    }

    public void setPersoncount(int personcount) {
        this.personcount = personcount;
    }

    public int getMeetingid() {
        return meetingid;
    }

    public void setMeetingid(int meetingid) {
        this.meetingid = meetingid;
    }

    public int getTeamid() {
        return teamid;
    }

    public void setTeamid(int teamid) {
        this.teamid = teamid;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public Date getFromdate() {
        return fromdate;
    }

    public void setFromdate(Date fromdate) {
        this.fromdate = fromdate;
    }

    public Date getTodate() {
        return todate;
    }

    public void setTodate(Date todate) {
        this.todate = todate;
    }

    public String getMeetingtype() {
        return meetingtype;
    }

    public void setMeetingtype(String meetingtype) {
        this.meetingtype = meetingtype;
    }

    public String getParticipant() {
        return participant;
    }

    public void setParticipant(String participant) {
        this.participant = participant;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getScheduleflag() {
        return scheduleflag;
    }

    public void setScheduleflag(String scheduleflag) {
        this.scheduleflag = scheduleflag;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}




