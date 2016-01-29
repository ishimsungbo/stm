package com.jui.stm.controller;

import com.google.gson.Gson;
import com.jui.stm.common.Utils;
import com.jui.stm.security.PreludebUserService;
import com.jui.stm.vo.UserSnsVo;
import org.apache.commons.lang.StringUtils;
import org.apache.ibatis.session.SqlSession;
import org.json.JSONObject;
import org.json.XML;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.WebAuthenticationDetails;
import org.springframework.social.ApiException;
import org.springframework.social.MissingAuthorizationException;
import org.springframework.social.connect.Connection;
import org.springframework.social.facebook.api.Facebook;
import org.springframework.social.facebook.api.FacebookProfile;
import org.springframework.social.facebook.api.UserOperations;
import org.springframework.social.facebook.api.impl.FacebookTemplate;
import org.springframework.social.facebook.connect.FacebookConnectionFactory;
import org.springframework.social.oauth2.AccessGrant;
import org.springframework.social.oauth2.GrantType;
import org.springframework.social.oauth2.OAuth2Operations;
import org.springframework.social.oauth2.OAuth2Parameters;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import twitter4j.Twitter;
import twitter4j.TwitterException;
import twitter4j.TwitterFactory;
import twitter4j.auth.AccessToken;
import twitter4j.auth.RequestToken;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

/**
 * Created by sungbo on 2015-12-16.
 */
@Controller
public class OathController {

    @Autowired
    private SqlSession sqlSession;

    //@Autowired
    //protected AuthenticationManager authenticationManager;

    private static final Logger logger = LoggerFactory.getLogger(OathController.class);


    private static final String mydomain = "http%3A%2F%2Ftest.stm.com%3A9090%2Foauth%2Fcallback";

    /*  oauth naver  */
    private static final String clientId = "yYg3fmXOLwXxdcifU0_B";
    private static final String clientSecret = "uqGQdPo5OK";
    private static final String requestUrl = "https://nid.naver.com/oauth2.0/authorize?client_id=" + clientId + "&response_type=code&redirect_uri=" + mydomain + "&state=";
    private static final String userProfileUrl = "https://apis.naver.com/nidlogin/nid/getUserProfile.xml";

    /* oauth kakao */
    private static final String restapi="0bc109cdb8451ec5897b1e89790f5817";
    private static final String mydomainkakao = "http%3A%2F%2Ftest.stm.com%3A9090%2Foauth%2Fcallback%2Fkakao";
    private static final String karequestUrl = "https://kauth.kakao.com/oauth/authorize?client_id="+restapi+"&redirect_uri="+mydomainkakao+"&response_type=code&state=";
    private static final String adminkey="2dd6095a474f2e9a6c38f7b2ec839704";


    //encodeURIComponent('http://localhost:8080/oauth/callback/daum')
    /* oauth daum */
    private static final String daumrediectUrl="http%3A%2F%2Flocalhost%3A8080%2Foauth%2Fcallback%2Fdaum";
    private static final String daumClientID="6434366539098823353";
    private static final String daumSecretKey="a36e328a350057d5e562c29a34d76a22";
    private static final String daumUrl="https://apis.daum.net/oauth2/authorize?client_id="+daumClientID+"&amp;redirect_uri="+daumrediectUrl+"&amp;response_type=token";

    //twitter key
    private  String ConsumerKey="KKmUDX4TOU2NYARotBNaa9Irb";
    private  String ConsumerSecret="qwpRmvIhYEwnp9kJY8ln6OM9fj1bNDsZRHCQxfpEaT3qtuVqJN";


    @Autowired
    private FacebookConnectionFactory connectionFactory;

    @Autowired
    private OAuth2Parameters oAuth2Parameters;

    public String getAuthorizeUrl(){
        OAuth2Operations oauthOperations = connectionFactory.getOAuthOperations();
        String authorizeUrl = oauthOperations.buildAuthorizeUrl(GrantType.AUTHORIZATION_CODE, oAuth2Parameters);
        return authorizeUrl;
    }

