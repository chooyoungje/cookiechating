package com.choo.ex.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.choo.ex.dao.ReplyDAO;
import com.choo.ex.dto.ReplyDTO;

@Service
public class ReplyService {

	@Autowired
	public ReplyDAO rdao;
	
	public ModelAndView mav;
	//댓글 작성
	public List<ReplyDTO> replywrite(ReplyDTO rdto) {
		int bnum=rdto.getCbnumber();
		List<ReplyDTO> rlist =rdao.replylist(bnum);
		return rlist;
	}
	
	//댓글 삭제
	public List<ReplyDTO> replydelete(ReplyDTO rdto) {
		int cbnumber =rdto.getCbnumber(); 
		List<ReplyDTO> rlist =rdao.replylist(cbnumber);
		return rlist;
	}

}
