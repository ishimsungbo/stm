package com.jui.stm.dao;

import com.jui.stm.dto.PagingDTO;
import com.jui.stm.query.vo.MatchForgameVo;
import com.jui.stm.vo.GameVo;

import java.util.List;

/**
 * Created by Administrator on 2016-01-15.
 */
public interface MatchGamesDao {

    public void insertGame(GameVo vo);
    public void update(GameVo gameVo);
    public void delete(int gameid);

    public List<MatchForgameVo> matchList(int teamid);

    public int getMatchCount(PagingDTO dto);
    public List<GameVo> gameList(PagingDTO dto);

    public GameVo gameRow(int gameid);
}