    /* 스프링 오토 로그인 */
    public boolean setAuthentication(HttpServletRequest request,String userid, String userpwd){

        UsernamePasswordAuthenticationToken token = new UsernamePasswordAuthenticationToken(userid,userpwd);
        request.getSession();
        token.setDetails(new WebAuthenticationDetails(request));

        //자동로그인하기 2016-01-02 변경
        UserDetails userDetails = new PreludebUserService().loadUserByUsername(userid, sqlSession);


        //유저정보가 없다면 회워 가입 사이트로 이동한다.
        if(StringUtils.isEmpty(userDetails.getUsername())){
            return false;
        }else{
            //유저가 존재한다면 로그인을 시킨다
            UsernamePasswordAuthenticationToken auth = new UsernamePasswordAuthenticationToken(userDetails, userpwd, userDetails.getAuthorities());
            SecurityContextHolder.getContext().setAuthentication(auth);
            return true;
        }

    }


    @RequestMapping(value = "oauth/login")
    public String naverLogin(HttpSession session
            ,HttpServletRequest request
            ,HttpServletResponse response
            ,@RequestParam(required = false,value = "snsname") String snsname)
    {
        logger.info("login을 시작합니다.");
        logger.info("login요청 sns는 : " + snsname);

        //1.네이버 아이디로 사용할 경우
        if(snsname.equals("naver")){
            String state = Utils.generateState();     //토큰을 생성합니다.
            session.setAttribute("state", state);      //세션에 토큰을 저장합니다.
            logger.info("Sesstion.state :" + state);
            logger.info("login 요청 종료 CallBack 기다리는 중");
            return "redirect:" + requestUrl + state;   //만들어진 URL로 인증을 요청합니다.
        }

        if(snsname.equals("kakao")){

            String state = Utils.generateState();
            session.setAttribute("state", state);

            logger.info("Sesstion.state :" + state);
            logger.info("login 코드 요청 종료 CallBack 기다리는 중");
            logger.info("login 코드 요청 보낸 uri 값은 "+karequestUrl+state);
            return "redirect:" + karequestUrl+state;   //만들어진 URL로 인증을 요청합니다.
        }

        if(snsname.equals("twitter")){

            logger.info("트위터 로그인 시작");
            Twitter twitter = new TwitterFactory().getInstance();
            twitter.setOAuthConsumer(ConsumerKey,ConsumerSecret);

            RequestToken requestToken = null;
            try {
                requestToken = twitter.getOAuthRequestToken();
            } catch (TwitterException e) {
                e.printStackTrace();
            }
            request.getSession().setAttribute("requestToken", requestToken);
            String url = requestToken.getAuthorizationURL();

            logger.info("주소 : " + url);
            logger.info("비밀키 : " + requestToken.getTokenSecret());

            return "redirect:"+url; //만들어진 URL로 인증을 요청합니다.
        }

        //잘안됨
        if(snsname.equals("facebook")){

            logger.info("1.페이스북 로그인 요청을 보냅니다");
            try {
                response.sendRedirect(getAuthorizeUrl());
                logger.info("2.페이스북 Call 됨.");
            } catch (IOException e) {
                e.printStackTrace();
            }

        }

        //잘안됨
        if(snsname.equals("daum")){

            logger.info("login 코드 요청 종료 CallBack 기다리는 중");
            return "redirect:" + daumUrl;
        }
        logger.info("로그인 요청 로직 종료");

        return null;
    }

