package com.jui.stm.dao;

import com.jui.stm.dto.FindUserDto;
import com.jui.stm.security.PreludebUser;
import com.jui.stm.security.Role;
import com.jui.stm.vo.UserVo;

import java.util.List;

/**
 * Created by Administrator on 2015-10-01.
 */
public interface UserDao {

    public void insertUser(UserVo userVo);

    public UserVo selectOnerow(int userkey);

    public int getTeamcount(String userid);

    public int getuserkey(String userid);

    public int usercheck(String userid);

    public UserVo fndUserpw(FindUserDto userDto);

    public int fndGetusercount(FindUserDto userDto);

    public int getSnsUser(String email,String uid);

    public PreludebUser selectUSer(String username);

    public List<Role> selectRole(String username);

    public int emailCheck(String email);

    public void insertVisit(String ip);

    //유저아이디 찾기
    public FindUserDto findUserid(String email);

}
