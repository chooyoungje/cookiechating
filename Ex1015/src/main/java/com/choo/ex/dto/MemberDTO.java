package com.choo.ex.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class MemberDTO {

	private String mid;
	private String mpassword; 
	private String mname; 
	private String mbirth ;
    private String memail; 
    private String maddress1; 
    private String maddress2; 
    private String maddress3; 
    private String maddress4; 
    private String mphone ;
    private MultipartFile mphoto ;
    private String mphotoname ;
    private String kakaoid ;
    private String naverid ;
	
}