    @RequestMapping(value = "oauth/callback/facebook",method = RequestMethod.GET)
    public String printWelcome(String code,
                               HttpServletRequest req,
                               HttpServletResponse res
    ) throws Exception{

        logger.info("페이스북 응답이 왔습니다.");
        String snsName = "FACEBOOK";

        String accessToken = code;
        OAuth2Operations oauthOperations = connectionFactory.getOAuthOperations();
        AccessGrant accessGrant = oauthOperations.exchangeForAccess(code, "http://test.stm.com:9090/oauth/callback/facebook", null);

        //토큰을 세션에 저장한다.
        String accessToken1 = accessGrant.getAccessToken();

        Long expireTime =  accessGrant.getExpireTime();

        if (expireTime != null && expireTime < System.currentTimeMillis()) {
            accessToken = accessGrant.getRefreshToken();
            System.out.println("accessToken is expired. refresh token = {}" + accessToken);
        }

        Connection<Facebook> connection = connectionFactory.createConnection(accessGrant);
        Facebook facebook = connection == null ? new FacebookTemplate(accessToken) : connection.getApi();

        UserOperations userOperations = facebook.userOperations();
        FacebookProfile facebookProfile = null;

        try {
            facebookProfile = userOperations.getUserProfile();
        } catch (MissingAuthorizationException e) {
            e.printStackTrace();

        } catch (ApiException e) {
            e.printStackTrace();

        }

        logger.info("ID " + facebookProfile.getId());
        logger.info("Name "+facebookProfile.getName());

        String snsuserid   = facebookProfile.getId();
        String snsusername = facebookProfile.getName();


        if(setAuthentication(req, snsuserid, snsuserid)){
            logger.info("카카오 강제 로그인 성공 STM으로 테스트 로그인");
            if(SecurityContextHolder.getContext().getAuthentication().isAuthenticated()) {
                return "redirect:" + "/";
            }
        }


        return "redirect:/snsUserJoin?snsName="+snsName+"&userid="+snsuserid+"&snsusername="+snsusername;
    }


    @RequestMapping("oauth/callback/twitter")
    public String callbackTwitter(HttpServletRequest request
            ,HttpServletResponse response,Model model
    ) throws Exception{

        String snsName = "TWITTER";

        logger.info("트위터 인증값이 도착했습니다.");

        Twitter twitter = new TwitterFactory().getInstance();
        twitter.setOAuthConsumer(ConsumerKey, ConsumerSecret);
        AccessToken accessToken = null;

        String oauth_verifier = request.getParameter("oauth_verifier");

        RequestToken requestToken = (RequestToken) request.getSession().getAttribute("requestToken");
        accessToken	 = twitter.getOAuthAccessToken(requestToken,oauth_verifier);


        twitter.setOAuthAccessToken(accessToken);
        request.getParameter("oauth_token");

        logger.info("가져온 Userid : " + accessToken.getUserId());
        logger.info("가져온 Name : " + accessToken.getScreenName());


        String snsuserid   = String.valueOf(accessToken.getUserId());
        String snsusername = accessToken.getScreenName();


        if(setAuthentication(request, snsuserid, snsuserid)) {
            logger.info("카카오 강제 로그인 성공 STM으로 테스트 로그인");
            if (SecurityContextHolder.getContext().getAuthentication().isAuthenticated()) {
                return "redirect:" + "/";
            }
        }

        return "redirect:/snsUserJoin?snsName="+snsName+"&userid="+snsuserid+"&snsusername="+snsusername;
    }



    @RequestMapping(value = "oauth/callback/kakao")
    public String callbackkakao(@RequestParam(required = false,value = "state") String state,
                                @RequestParam(required = false,value = "code") String code,
                                HttpServletRequest request,
                                Model model,
                                HttpSession session){

        String snsName="KAKAO";

        String grant_type="authorization_code";
        /*
        * client_id
        * redirect_uri
        * code
        * */
        logger.info("토큰을 받을 주소를 만듭니다.");
        String tokenReqUrl="https://kauth.kakao.com/oauth/token?grant_type="+grant_type+"&client_id="+restapi
                +"&redirect_uri="+mydomainkakao+"&code="+code;

        logger.info("토큰 주소는 : " + tokenReqUrl);

        logger.info("토크을 보내고 받아 옵니다.");

        String data = Utils.getHtml(tokenReqUrl, code);       //access_token을 받아옵니다.
        logger.info("응답바디는 :" + data);
        Map<String,String> map = Utils.JSONStringToMap(data); //JSON의 형태로 받아온 값을 Map으로 저장합니다.

        String accessToken = map.get("access_token");
        String tokenType = map.get("token_type");
        String refresh_Token = map.get("refresh_token");
        String scope = map.get("scope");

        //나중에 로그아웃 하기 위한 토큰저장
        session.setAttribute("accessToken", accessToken);

        String kakaoUserProfileReqUrl="https://kapi.kakao.com/v1/user/me?Authorization="+accessToken;

        logger.info("받아온 토큰으로 사용자 정보 요청 url 생성 : " + kakaoUserProfileReqUrl);

        String userData = Utils.getHtml(kakaoUserProfileReqUrl, tokenType + " " + accessToken);

        logger.info("1.받아온 데이터는 : " + userData);
        model.addAttribute("userData", userData);

        UserSnsVo userkakaoVo    = new Gson().fromJson(userData, UserSnsVo.class );
        logger.info("로그인 유저 카카오 ID : " + userkakaoVo.getId());
        logger.info("로그인 유저 카카오 닉네임 : " + userkakaoVo.getProperties().get("nickname"));

        String snsuserid  = userkakaoVo.getId();
        String snsusername= userkakaoVo.getProperties().get("nickname");
        String email= userkakaoVo.getProperties().get("email");

        if(setAuthentication(request, snsuserid, snsuserid)) {
            logger.info("카카오 강제 로그인 성공 STM으로 테스트 로그인");
            if(SecurityContextHolder.getContext().getAuthentication().isAuthenticated()) {
                return "redirect:" + "/";
            }
        }

        return "redirect:/snsUserJoin?snsName="+snsName+"&userid="+snsuserid+"&snsusername="+snsusername;
    }



