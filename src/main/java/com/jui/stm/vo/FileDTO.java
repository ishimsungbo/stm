package com.jui.stm.vo;

import org.springframework.web.multipart.MultipartFile;

/**
 * Created by Sungbo on 2016-02-11.
 */
public class FileDTO {


    private String filename;
    private MultipartFile uploadfile;

    public FileDTO() {
    }

    public FileDTO(String filename, MultipartFile uploadfile) {
        this.filename = filename;
        this.uploadfile = uploadfile;
    }

    public String getFilename() {
        return filename;
    }

    public void setFilename(String filename) {
        this.filename = filename;
    }

    public MultipartFile getUploadfile() {
        return uploadfile;
    }

    public void setUploadfile(MultipartFile uploadfile) {
        this.uploadfile = uploadfile;
    }
}
