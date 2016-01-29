package com.jui.stm.dao;

import com.jui.stm.dto.MeetingDTO;
import com.jui.stm.vo.MatchsVo;

import java.util.List;

/**
 * Created by Administrator on 2016-01-11.
 */
public interface MatchDao {

    public void matchInsert(MatchsVo vo);
    public void matchUpdate(MatchsVo matchsVo);
    public void delete(int teamid,int matchid);


    public List<MatchsVo> selectList(MeetingDTO MEETING_DTO);
    public int selectCount(MeetingDTO MEETING_DTO);

    public MatchsVo matchOne(int teamid,int matchid);


}