    @RequestMapping(value = "oauth/callback")
    public String callback(@RequestParam(required = false,value = "state") String state,
                           @RequestParam(required = false,value = "code") String code,
                           HttpServletRequest request,
                           Model model,
                           HttpSession session) throws UnsupportedEncodingException {
        String snsName="NAVER";

        logger.info("네이버로 부터 callback 이 호출됩니다.");
        logger.info("받은 변수의 값은 state :"+state);
        logger.info("받은 변수의 값은 code :"+code);

        String storedState = (String) request.getSession().getAttribute("state");  //세션에 저장된 토큰을 받아옵니다.

        if (!state.equals(storedState)) {             //세션에 저장된 토큰과 인증을 요청해서 받은 토큰이 일치하는지 검증합니다.
            return "/oauth/callback";
        }
        //AccessToken 요청 및 파싱할 부분
        logger.info("인증이 성공했습니다.");

        //  return "redirect:/";
        model.addAttribute("code", code);
        model.addAttribute("state", state);


        // 2에서 받아온 state와 code를
        // 3 과 util자바를 사용해서 getHtml값을 받아온다.
        String data = Utils.getHtml(getAccessUrl(state, code), null);           //AccessToken을 요청하고 그 값을 가져옵니다.

        Map<String,String> map = Utils.JSONStringToMap(data);               //JSON의 형태로 받아온 값을 Map으로 저장합니다.
        String accessToken = map.get("access_token");
        String tokenType = map.get("token_type");


        logger.info("step03 -- token_type : "+ tokenType);
        logger.info("step04 -- accessToken : "+ accessToken);

        //나중에 로그아웃 하기 위한 토큰저장
        session.setAttribute("accessToken", accessToken);

        // 이제 사용자 정보를 가져온다 - 인증 요청문 명세 xml 형태로 갖고 오게됨.
        // 아래의 형태로 가져오기 때문에 Class 에 선언을 한다.
        // private static final String userProfileUrl = "https://apis.naver.com/nidlogin/nid/getUserProfile.xml";

        // tokentype 와 accessToken을 조합한 값을 해더의 Authorization에 넣어 전송합니다. 결과 값은 xml로 출력됩니다.
        String profileDataXml = Utils.getHtml(userProfileUrl, tokenType + " " + accessToken);

        //xml을 json으로 파싱합니다.
        JSONObject jsonObject =  XML.toJSONObject(profileDataXml);

        //json의 구조가 data 아래에 자식이 둘인 형태여서 map으로 파싱이 안됩니다. 따라서 자식 노드로 접근합니다.
        JSONObject responseData = jsonObject.getJSONObject("data");



        //사용자 정보 값은 자식노드 중에 response에 저장되어 있습니다. response로 접근하여 그 값들은 map으로 파싱합니다.
        Map<String, String> userMap = Utils.JSONStringToMap(responseData.get("response").toString());

        logger.info("step05 -- userMap.size() : "+ userMap.size());

        Set<String> keySet = userMap.keySet();
        Iterator<String> iterator = keySet.iterator();

        while (iterator.hasNext()){
            String key = iterator.next();
            String value = userMap.get(key);
            logger.info("네이버에서 응답온 컬럼값 : " + key);
            logger.info("네이버에서 응답온 결과값 : " + value);
        }

        logger.info(getParam(userMap, "email"));
        logger.info(getParam(userMap, "id"));
        logger.info(getParam(userMap, "nickname"));

        String snsuserid   = getParam(userMap, "id");
        String snsusername = getParam(userMap, "nickname");

        if(setAuthentication(request, snsuserid, snsuserid)) {
            logger.info("카카오 강제 로그인 성공 STM으로 테스트 로그인");
            if (SecurityContextHolder.getContext().getAuthentication().isAuthenticated()) {
                return "redirect:" + "/";
            }
        }

        return "redirect:/snsUserJoin?snsName="+snsName+"&userid="+snsuserid+"&snsusername="+snsusername;
    }


