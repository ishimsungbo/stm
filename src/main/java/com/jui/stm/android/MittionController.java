package com.jui.stm.android;

import com.jui.stm.android.vo.MisstionVo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Sungbo on 2016-03-22.
 */

@Controller
@RequestMapping(value= "/and/")
public class MittionController {

    private static final Logger logger = LoggerFactory.getLogger(MittionController.class);

    @RequestMapping(value= "mlist")
    public @ResponseBody
    List<MisstionVo> MisstionVo()  {

        logger.info("서버를 호출했습니다 : 영상 리스트");

        List<MisstionVo> misstionVos = new ArrayList<MisstionVo>();

        misstionVos.add(new MisstionVo(1,"src","재기차기 영상","노태우1"));
        misstionVos.add(new MisstionVo(2,"src","인사이드 영상","노태우2"));
        misstionVos.add(new MisstionVo(3,"src","헤딩 영상","노태우3"));
        misstionVos.add(new MisstionVo(4,"src","무릎 영상","노태우4"));

        return misstionVos;
    }

    @RequestMapping(value= "post",method= RequestMethod.POST)
    public @ResponseBody String message(){
        logger.info("서버로 데이터 옴");
        return "Server";
    }


}
