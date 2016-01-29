package com.jui.stm.dao;

import com.jui.stm.query.vo.PlayerInfoAvgVo;
import com.jui.stm.vo.PlayerGameVo;

import java.util.List;

/**
 * Created by sungbo on 2015-12-28.
 */
public interface PlayerGameDao {

    public void insert(PlayerGameVo playerGameVo);
    public void update(PlayerGameVo playerGameVo);
    public void delete(int playergameid);
    public void gamedelete(int playergameid);

    public List<PlayerGameVo> teamPlayerList(int teamid);
    public List<PlayerGameVo> exgamePlayer(int teamid,int exgameid);

    public List<PlayerGameVo> gamePlayer(int teamid,int exgameid);

    //선수게임내용이 저장된 데이터 가져오기
    public List<PlayerGameVo> getExgamePlayerList(int exgameid);

    public List<PlayerGameVo> getGamePlayerList(int exgameid);

    //선수조회화면에서의 연습경기//대회경기 평균 보조정보
    public PlayerInfoAvgVo playerInfoAvgexgame(PlayerInfoAvgVo playerInfoAvgVo);

    public PlayerInfoAvgVo playerInfoAvggame(PlayerInfoAvgVo playerInfoAvgVo);


}
