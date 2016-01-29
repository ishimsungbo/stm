package com.jui.stm.dao;

import com.jui.stm.vo.PlayerVo;
import com.jui.stm.vo.TrJrPlayerVo;

import java.util.List;

/**
 * Created by sungbo on 2015-12-21.
 */
public interface TrjrPlayerDao {

    public List<TrJrPlayerVo> tempPlayerlist(PlayerVo vo);

    public void insert(TrJrPlayerVo trJrPlayerVo);

    public List<TrJrPlayerVo> selectRowdata(int jeid);
}
