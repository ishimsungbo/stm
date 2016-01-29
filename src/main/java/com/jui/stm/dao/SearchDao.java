package com.jui.stm.dao;

import com.jui.stm.vo.SearchVo;

import java.util.ArrayList;

/**
 * Created by sungbo on 2015-11-06.
 */
public interface SearchDao {

    ArrayList<SearchVo> plyaerNameList(int teamid);

}
