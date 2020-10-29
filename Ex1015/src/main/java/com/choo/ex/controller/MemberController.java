package com.choo.ex.controller;

import java.io.IOException;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.choo.ex.api.KakaoJoinApi;
import com.choo.ex.api.KakaoLoginApi;
import com.choo.ex.api.NaverJoinApi;
import com.choo.ex.api.NaverLoginApi;
import com.choo.ex.dto.MemberDTO;
import com.choo.ex.service.MemberService;
import com.fasterxml.jackson.databind.JsonNode;
import com.github.scribejava.core.model.OAuth2AccessToken;

@Controller
public class MemberController {

	@Autowired
	public MemberService msvc;
	
	public ModelAndView mav;
	
	@Autowired
	public HttpSession session;
	
	@Autowired
	public NaverJoinApi naverjoinapi;
	
	@Autowired
	public NaverLoginApi naverloginapi;
	
	@Autowired
	public KakaoJoinApi kakaojoinapi;
	
	@Autowired
	public KakaoLoginApi kakaologinapi;
	
	
	//네이버로 회원가입
	@RequestMapping(value="/naverjoin")
	public ModelAndView naverjoin (HttpSession session) {
		String naverurl = naverjoinapi.getAuthorizationUrl(session);
		mav = new ModelAndView();
		mav.addObject("naverurl",naverurl);
		mav.setViewName("naverlogin");
		return mav;
	}
	
	//네이버로 인증 통과 후 처리
	@RequestMapping(value="/naverjoinok")
	public ModelAndView naverjoinok(@RequestParam("code")String code,
			@RequestParam("state") String state,HttpSession session) throws IOException, ParseException {
		mav = new ModelAndView();
		OAuth2AccessToken oauthtoken = naverjoinapi.getAccessToken(session, code, state);
		String profile = naverjoinapi.getUserProfile(oauthtoken);
		JSONParser parser = new JSONParser();
		
		Object obj = parser.parse(profile);
		
		JSONObject naveruser = (JSONObject)obj;
		JSONObject userinfo =(JSONObject)naveruser.get("response");
		String naverid =(String) userinfo.get("id");
		
		mav.addObject("naverid",naverid);
		mav.setViewName("memberv/memberjoin");
		return mav;
		
	}
	
	//네이버로 로그인
	@RequestMapping(value="/naverlogin")
	public ModelAndView naverlogin (HttpSession session) {
		String naverurl = naverjoinapi.getAuthorizationUrl(session);
		mav = new ModelAndView();
		mav.addObject("naverurl",naverurl);
		mav.setViewName("naverlogin");
		return mav;
	}
	
	
	//네이버로 로그인 통과 후 처리
	@RequestMapping(value="/naverloginok")
	public ModelAndView naverloginok(@RequestParam("code")String code,
			@RequestParam("state") String state,HttpSession session) throws IOException, ParseException {
		OAuth2AccessToken oauthtoken = naverjoinapi.getAccessToken(session, code, state);
		String profile = naverjoinapi.getUserProfile(oauthtoken);
		mav = msvc.naverlogin(profile);
		return mav;
	}
	
	//카카오 서버 인증(로그인을 시켜서 회원인지 확인)
		@RequestMapping(value="/kakaojoin")
		public ModelAndView kakaoJoin(HttpSession session) {
			String kakaourl = kakaojoinapi.getAuthorizationUrl(session);
			mav = new ModelAndView();
			mav.addObject("kakaourl",kakaourl);
			mav.setViewName("kakaologin");
			return mav;
		}
		
		
		//카카오 서버 인증 통과 후 처리(우리서버에 카카오 아이디를 가지고 회원가입 하도록 함)
		@RequestMapping(value="/kakaojoinok")
		public ModelAndView kakaoJoinOK(@RequestParam("code") String code,
				HttpSession session) {
			JsonNode token = kakaojoinapi.getAccessToken(code); 
			JsonNode profile=kakaojoinapi.getKakaoUserInfo(token.path("access_token"));
			System.out.println("profile"+profile);
			//profile에 담긴 id값을 가지고 memberjoin.jsp로이동
			String kakaoid = profile.get("id").asText();
			mav = new ModelAndView();
			mav.addObject("kakaoid",kakaoid);
			mav.setViewName("memberjoin");
			return mav;
		}
		
		
		//카카오 서버에서 회원이 맞다고 인증(로그인 창 띄움)
		//token을 발급받았다 :허가 된 사용자
		@RequestMapping(value="/kakaologin")
		public ModelAndView kakaologin(HttpSession session) {
			String kakaourl = kakaologinapi.getAuthorizationUrl(session);
			mav = new ModelAndView();
			mav.addObject("kakaourl",kakaourl);
			mav.setViewName("kakaologin");
			return mav;
		}
		
