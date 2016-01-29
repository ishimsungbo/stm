package com.jui.stm.vo;

public class LookupVo {

    private String LookupCode;
    private String LookupType;
    private String DescripTion;

    public LookupVo() {}



    public LookupVo(String lookupCode, String lookupType, String descripTion) {
        super();
        LookupCode = lookupCode;
        LookupType = lookupType;
        DescripTion = descripTion;
    }



    public String getDescripTion() {
        return DescripTion;
    }



    public void setDescripTion(String descripTion) {
        DescripTion = descripTion;
    }



    public String getLookupCode() {
        return LookupCode;
    }

    public void setLookupCode(String lookupCode) {
        LookupCode = lookupCode;
    }

    public String getLookupType() {
        return LookupType;
    }

    public void setLookupType(String lookupType) {
        LookupType = lookupType;
    }

}
