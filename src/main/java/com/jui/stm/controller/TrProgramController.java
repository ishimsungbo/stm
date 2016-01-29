package com.jui.stm.controller;

import com.jui.stm.dao.TrProgramDao;
import com.jui.stm.dto.TrainingProDTO;
import com.jui.stm.vo.PhotoVo;
import com.jui.stm.vo.TrProgramVo;
import org.apache.commons.lang.StringUtils;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.text.SimpleDateFormat;
import java.util.UUID;

/**
 * Created by sungbo on 2015-12-18.
 */
@Controller
public class TrProgramController {


    private static final Logger logger = LoggerFactory.getLogger(MainController.class);

    @Autowired
    private SqlSession sqlSession;


    @RequestMapping("training/trview")
    public String View(HttpServletRequest request,
                       HttpSession session,
                       @ModelAttribute("trProgramVo") TrProgramVo trProgramVo,
                       Model model,
                       @RequestParam(value = "trainingid") int trainingid
                       ){

        TrProgramDao trProgramDao = sqlSession.getMapper(TrProgramDao.class);
        trProgramVo = trProgramDao.selectRow(trainingid);

        model.addAttribute("trProgramVo",trProgramVo);
        return "training/trview";
    }

    @RequestMapping("training/dbupdate")
    public String trUpdate(@ModelAttribute("trProgramVo") TrProgramVo trProgramVo){
        logger.info("업데이트 요청 아이디는 : " + trProgramVo.getTrainingid());


        return "redirect:" +"/training/trmain?upflag=U";
    }

    @RequestMapping("training/delete")
    public String delete(@RequestParam(value = "trainingid",required = false) int trainingid){
        logger.info("training 삭제를 시작합니다.");

        TrProgramDao trProgramDao = sqlSession.getMapper(TrProgramDao.class);

        trProgramDao.delete(trainingid);

        logger.info("training 삭제가 종료 되었습니다.");
        return "redirect:" +"/training/trmain?upflag=D";
    }



    @RequestMapping("training/trmain")
    public String trMain(Model model,HttpSession session,HttpServletRequest request,
                         @ModelAttribute("trainingProDto") TrainingProDTO trainingProDto,
                         @RequestParam(required = false,value = "pageNo") String pageNo,
                         @RequestParam(required = false,value = "upflag") String upflag,
                         @RequestParam(required = false,value = "search_trname") String search_trname,
                         @RequestParam(required = false,value = "search_trtype") String search_trtype,
                         @RequestParam(required = false,value = "search_exclass") String search_exclass,
                         @RequestParam(required = false,value = "search_injurypotential") String search_injurypotential,
                         @RequestParam(required = false,value = "search_importance") String search_importance,
                         @RequestParam(required = false,value = "search_strength") String search_strength,
                         @RequestParam(required = false,value = "search_sign" ) String search_sign,
                         @RequestParam(required = false,value = "search_trruletime" ) String search_trruletime
    ){

        logger.info("훈련프로그램 컨트롤러 시작 trMain()");

        int teamid = (Integer) session.getAttribute("teamid");
        trainingProDto.setTeamid(teamid);

        if(StringUtils.isNotEmpty(search_trruletime)){
            int exsearch_trruletime=0;
            exsearch_trruletime  = Integer.parseInt(search_trruletime);
            if(exsearch_trruletime != 0){
                trainingProDto.setTrruletime(exsearch_trruletime);
            }
            logger.info("훈련시간 분은 : "+trainingProDto.getTrruletime());
        }



        logger.info("search_trruletime 값은 : " + search_trruletime);

        trainingProDto.setPageSize(5);  // 한 페이지에 보일 게시글 수
        trainingProDto.setPageNo(1);     // 현재 페이지 번호
        trainingProDto.setBlockSize(5);

        if(StringUtils.isNotEmpty(search_trname)){
            trainingProDto.setTrname(search_trname);
        }

        if(StringUtils.isNotEmpty(search_trtype)){
            trainingProDto.setTrtype(search_trtype);
        }

        if(StringUtils.isNotEmpty(search_exclass)){
            trainingProDto.setExclass(search_exclass);
        }

        if (StringUtils.isNotEmpty(search_injurypotential)){
            trainingProDto.setInjurypotential(search_injurypotential);
        }

        if(StringUtils.isNotEmpty(search_importance)){
            trainingProDto.setImportance(search_importance);
        }

        if(StringUtils.isNotEmpty(search_strength)){
            trainingProDto.setStrength(search_strength);
        }

        if(StringUtils.isNotEmpty(search_sign)){
            trainingProDto.setSign(search_sign);
        }


        if(StringUtils.isNotEmpty(pageNo)){
            trainingProDto.setPageNo(Integer.parseInt(pageNo));
        }


        logger.info("팀아이디는 : " + trainingProDto.getTeamid());
        logger.info("시작 숫자 : " + trainingProDto.getStartRowNum());
        logger.info("끝 숫자 : " + trainingProDto.getPageSize());

        TrProgramDao trProgramDao = sqlSession.getMapper(TrProgramDao.class);

        trainingProDto.setTotalCount(trProgramDao.trProgramCount(trainingProDto));


        model.addAttribute("pageNo", pageNo);
        model.addAttribute("trprolist",trProgramDao.trProgramList(trainingProDto));
        model.addAttribute("trainingProDto",trainingProDto);
        model.addAttribute("upflag",upflag);


        logger.info("훈련프로그램 컨트롤러 종료 trMain()");

        return "/training/trmain";
    }

