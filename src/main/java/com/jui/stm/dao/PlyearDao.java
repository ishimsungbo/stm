package com.jui.stm.dao;

import com.jui.stm.dto.PagingDTO;
import com.jui.stm.query.vo.PlayerCoTrVo;
import com.jui.stm.query.vo.PlayerQueryListVo;
import com.jui.stm.vo.PlayerVo;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by sungbo on 2015-10-13.
 */
public interface PlyearDao {

    public void InsertPlyear(PlayerVo playerVo);
    public ArrayList<PlayerVo> TeamPlayerList(int teamid);
    public void UpdatePicture(int playearid,String picture);
    public int getPlayersCount(PagingDTO dto);

    public ArrayList<PlayerVo> PlayerList(PagingDTO dto);

    public PlayerVo selectOneP(int plyearid);
    public void updatePlayer(PlayerVo vo);

    //입력및을 위한 임시적 리스트
    public List<PlayerQueryListVo> getTeamPlayerList(PlayerQueryListVo vo);

    public String getPlayerName(int playerid);


    //선수정보에서 코칭 및 일일훈련 데이터 부분
    public PlayerCoTrVo getPlayerRec(int playerid);

}