		//카카오 로그인후 kakaoid로 mid꺼내서 session에 넣어 다님
		@RequestMapping(value="/kakaologinok")
		public ModelAndView kakaologinok(@RequestParam("code") String code) {
			JsonNode token = kakaologinapi.getAccessToken(code); 
			JsonNode profile=kakaologinapi.getKakaoUserInfo(token.path("access_token"));
			mav = msvc.kakaologin(profile);
			return mav;
		}
	
	
	//로그아웃
	@RequestMapping(value="/logout")
	public String logout() {
		session.invalidate();
		return "memberv/memberlogin";
	}
	
	@RequestMapping(value="/echogo")
	public String echogo() {
		session.invalidate();
		return "echo";
	}
	
	
	//회원수정프로세스
	@RequestMapping(value="/memberupdatego")
	public ModelAndView memberupdatego(@ModelAttribute MemberDTO mdto) 
			throws IllegalStateException, IOException {
		mav = msvc.memberupdatego(mdto);
		return mav;
	}
	
	
	//회원수정
	@RequestMapping(value="/memberupdate")
	public @ResponseBody ModelAndView memberupdate
		(@RequestParam("mid") String mid){
		mav = msvc.memberupdate(mid);
		return mav;
	}
	
	//회원삭제
	@RequestMapping(value="/memebrdelete")
	public  ModelAndView memebrdelete
		(@RequestParam("mid") String mid){
		mav = msvc.memebrdelete(mid);
		return mav;
	}
	
	//회원 상세 조회
	@RequestMapping(value="/memberview")
	public ModelAndView memberview(@RequestParam("mid") String mid) {
		mav = msvc.memberview(mid);
		
		return mav;
	}
	
	
	//회원목록
	@RequestMapping(value="/memberlistpaging")
	public ModelAndView memberlistpaging(@RequestParam(value="page",
	required=false,defaultValue="1") int page) {
		mav = msvc.memberlistpaging(page);
		return mav;
	}
	
	

	//로그인
	@RequestMapping(value="/memberlogingo")
	public String memberlogingo(@ModelAttribute MemberDTO mdto,HttpServletResponse response) {
		// 로그인 정보 확인
		mav=msvc.memberlogin(mdto);
		if(mav !=null)
			{Cookie mycookie = new Cookie("userinfo",mdto.getMid());
			 mycookie.setMaxAge(60*60*10);
			 mycookie.setPath("/");
			 response.addCookie(mycookie);
			}
		return "boardv/boardlistpaging";
	}
	
	
	//회원가입
	@RequestMapping(value="/memberjoingo")
	public ModelAndView memberjoingo(@ModelAttribute MemberDTO mdto) 
			throws IllegalStateException, IOException {
		mav = msvc.memberjoingo(mdto);
		return mav;
	}
	        
	
	//아이디 체크
	@RequestMapping(value="/idcheck")
	public @ResponseBody String idcheck(@RequestParam("mid") String mid){
		String result = msvc.idcheck(mid);
		return result;
	}
	
	//홈으로
	@RequestMapping(value="/")
	public String home() {
		return "home";
	}
	//회원가입 창으로
	@RequestMapping(value="/memberjoin")
	public String memberjoin() {
		return "memberv/memberjoin";
	}
	//로그인 창으로
	@RequestMapping(value="/memberlogin")
	public String memberlogin() {
		return "memberv/memberlogin";
	}
}
