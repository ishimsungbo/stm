package com.jui.stm.dao;

import com.jui.stm.vo.TrjrtimelineVo;

import java.util.List;

/**
 * Created by sungbo on 2015-12-23.
 */
public interface JounalTimeLineDao {

    public void insert(TrjrtimelineVo trjrtimelineVo);

    public List<TrjrtimelineVo> selectRowdata(int jeid);
}
