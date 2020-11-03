package com.choo.ex.controller;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.WebApplicationContext;

import lombok.extern.slf4j.Slf4j;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations =
{"file:src/main/webapp/WEB-INF/spring/**/*.xml"})
@Slf4j
public class BoardControllerTest {

	@Autowired
	private WebApplicationContext wac;
	
	private MockMvc mock;
	
	
	//테스트 하기전에 세팅하는 부분
	@Before
	public void setup() {
		System.out.println("setup메소드 호출");
		this.mock =MockMvcBuilders.webAppContextSetup(wac).build(); //가상의 환경을 만들어 줌
	}
	
	
	//메인
	@Test
	@Transactional   //실제 db에 들어가게끔
	@Rollback(false) //실행한 후 취소 할지 여부
	public void boardwritetest() throws Exception {
		System.out.println("글쓰기 테스트 호출");
		log.info("글쓰기 테스트");
		log.info(mock.perform(MockMvcRequestBuilders.post("/boardwrite") //태스트 하고자 하는 컨트롤러 주소 값
			.param("bwriter","testwriter")
			.param("bpassword","testpassword")
			.param("btitle","testtitle")
			.param("bcontents","testcontents"))
			.andReturn().getModelAndView().getViewName());
		System.out.println("글쓰기 테스트 호출 종료");
	}
}






