package com.jui.stm.vo;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by sungbo on 2015-12-21.
 */
public class TrtimeLineList {

    private List<TrjrtimelineVo> timelineVos = new ArrayList<TrjrtimelineVo>();

    public List<TrjrtimelineVo> getTimelineVos() {
        return timelineVos;
    }

    public void setTimelineVos(List<TrjrtimelineVo> timelineVos) {
        this.timelineVos = timelineVos;
    }
}
