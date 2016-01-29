package com.jui.stm.security;

import com.jui.stm.dao.UserDao;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.StandardPasswordEncoder;

import java.util.List;

/**
 * Created by sungbo on 2016-01-02.
 */
public class PreludebUserService implements UserDetailsService
{
    private static final Logger logger = LoggerFactory.getLogger(PreludebUserService.class);

    @Autowired
    private SqlSession sqlSession;

    
    public UserDetails loadUserByUsername(String username,SqlSession session) throws UsernameNotFoundException
    {

        logger.info("1.스프링 시큐리티를 가동합니다.");
        StandardPasswordEncoder encoder = new StandardPasswordEncoder("");

        logger.info("Dao 접속전");
        UserDao userDao = session.getMapper(UserDao.class);
        logger.info("Dao 접속후");

        try {
            PreludebUser user = userDao.selectUSer(username);

            PreludebUser entazUser = new PreludebUser();

            //해당유저의 아이디와 비번을 셋팅
            entazUser.setUsername(user.getUsername());
            entazUser.setPassword(user.getPassword());

            logger.info("1.비번은 : "+ encoder.encode(user.getPassword()));

            logger.info("스프링 권한 값을 가져옵니다.");

            //해당유저의 권한
            List<Role> roles = userDao.selectRole(username);

            for(int i=0; i < roles.size();i++){
                logger.info("권한은 : " + roles.get(i).getName());
            }

            entazUser.setAuthorities(roles);

            logger.info("스프링 시큐리티 검증을 리턴합니다.");
            return entazUser;

        }catch (Exception e){
            PreludebUser entazUser = new PreludebUser();
            return entazUser;
        }

    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException
    {

        logger.info("2.스프링 시큐리티를 가동합니다.");
        StandardPasswordEncoder encoder = new StandardPasswordEncoder("");

        logger.info("Dao 접속전");
        UserDao userDao = sqlSession.getMapper(UserDao.class);
        logger.info("Dao 접속후");
        PreludebUser user  = userDao.selectUSer(username);


        PreludebUser entazUser = new PreludebUser();

        //해당유저의 아이디와 비번을 셋팅
        entazUser.setUsername(user.getUsername());
        entazUser.setPassword(user.getPassword());

        logger.info("2.비번은 : "+ user.getPassword());
        logger.info("스프링 권한 값을 가져옵니다.");

        //해당유저의 권한
        List<Role> roles = userDao.selectRole(username);

        for(int i=0; i < roles.size();i++){
            logger.info("권한은 : " + roles.get(i).getName());
        }

        entazUser.setAuthorities(roles);

        logger.info("스프링 시큐리티 검증을 리턴합니다.");
        return entazUser;
    }
}