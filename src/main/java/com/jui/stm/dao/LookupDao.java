package com.jui.stm.dao;

import com.jui.stm.vo.LookupVo;

import java.util.ArrayList;

public interface LookupDao {

    public ArrayList<LookupVo> LookupFind(String lookupType);

}
