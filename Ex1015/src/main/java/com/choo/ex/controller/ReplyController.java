package com.choo.ex.controller;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.choo.ex.dto.ReplyDTO;
import com.choo.ex.service.ReplyService;

@Controller 
public class ReplyController {

	@Autowired
	public ReplyService rsvc;
	
	public ModelAndView mav;
	
	//댓글 쓰기
	@RequestMapping(value="/replywrite")
	public @ResponseBody List<ReplyDTO> replywrite(@ModelAttribute ReplyDTO rdto) {
		List<ReplyDTO> rlist= rsvc.replywrite(rdto);
		return rlist;
	}
	
	//댓글 삭제
	@RequestMapping(value="/replydelete")
	public @ResponseBody List<ReplyDTO> replydelete
		(@ModelAttribute ReplyDTO rdto) {
		List<ReplyDTO> rlist= rsvc.replydelete(rdto);
		return rlist;
	}
}
