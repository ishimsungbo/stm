package com.jui.stm.vo;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Administrator on 2015-09-15.
 */
public class EvaluationPlayerList {

    List<EvaluationPlayerVo> evalvos = new ArrayList<EvaluationPlayerVo>();

    public EvaluationPlayerList() {

    }

    public List<EvaluationPlayerVo> getEvalvos() {
        return evalvos;
    }

    public void setevalvos(List<EvaluationPlayerVo> evalvos) {
        this.evalvos = evalvos;
    }

}
