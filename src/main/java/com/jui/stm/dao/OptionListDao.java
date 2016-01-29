package com.jui.stm.dao;

import com.jui.stm.option.OexgameVo;

import java.util.List;

/**
 * Created by sungbo on 2015-12-28.
 */
public interface OptionListDao {

    public List<OexgameVo> exgameList(int teamid);

}
