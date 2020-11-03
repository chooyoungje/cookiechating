package com.choo.ex.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.choo.ex.dto.ReplyDTO;

@Repository
public class ReplyDAO {

	@Autowired
	public SqlSessionTemplate sql;

	//댓글 작성
	public int replywrite(ReplyDTO rdto) {
		return sql.insert("Reply.replywrite",rdto);
	}

	//댓글 리스트
	public List<ReplyDTO> replylist(int bnum) {
		return sql.selectList("Reply.replylist",bnum);
	}

	//댓글 삭제
	public int replydelete(ReplyDTO rdto) {
		return sql.delete("Reply.replydelete", rdto);
	}
}
