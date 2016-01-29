package com.jui.stm.dao;

import com.jui.stm.dto.PagingDTO;
import com.jui.stm.vo.TrjournalVo;

import java.util.List;

/**
 * Created by sungbo on 2015-12-22.
 */
public interface TrJrsDao {

    public List<TrjournalVo> selectList(PagingDTO pagingDTO);

    public int totalCount(PagingDTO pagingDTO);

    public void insert(TrjournalVo vo);

    public TrjournalVo selectRowdata(int jeid);

    public void deleteHeader(int jeid);
    public void deleteTimeLine(int jeid);
    public void deletePlayer(int jeid);
    public void updateHeader(TrjournalVo vo);

}
