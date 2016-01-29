package com.jui.stm.dao;

import com.jui.stm.dto.GrappaingDTO;
import com.jui.stm.vo.EvalpartoneVo;
import com.jui.stm.vo.EvalrecordVo;
import com.jui.stm.vo.EvaluationPlayerVo;

import java.util.ArrayList;

/**
 * Created by Administrator on 2015-09-15.
 */
public interface EvaluationPlayerDao {

    public String getPlayerName(int pid);

    public void InsertEvalPlayer(EvaluationPlayerVo vo);

    public ArrayList<EvalrecordVo> getperRecord(GrappaingDTO dto);

    public ArrayList<EvalpartoneVo> getRecordPlayer(GrappaingDTO dto);

    public int getTotalCount(int pid);

    public ArrayList<EvaluationPlayerVo> getEvalplayerList(int evalid);

    public void upadteEvalPlayer(EvaluationPlayerVo evaluationPlayerVo);
    public void delete(int evalid);

    public ArrayList<EvalpartoneVo> getRecordshooting(GrappaingDTO dto);
    public ArrayList<EvalpartoneVo> getRecordkick(GrappaingDTO dto);
    public ArrayList<EvalpartoneVo> getRecorddribble(GrappaingDTO dto);
    public ArrayList<EvalpartoneVo> getRecordgame(GrappaingDTO dto);
    public ArrayList<EvalpartoneVo> getRecordleadings(GrappaingDTO dto);
    public ArrayList<EvalpartoneVo> getRecordtactics(GrappaingDTO dto);
    public ArrayList<EvalpartoneVo> getRecordpass(GrappaingDTO dto);
    public ArrayList<EvalpartoneVo> getRecordcreativity(GrappaingDTO dto);
    public ArrayList<EvalpartoneVo> getRecordcontroll(GrappaingDTO dto);

}
