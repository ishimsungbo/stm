package com.jui.stm.dao;

import com.jui.stm.dto.PagingDTO;
import com.jui.stm.vo.Board;

import java.util.List;

/**
 * Created by sungbo on 2015-10-30.
 */
public interface BoardDao {
    public int getBoardCount();
    public List<Board> getBoardList(PagingDTO pagingDTO);
}
