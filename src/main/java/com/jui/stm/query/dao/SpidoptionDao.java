package com.jui.stm.query.dao;

import com.jui.stm.query.vo.SpidoptionVo;

import java.util.List;

/**
 * Created by sungbo on 2015-12-14.
 */
public interface SpidoptionDao {
    public List<SpidoptionVo> getSelect(int teamid);
}