    @RequestMapping("training/trinsert")
    public String trInsert(){
        logger.info("훈련프로그램 컨트롤러 시작 trInsert()");


        logger.info("훈련프로그램 컨트롤러 종료 trInsert()");
        return "/training/trinsert";
    }

    @RequestMapping("traninig/dbinsert")
    public String trinsertdb(
            @ModelAttribute("TrProgramVo") TrProgramVo trProgramVo,
            HttpSession session
    ){
        logger.info("훈련프로그램 컨트롤러 시작 trinsertdb()");

        trProgramVo.setTeamid((Integer) session.getAttribute("teamid"));
        TrProgramDao trProgramDao = sqlSession.getMapper(TrProgramDao.class);
        trProgramDao.insert(trProgramVo);

        logger.info("훈련프로그램 컨트롤러 종료 trinsertdb()");
        return "redirect:" +"/training/trmain?upflag=I";
    }

//resources/nvediter/sample/photo_uploader/photo_uploader.html
    @RequestMapping("/photoUpload")
    public String photoUpload(HttpServletRequest request, PhotoVo vo){

        String callback = vo.getCallback();
        String callback_func = vo.getCallback_func();
        String file_result = "";

        try {
            if(vo.getFiledata() != null && vo.getFiledata().getOriginalFilename() != null && !vo.getFiledata().getOriginalFilename().equals("")){
                //파일이 존재하면
                String original_name = vo.getFiledata().getOriginalFilename();
                String ext = original_name.substring(original_name.lastIndexOf(".")+1);
                //파일 기본경로
                String defaultPath = request.getSession().getServletContext().getRealPath("/");
                //파일 기본경로 _ 상세경로
                String path = defaultPath + "resources" + File.separator + "photo_upload" + File.separator;
                File file = new File(path);
                System.out.println("path:"+path);
                //디렉토리 존재하지 않을경우 디렉토리 생성
                if(!file.exists()) {
                    file.mkdirs();
                }
                //서버에 업로드 할 파일명(한글문제로 인해 원본파일은 올리지 않는것이 좋음)
                String realname = UUID.randomUUID().toString() + "." + ext;
                ///////////////// 서버에 파일쓰기 /////////////////
                vo.getFiledata().transferTo(new File(path+realname));
                file_result += "&bNewLine=true&sFileName="+original_name+"&sFileURL=/resources/photo_upload/"+realname;
            } else {
                file_result += "&errstr=error";
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "redirect:" + callback + "?callback_func="+callback_func+file_result;
    }

    //다중파일업로드
    @RequestMapping("/multiplePhotoUpload")
    public void multiplePhotoUpload(HttpServletRequest request, HttpServletResponse response){
        try {
            //파일정보
            String sFileInfo = "";
            //파일명을 받는다 - 일반 원본파일명
            String filename = request.getHeader("file-name");
            //파일 확장자
            String filename_ext = filename.substring(filename.lastIndexOf(".")+1);
            //확장자를소문자로 변경
            filename_ext = filename_ext.toLowerCase();
            //파일 기본경로
            String dftFilePath = request.getSession().getServletContext().getRealPath("/");
            //파일 기본경로 _ 상세경로
            String filePath = dftFilePath + "resources" + File.separator + "photo_upload" + File.separator;
            File file = new File(filePath);
            if(!file.exists()) {
                file.mkdirs();
            }
            String realFileNm = "";
            SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
            String today= formatter.format(new java.util.Date());
            realFileNm = today+UUID.randomUUID().toString() + filename.substring(filename.lastIndexOf("."));
            String rlFileNm = filePath + realFileNm;
            ///////////////// 서버에 파일쓰기 /////////////////
            InputStream is = request.getInputStream();
            OutputStream os=new FileOutputStream(rlFileNm);
            int numRead;
            byte b[] = new byte[Integer.parseInt(request.getHeader("file-size"))];
            while((numRead = is.read(b,0,b.length)) != -1){
                os.write(b,0,numRead);
            }
            if(is != null) {
                is.close();
            }
            os.flush();
            os.close();
            ///////////////// 서버에 파일쓰기 /////////////////
            // 정보 출력
            sFileInfo += "&bNewLine=true";
            // img 태그의 title 속성을 원본파일명으로 적용시켜주기 위함
            sFileInfo += "&sFileName="+ filename;;
            sFileInfo += "&sFileURL="+"/resources/photo_upload/"+realFileNm;
            PrintWriter print = response.getWriter();
            print.print(sFileInfo);
            print.flush();
            print.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
