package com.jui.stm.dao;

import com.jui.stm.vo.EvalDetailVo;

/**
 * Created by Administrator on 2016-01-26.
 */
public interface EvaldetaileDao {

    public void insert(EvalDetailVo vo);
    public void update(EvalDetailVo vo);
    public void delete(int detaileid);


    public EvalDetailVo getDetailData(int teamid,int playerid,int evalid);


}
