package com.jui.stm.dao;

import com.jui.stm.dto.TrainingProDTO;
import com.jui.stm.vo.TrProVo;
import com.jui.stm.vo.TrProgramVo;

import java.util.List;

/**
 * Created by sungbo on 2015-12-18.
 */
public interface TrProgramDao {

    public void insert(TrProgramVo trProgramVo);

    public void update(TrProgramVo trProgramVo);

    public void delete(int training_program_id);

    public int trProgramCount(TrainingProDTO trainingProDto);

    public List<TrProgramVo> trProgramList(TrainingProDTO trainingProDto);

    public TrProgramVo selectRow(int trainingid);

    public List<TrProVo> trProgramSelect(int teamid);
}
