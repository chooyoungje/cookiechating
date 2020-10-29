package com.choo.ex.dto;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class PageDTO {
	
	private int page;
	private int maxpage;
	private int endpage;
	private int startpage;
	private int startrow;
	private int endrow;
	
	
}
