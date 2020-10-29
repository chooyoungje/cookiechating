package com.choo.ex.service;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.choo.ex.dao.MemberDAO;
import com.choo.ex.dto.MemberDTO;
import com.choo.ex.dto.PageDTO;
import com.fasterxml.jackson.databind.JsonNode;

@Service
public class MemberService {

	@Autowired
	public MemberDAO mdao;
	
	public ModelAndView mav;
	
	
	@Autowired
	public HttpSession session;

	//아이디 중복확인
	public String idcheck(String mid) {
		String result = mdao.idcheck(mid);
		String resultmsg = null;
		if(result == null)
			{resultmsg="ok";
			}
		else
			{resultmsg="no";
			}
		return resultmsg;
	}

	//회원가입
	public ModelAndView memberjoingo(MemberDTO mdto) throws IllegalStateException, IOException {
		mav = new ModelAndView();
		MultipartFile mphoto = mdto.getMphoto();
		String mphotoname = mphoto.getOriginalFilename();
		String savepath ="C:\\Users\\1\\git\\memberboard1016\\"
				+ "Ex1015\\src\\main\\webapp\\resources\\mphoto"+mphotoname;
		if(!mphoto.isEmpty())
			{mphoto.transferTo(new File(savepath));
			}
		mdto.setMphotoname(mphotoname);
		int result = mdao.memberjoin(mdto);
		if(result==1)
			{mav.setViewName("memberv/memberlogin");
			}
		else
			{mav.setViewName("memberv/memberloginfail");
			}
		return mav;
	}

	//로그인
	public ModelAndView memberlogin(MemberDTO mdto) {
		String loginid = mdao.memberlogin(mdto);
		mav = new ModelAndView();
		if(loginid!=null)
			{mav.setViewName("redirect:/boardlistpaging");
			 session.setAttribute("loginid",loginid);
			}
		else
			{mav.setViewName("memberv/memberloginfail");
			}
		return mav;
	}

	private static final int PAGE_LIMIT = 4;  //한 페이지에 글 3개 보임
	private static final int BLOCK_LIMIT = 5; //목록에는 5개의 페이지가 보임
	//회원목록
	public ModelAndView memberlistpaging(int page) {
		mav = new ModelAndView();
		int listcount = mdao.listcount();
		int startrow =(page-1)*PAGE_LIMIT+1;	// 1 4 7 10 
		int endrow = page*PAGE_LIMIT;		// 3 6 9 12
		PageDTO pdto = new PageDTO();
		pdto.setStartrow(startrow);
		pdto.setEndrow(endrow);
		List<PageDTO> bplist = mdao.memberlistpaging(pdto);
		int startpage =(((int)(Math.ceil((double)page/BLOCK_LIMIT)))-1)*BLOCK_LIMIT+1;  //1 6  11 16
		int maxpage =(int)(Math.ceil((double)listcount/PAGE_LIMIT));					//5 10 15 20
		int endpage = startpage + BLOCK_LIMIT -1;
		if(endpage>maxpage) 
			{endpage=maxpage;
			}
		pdto.setPage(page);
		pdto.setStartpage(startpage);
		pdto.setEndpage(endpage);
		pdto.setMaxpage(maxpage);
		mav.addObject("paging" , pdto);
		mav.addObject("memberlist" , bplist);
		mav.setViewName("memberv/memberlistpaging");
		return mav;
	}
	
	
	//회원상세조회
		public ModelAndView memberview(String mid) {
			MemberDTO mdto = mdao.memberview(mid);
			mav = new ModelAndView();
			mav.setViewName("memberv/memberview");
			mav.addObject("mdto",mdto);
			return mav;
		}

		//회원삭제
		public ModelAndView memebrdelete(String mid) {
			int result =mdao.memebrdelete(mid);
			mav = new ModelAndView();
			if(result>0)
				{mav.setViewName("redirect:/memberlistpaging");
				}
			return mav;
		}
		
		
		
		//회원수정(select)
		public ModelAndView memberupdate(String mid) {
			MemberDTO mdto = mdao.memberview(mid);
			mav = new ModelAndView();
			mav.addObject("mdto",mdto);
			mav.setViewName("memberv/memberupdate");
			return mav;
		}

		//회원수정(update)
		public ModelAndView memberupdatego(MemberDTO mdto) throws IllegalStateException, IOException {
			mav = new ModelAndView();
			MultipartFile mphoto = mdto.getMphoto();
			String mphotoname = mphoto.getOriginalFilename();
			String savepath ="C:\\Users\\1\\git\\memberboard1016\\Ex1015\\src\\main\\webapp"
					+ "\\resources\\img"+mphotoname;
			if(!mphoto.isEmpty())
				{mphoto.transferTo(new File(savepath));
				}
			mdto.setMphotoname(mphotoname);
			String mid = mdto.getMid();
			int result = mdao.memberupdatego(mdto);
			if(result==1)
				{mav.setViewName("redirect:/mypage?mid="+mid);
				}
			else
				{mav.setViewName("memberv/memberloginfail");
				}
			return mav;
		}
	
		public ModelAndView naverlogin(String profile) throws ParseException {
			mav = new ModelAndView();
			JSONParser parser = new JSONParser();
			
			Object obj = parser.parse(profile);
			
			JSONObject naveruser = (JSONObject)obj;
			JSONObject userinfo =(JSONObject)naveruser.get("response");
			String naverid =(String) userinfo.get("id");
			String loginid = mdao.naverlogin(naverid);
			
			session.setAttribute("loginid", loginid);
			mav.setViewName("redirect:/boardlistpaging");
			return mav;
		}

		public ModelAndView kakaologin(JsonNode profile) {
			mav = new ModelAndView();
			String kakaoid = profile.get("id").asText();
			String loginid = mdao.kakaologin(kakaoid);
			
			session.setAttribute("loginid", loginid);
			mav.setViewName("redirect:/boardlistpaging");
			return mav;
		}
	
	
	
	
}
