package com.jui.stm.dao;

import com.jui.stm.vo.TeamVo;

import java.util.ArrayList;

/**
 * Created by DIT213103 on 2015-09-03.
 */
public interface TeamDao {

    public void InsertTeamDao(TeamVo teamVo);

    public TeamVo FindTeamInfo(int teamid);

    public ArrayList<TeamVo> TeamList();

    public void UpdateEmblem(int teamid, String emblem);

    public TeamVo userkeyTeam(int userkey);

    public int getTeamid(int userkey);

}
