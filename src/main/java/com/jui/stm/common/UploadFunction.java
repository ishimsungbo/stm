package com.jui.stm.common;


import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;


public class UploadFunction {

    public void writeFile(MultipartFile file,String filename,HttpServletRequest request,String rootPath){

        try {

            byte[] bytes = file.getBytes();

            File dir = new File(rootPath);

            File serverFile = new File(dir+ File.separator + filename);

            BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(serverFile));

            stream.write(bytes);
            stream.close();

            System.out.println("file path : "+dir+ File.separator + filename);
            System.out.println("file >>>>> : "+rootPath );

        } catch (Exception e) {
            e.printStackTrace();
        }

    }


}
