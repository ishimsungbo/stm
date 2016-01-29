package com.jui.stm.vo;

import java.util.Map;

/**
 * Created by sungbo on 2015-12-18.
 */
public class UserSnsVo {


    private String id;
    private Map<String,String> properties;

    public UserSnsVo(){};

    public UserSnsVo(String id, Map<String, String> properties) {
        this.id = id;
        this.properties = properties;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Map<String, String> getProperties() {
        return properties;
    }

    public void setProperties(Map<String, String> properties) {
        this.properties = properties;
    }
}
