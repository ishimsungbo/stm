package com.jui.stm.vo;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by sungbo on 2015-12-28.
 */
public class PlayerGameList {

    List<PlayerGameVo> playerGameVos = new ArrayList<PlayerGameVo>();

    public PlayerGameList(){}

    public PlayerGameList(List<PlayerGameVo> playerGameVos) {
        this.playerGameVos = playerGameVos;
    }

    public List<PlayerGameVo> getPlayerGameVos() {
        return playerGameVos;
    }

    public void setPlayerGameVos(List<PlayerGameVo> playerGameVos) {
        this.playerGameVos = playerGameVos;
    }
}
