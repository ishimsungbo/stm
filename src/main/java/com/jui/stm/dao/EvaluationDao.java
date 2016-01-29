package com.jui.stm.dao;

import com.jui.stm.dto.EvaluationDTO;
import com.jui.stm.vo.EvaluationVo;

import java.util.ArrayList;

/**
 * Created by Administrator on 2015-09-15.
 */
public interface EvaluationDao {

    public void inSertEval(EvaluationVo vo);

    public ArrayList<EvaluationVo> evaluationList(EvaluationDTO dto);

    public int evaluationCount(EvaluationDTO dto);

    public EvaluationVo selectEvalRow(int id);

    public void updateEval(EvaluationVo vo);
    public void delete(int evalid);
}
