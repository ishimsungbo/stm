package com.jui.stm.test;

import com.jui.stm.controller.CommonController;
import com.jui.stm.dao.BoardDao;
import com.jui.stm.dao.TestDao;
import com.jui.stm.dao.UserDao;
import com.jui.stm.dto.FindUserDto;
import com.jui.stm.dto.PagingDTO;
import com.jui.stm.vo.Board;
import com.jui.stm.vo.TestTableVo;
import org.apache.commons.lang.StringUtils;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.CookieClearingLogoutHandler;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.security.web.authentication.rememberme.AbstractRememberMeServices;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * Created by sungbo on 2015-10-21.
 */
@Controller
public class TestController {


    private static final Logger logger = LoggerFactory.getLogger(CommonController.class);

    @Autowired
    private SqlSession sqlSession;

    @Autowired
    private SqlSessionFactory factory;

    @RequestMapping("yoyo")
    public String yutobe(Model model){

        TestDao testDao =  sqlSession.getMapper(TestDao.class);


        TestTableVo testTableVo = new TestTableVo();
        testTableVo.setId(1);
        model.addAttribute("youaddresstag", testDao.selectone(testTableVo));

        return "/test/yutobe";
    }


    @RequestMapping("test/pagenation.ok")
    public String pagingTest(@ModelAttribute("pagingDTO") PagingDTO pagingDTO
                           , Model model
                           , @RequestParam(value = "pageNo", required = false) String pageNo
                            ){

        System.out.println("페이징 테스트 시작");
        BoardDao boardDao = sqlSession.getMapper(BoardDao.class);

        pagingDTO.setPageSize(10); // 한 페이지에 보일 게시글 수
        pagingDTO.setPageNo(1); // 현재 페이지 번호


        if(StringUtils.isNotEmpty(pageNo)){
            pagingDTO.setPageNo(Integer.parseInt(pageNo));
        }

        pagingDTO.setBlockSize(10);

        pagingDTO.setTotalCount(boardDao.getBoardCount()); // 게시물 총 개수  -- 디비에서 총 갯수 카운트 이때 모든 페이징이 계산이됨
        List<Board> boardList = boardDao.getBoardList(pagingDTO);

        System.out.println("총 게시물 수는 : "+ pagingDTO.getTotalCount());
        System.out.println("시작값 : "+ pagingDTO.getStartRowNum());
        System.out.println("종료값 : "+ pagingDTO.getEndRowNum());
        System.out.println("화면의 보여지는 게시물수는 : "+ boardList.size());

        model.addAttribute("paging", pagingDTO);
        model.addAttribute("boardList", boardList);

        return "/test/pagenation";
    }

    @RequestMapping("test/template")
    public String HtmlTemplate(){

        return "/test/templage";
    }
    @RequestMapping("test/Boxmodel")
    public String HtmlBoxmodel(){
        String userSiteflag=null;
        logger.info("User Dao 생성");
        UserDao userDao = sqlSession.getMapper(UserDao.class);
        FindUserDto findUserDto = new FindUserDto();
        findUserDto.setEmail("stm@naver.com");
        findUserDto.setUserid("stm");
        logger.info("User Dao 유저있는지 없는지 쿼리 실행");

        if(userDao.getSnsUser("stm@naver.com","stm")==0){
            userSiteflag = "first";
            logger.info("처음");
        }else{
            userSiteflag = "member";
            logger.info("멤버");
        }

        logger.info("종료");

        return "/test/Boxmodel";
    }

    @RequestMapping("test/pdfdownload")
    public ModelAndView pdfTest(){
        return new ModelAndView("/test/pdfdownload");
    }

    @RequestMapping(value = "/downloadPDF", method = RequestMethod.GET)
    public ModelAndView downloadExcel(){

        System.out.println("PDF 시작");


        return new ModelAndView("/pdfView");
    }

    @RequestMapping("test/canvars")
    public String canvars(){
        return "/test/canvars";
    }


    @RequestMapping("test/img")
    public String img(){
        return "/test/img";
    }

    @RequestMapping("test/imgmovetest")
    public String imgmovetest(){

        return "/test/imgmovetest";
    }

    @RequestMapping("test/imgTest01")
    public String imgTest01(){

        return "/test/imgTest01";
    }

    @RequestMapping("daummap")
    public String daummap(){

        return "/test/daummap";
    }

    @RequestMapping("naver")
    public String naver(HttpServletRequest request){
        //네이버 로그인 메인
        System.out.println("온요청은 + "+ request.getParameter("state"));
        return "/test/naver";
    }

    //강제로그아웃을 테스트 하기위한 것.   <a href="/test/outtest">강제아웃</a>
    @RequestMapping("test/outtest")
    public String Testout(HttpSession session,
                          HttpServletRequest request,
                          HttpServletResponse response){

        logger.info("로그아웃 시작합니다.");

        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        SecurityContextLogoutHandler securityContextLogoutHandler = new SecurityContextLogoutHandler();

        securityContextLogoutHandler.logout(request, response, auth);

        new CookieClearingLogoutHandler(AbstractRememberMeServices.SPRING_SECURITY_REMEMBER_ME_COOKIE_KEY)
                .logout(request, response, null);

        logger.info("로그아웃 종료합니다.");
        return "redirect:/?logout";
    }

    @RequestMapping("test/drawing")
    public String drawIng(){

        return "/test/drawing";
    }

}
