package com.jui.stm.dao;

import com.jui.stm.query.dto.QueryParam;
import com.jui.stm.query.vo.MainExgameQueryVo;
import com.jui.stm.query.vo.PhyResultVo;
import com.jui.stm.reports.ExgameDto;
import com.jui.stm.reports.ExgamePlayerDto;
import com.jui.stm.reports.PlayerAvgDto;
import com.jui.stm.vo.PlayerGameVo;

import java.util.List;

/**
 * Created by sungbo on 2016-01-07.
 * Main 페이지 정보 SQL 정보
 */
public interface IndexPageDao {

    //연습경기 메인정보평균
    public ExgameDto exgameInfor(MainExgameQueryVo vo);
    public ExgamePlayerDto exgamePlayer(MainExgameQueryVo vo);

    //대회경기 메인정보평균
    public ExgameDto gameInfor(MainExgameQueryVo vo);
    public ExgamePlayerDto gamePlayer(MainExgameQueryVo vo);




    public List<PlayerAvgDto> playerRegulareval(PlayerAvgDto dto);

    //개인정보중 연습경기와 팀평균을 구함
    public List<ExgamePlayerDto> exgamePlayerAppear(MainExgameQueryVo vo);

    //선수들의 평균 신체사이즈를 표현함.
    public PhyResultVo avgPhyinfo(QueryParam queryParam);

    //대회경기의 개인 평균 기록을 보여준다.
    public List<PlayerGameVo> gamePlayerAvg(MainExgameQueryVo queryVo);

}
