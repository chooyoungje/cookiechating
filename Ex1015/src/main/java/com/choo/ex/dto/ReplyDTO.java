package com.choo.ex.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class ReplyDTO {

	private int cnumber;
	private int cbnumber;
	private String reply;
	private String replyer;
	private String rdate;
	
}
