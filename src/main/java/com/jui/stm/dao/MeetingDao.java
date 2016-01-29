package com.jui.stm.dao;

import com.jui.stm.dto.MeetingDTO;
import com.jui.stm.vo.MeetingVo;

import java.util.List;

/**
 * Created by sungbo on 2015-12-25.
 */
public interface MeetingDao {
    //default transaction
    public void insert(MeetingVo meetingVo);
    public void update(MeetingVo meetingVo);
    public void delete(MeetingVo meetingVo);

    //paging
    public int selectCount(MeetingDTO meetingDTO);
    public List<MeetingVo> selectList(MeetingDTO meetingDTO);

    //updateview
    public MeetingVo getmeetingData(int meetingid);

}
