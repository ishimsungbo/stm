package com.jui.stm.dao;

import com.jui.stm.vo.PhysicalHeaderVo;
import com.jui.stm.vo.PhysicalLineVo;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by sungbo on 2016-01-04.
 */
public interface PhyplayerDao {

    public void headerInsert(PhysicalHeaderVo vo);
    public void headerUpdate(PhysicalHeaderVo vo);
    public void headerDelete(int headerid);

    public List<PhysicalHeaderVo> selectHeader(int teamid);

    public PhysicalHeaderVo selectHeaderRow(int headerid);
    public ArrayList<PhysicalLineVo> selectLines(int headerid);

    public void lineInsert(PhysicalLineVo vo);
    public void lineUpdate(PhysicalLineVo vo);
    public void lineDelete(int lineid);

}
