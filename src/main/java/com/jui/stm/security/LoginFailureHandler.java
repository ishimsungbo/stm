package com.jui.stm.security;

import com.jui.stm.common.vo.ErrorVo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class LoginFailureHandler implements AuthenticationFailureHandler
{
    private static final Logger logger = LoggerFactory.getLogger(LoginFailureHandler.class);

    public void onAuthenticationFailure(HttpServletRequest request,
                                        HttpServletResponse response,
                                        AuthenticationException auth) throws IOException, ServletException
    {
        ErrorVo errorVo = new ErrorVo();
        errorVo.setErrormsg(auth.getMessage());

        logger.info(errorVo.getErrormsg());

        response.sendRedirect(request.getContextPath() + "/?error="+errorVo.getErrormsg());
    }
}