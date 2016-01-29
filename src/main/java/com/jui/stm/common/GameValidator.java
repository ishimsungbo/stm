package com.jui.stm.common;

import com.jui.stm.vo.GameVo;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

/**
 * Created by sungbo on 2016-01-19.
 */
public class GameValidator implements Validator {

    @Override
    public boolean supports(Class aClass) {
        return false;
    }

    @Override
    public void validate(Object target, Errors errors) {
        GameVo gameVo = (GameVo) target;
        if(gameVo.getMatchid()==0){
            errors.rejectValue("matchid", "match.game.matchid.empty");
        }
        if(gameVo.getGamedate().equals("")){
            errors.rejectValue("gamedate", "match.game.gamedate.empty");
        }
        if(gameVo.getOppoteam().equals("")){
            errors.rejectValue("oppoteam", "match.game.oppoteam.empty");
        }
        if(gameVo.getLocation().equals("")){
            errors.rejectValue("location", "match.game.location.empty");
        }

    }

}