    private String getAccessUrl(String state, String code) {

        String accessUrl = "https://nid.naver.com/oauth2.0/token?client_id=" + clientId + "&client_secret=" + clientSecret
                + "&grant_type=authorization_code" + "&state=" + state + "&code=" + code;
        return accessUrl;
    }

    //로그아웃을 위한 주소생성
    //https://nid.naver.com/oauth2.0/token?grant_type=delete&client_id={클라이언트 아이디}&client_secret={클라이언트 시크릿}&access_token={접근 토큰}&service_provider=NAVER
    private String getLogoutUrl(String access_token){
        String LogoutUrl ="https://nid.naver.com/oauth2.0/token?grant_type=delete&client_id="+ clientId +
                "&client_secret=" + clientSecret +
                "&access_token=" + access_token + "&service_provider=NAVER";
        return LogoutUrl;
    }

    private String getParam(Map<String,String> inMap, String key) {
        String value=null;
        String reval=null;
        Set<String> keySet = inMap.keySet();
        Iterator<String> iterator = keySet.iterator();

        while (iterator.hasNext()) {
            String col = iterator.next();
            value = inMap.get(col);

            if(col.equals(key)){
                reval  = value;
            }

        }
        return reval;
    }

    //네이버 로그아웃 먼저 한 후, 시큐리티도 정리해준다.
    @RequestMapping(value = "oauth/logout")
    public @ResponseBody
    String NaverLogout(HttpSession session,
                       HttpServletRequest request

    ){

        /*
        * 유저가 stm에서 가입했는지 naver, facebook, google인지 구분해서 처리한다.
        *
        * */

        logger.info("네이버 로그아웃 요청");
        String Token = (String) request.getSession().getAttribute("accessToken");
        logger.info("토큰값은 : " + Token);

        String Url = getLogoutUrl(Token);
        logger.info("로그아웃 요청 값은 : " + Url);
        //만든 주소와 토큰을 네이버에 보낸다. 그러면 json형태로 파일이 온다.
        String data =  Utils.getHtml(Url, null);

        Map<String,String> map = Utils.JSONStringToMap(data);               //JSON의 형태로 받아온 값을 Map으로 저장합니다.

        //네이버에 명시된 access_token과 result가 온다
        String accessToken = map.get("access_token");
        String result = map.get("result");

        logger.info("1.ata  : " + data);
        logger.info("2.accessToken  : " + accessToken);
        logger.info("3.result  : " + result);

        return result; //결과를 비동기로 웹페이지에 보낸다.
    }


    @RequestMapping(value = "oauth/callback/daum")
    public String callbackDaum(@RequestParam(required = false,value = "state") String state,
                               @RequestParam(required = false,value = "code") String code,
                               HttpServletRequest request,
                               Model model,
                               HttpSession session){

        logger.info("다음 부터 응답이 왔습니다.");
        logger.info("다음 부터 callback 이 호출됩니다.");


        return "/oauth/callback";
    }

/* 세션을 끈기...
@RequestMapping(value = "/account/facebook-logout", method = RequestMethod.GET)
public String logoutFacebook(HttpServletRequest request, Model model) {

	SecurityContextHolder.clearContext();
	HttpSession session = request.getSession(false);
	if (session != null) {
		session.invalidate();
	}
	return "index";
}
 */

}
