package com.jui.stm.test;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by sungbo on 2015-12-18.
 */
@Controller
public class EditerController {



    private static final Logger logger = LoggerFactory.getLogger(EditerController.class);

    @RequestMapping("editer")
    public String editer(){

        return "/webtest/editer";
    }

    @RequestMapping("webtest/send")
    public String editerR(HttpServletRequest request,Model model){

        String smarteditor = request.getParameter("smarteditor");

        model.addAttribute("smarteditor", smarteditor);
        return "/webtest/send";
    }

/*    @RequestMapping("/photoUpload")
    public String photoUpload(HttpServletRequest request, PhotoVo vo){

        String callback = vo.getCallback();
        String callback_func = vo.getCallback_func();
        String file_result = "";

        logger.info("업로드를 합니다. 단일파일 업로드입니다.");

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
                String realname = "test1" + "." + ext;
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

            logger.info("업로드를 합니다. 다중파일 업로드입니다.");

            //파일정보
            String sFileInfo = "";
            //파일명을 받는다 - 일반 원본파일명
            String filename = request.getHeader("file-name");

            logger.info("filename : "+filename);


            //파일 확장자
            String filename_ext = filename.substring(filename.lastIndexOf(".")+1);

            logger.info("filename_ext1 : "+filename_ext);

            //확장자를소문자로 변경
            filename_ext = filename_ext.toLowerCase();


            logger.info("filename_ext2 : "+filename_ext);

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

            realFileNm = "test" + filename.substring(filename.lastIndexOf("."));

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

            sFileInfo += "&sFileName="+ filename;
            logger.info("sFileInfo : " + sFileInfo);
            sFileInfo += "&sFileURL="+"/resources/photo_upload/"+realFileNm;
            logger.info("sFileInfo : "+sFileInfo);



            PrintWriter print = response.getWriter();
            print.print(sFileInfo);
            print.flush();
            print.close();

            logger.info("업로드가 끝났습니다.");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }*/



}
