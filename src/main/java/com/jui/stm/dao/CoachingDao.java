package com.jui.stm.dao;

import com.jui.stm.dto.CoachingDTO;
import com.jui.stm.vo.CoachingVo;

import java.util.ArrayList;

/**
 * Created by sungbo on 2015-11-09.
 */
public interface CoachingDao {

    public void insert(CoachingVo vo);

    public ArrayList<CoachingVo> listCoachings(CoachingDTO dto);

    public int totalCount(CoachingDTO dto);

    public CoachingVo selectOnerow(CoachingVo vo);
    public void update(CoachingVo vo);
}
