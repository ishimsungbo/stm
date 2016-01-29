package com.jui.stm.dao;

import com.jui.stm.dto.PagingDTO;
import com.jui.stm.vo.ExGameVo;

import java.util.List;

/**
 * Created by sungbo on 2015-11-09.
 */
public interface ExGameDao {

    public void insert(ExGameVo gameVo);
    public void update(ExGameVo gameVo);
    public void deleteRow(int exGamonid);

    public ExGameVo selectOne(ExGameVo exGameVo);
    public int getExgameCount(PagingDTO pagingDTO);
    public List<ExGameVo> selectList(PagingDTO pagingDTO);


}
