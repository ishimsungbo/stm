package com.jui.stm.dao;

import com.jui.stm.vo.CalendarVo;

import java.util.ArrayList;

/**
 * Created by sungbo on 2015-11-18.
 */
public interface CalendarDao {

    public ArrayList<CalendarVo> list(int teamid);

    public void createSchedile(CalendarVo calendarVo);

    public void deleteRow(CalendarVo calendarVo);
    public void updateRow(CalendarVo calendarVo);
}
