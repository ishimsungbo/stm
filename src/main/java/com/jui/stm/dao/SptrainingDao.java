package com.jui.stm.dao;

import com.jui.stm.vo.SptrainingVo;

import java.util.List;

/**
 * Created by sungbo on 2015-12-14.
 */
public interface SptrainingDao {

    public void insertSp(SptrainingVo vo);
    public void updateSp(SptrainingVo vo);
    public void deleteSp(int sptrid);
    public List<SptrainingVo> sptrainingList(int teamid);
    public SptrainingVo selectRow(int sptrid);

}
