package com.jui.stm.vo;

import java.util.Date;

/**
 * Created by sungbo on 2015-12-18.
 */
public class TrProgramVo {

    private int trainingid;  //훈련아이디
    private int teamid;
    private String  trname;
    private String  trtype;
    private int fieldermen;
    private int keepermen;
    private int spacex;
    private int spacey;
    private int spaceunit;
    private String exclass;

    private String trobject;
    private String attacktactics;
    private String defencetactics;
    private String attackskill;
    private String defenceskill;
    private String trattackobject;
    private String defenceobject;
    private String description;

    private int trruletime;
    private int breaktime;
    private int excuteset;

    private String youtubesource;
    private String injurypotential;
    private String importance;
    private String strength;

    private Date creationdate;
    private Date lastupdatedate;
    private String usegraund;
    private int trcount;

    public TrProgramVo(){}

    public int getTrcount() {
        return trcount;
    }

    public void setTrcount(int trcount) {
        this.trcount = trcount;
    }

    public TrProgramVo(int trainingid, int teamid, String trname, String trtype, int fieldermen, int keepermen, int spacex, int spacey, int spaceunit, String exclass, String trobject, String attacktactics, String defencetactics, String attackskill, String defenceskill, String trattackobject, String defenceobject, String description, int trruletime, int breaktime, int excuteset, String youtubesource, String injurypotential, String importance, String strength, Date creationdate, Date lastupdatedate, String usegraund, int trcount) {

        this.trainingid = trainingid;
        this.teamid = teamid;
        this.trname = trname;
        this.trtype = trtype;
        this.fieldermen = fieldermen;
        this.keepermen = keepermen;
        this.spacex = spacex;
        this.spacey = spacey;
        this.spaceunit = spaceunit;
        this.exclass = exclass;
        this.trobject = trobject;
        this.attacktactics = attacktactics;
        this.defencetactics = defencetactics;
        this.attackskill = attackskill;
        this.defenceskill = defenceskill;
        this.trattackobject = trattackobject;
        this.defenceobject = defenceobject;
        this.description = description;
        this.trruletime = trruletime;
        this.breaktime = breaktime;
        this.excuteset = excuteset;
        this.youtubesource = youtubesource;
        this.injurypotential = injurypotential;
        this.importance = importance;
        this.strength = strength;
        this.creationdate = creationdate;
        this.lastupdatedate = lastupdatedate;
        this.usegraund = usegraund;
        this.trcount = trcount;
    }

    public int getTeamid() {
        return teamid;
    }

    public void setTeamid(int teamid) {
        this.teamid = teamid;
    }

    public String getUsegraund() {
        return usegraund;
    }

    public void setUsegraund(String usegraund) {
        this.usegraund = usegraund;
    }

    public int getTrainingid() {
        return trainingid;
    }

    public void setTrainingid(int trainingid) {
        this.trainingid = trainingid;
    }

    public String getTrname() {
        return trname;
    }

    public void setTrname(String trname) {
        this.trname = trname;
    }

    public String getTrtype() {
        return trtype;
    }

    public void setTrtype(String trtype) {
        this.trtype = trtype;
    }

    public int getFieldermen() {
        return fieldermen;
    }

    public void setFieldermen(int fieldermen) {
        this.fieldermen = fieldermen;
    }

    public int getKeepermen() {
        return keepermen;
    }

    public void setKeepermen(int keepermen) {
        this.keepermen = keepermen;
    }

    public int getSpacex() {
        return spacex;
    }

    public void setSpacex(int spacex) {
        this.spacex = spacex;
    }

    public int getSpacey() {
        return spacey;
    }

    public void setSpacey(int spacey) {
        this.spacey = spacey;
    }

    public int getSpaceunit() {
        return spaceunit;
    }

    public void setSpaceunit(int spaceunit) {
        this.spaceunit = spaceunit;
    }

    public String getExclass() {
        return exclass;
    }

    public void setExclass(String exclass) {
        this.exclass = exclass;
    }

    public String getTrobject() {
        return trobject;
    }

    public void setTrobject(String trobject) {
        this.trobject = trobject;
    }

    public String getAttacktactics() {
        return attacktactics;
    }

    public void setAttacktactics(String attacktactics) {
        this.attacktactics = attacktactics;
    }

    public String getDefencetactics() {
        return defencetactics;
    }

    public void setDefencetactics(String defencetactics) {
        this.defencetactics = defencetactics;
    }

    public String getAttackskill() {
        return attackskill;
    }

    public void setAttackskill(String attackskill) {
        this.attackskill = attackskill;
    }

    public String getDefenceskill() {
        return defenceskill;
    }

    public void setDefenceskill(String defenceskill) {
        this.defenceskill = defenceskill;
    }

    public String getTrattackobject() {
        return trattackobject;
    }

    public void setTrattackobject(String trattackobject) {
        this.trattackobject = trattackobject;
    }

    public String getDefenceobject() {
        return defenceobject;
    }

    public void setDefenceobject(String defenceobject) {
        this.defenceobject = defenceobject;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getTrruletime() {
        return trruletime;
    }

    public void setTrruletime(int trruletime) {
        this.trruletime = trruletime;
    }

    public int getBreaktime() {
        return breaktime;
    }

    public void setBreaktime(int breaktime) {
        this.breaktime = breaktime;
    }

    public int getExcuteset() {
        return excuteset;
    }

    public void setExcuteset(int excuteset) {
        this.excuteset = excuteset;
    }

    public String getYoutubesource() {
        return youtubesource;
    }

    public void setYoutubesource(String youtubesource) {
        this.youtubesource = youtubesource;
    }

    public String getInjurypotential() {
        return injurypotential;
    }

    public void setInjurypotential(String injurypotential) {
        this.injurypotential = injurypotential;
    }

    public String getImportance() {
        return importance;
    }

    public void setImportance(String importance) {
        this.importance = importance;
    }

    public String getStrength() {
        return strength;
    }

    public void setStrength(String strength) {
        this.strength = strength;
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

    /*
  `trainingid` int(11) NOT NULL AUTO_INCREMENT,
  `trname` varchar(300) NOT NULL COMMENT '훈련제목',
  `trtype` varchar(50) NOT NULL COMMENT '훈련종류',
  `fieldermen` int(11) NOT NULL,
  `keepermen` int(11) NOT NULL,
  `spacex` int(11) NOT NULL,
  `spacey` int(11) NOT NULL,
  `spaceunit` varchar(45) NOT NULL,
  `exclass` varchar(45) DEFAULT NULL,
  `description` text,
  `attacktactics` text,
  `defencetactics` text,
  `attackskill` text,
  `defenceskill` text,
  `trattackobject` text,
  `defenceobject` text,
  `trobject` text,

  `trruletime` int(11) DEFAULT NULL,
  `breaktime` int(11) DEFAULT NULL,
  `excuteset` int(11) DEFAULT NULL,

  `youtubesource` varchar(300) DEFAULT NULL,
  `injurypotential` varchar(10) DEFAULT NULL COMMENT '부상가능성 (상, 중, 하)',
  `importance` varchar(10) DEFAULT NULL COMMENT '훈련중요도(상,중,하)',
  `strength` varchar(10) DEFAULT NULL COMMENT '훈련강도',
  `creationdate` datetime DEFAULT NULL,
  `lastupdatedate` datetime DEFAULT NULL,
     */
}
