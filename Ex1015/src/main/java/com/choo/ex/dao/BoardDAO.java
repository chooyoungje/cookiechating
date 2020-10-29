package com.choo.ex.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.choo.ex.dto.BoardDTO;
import com.choo.ex.dto.PageDTO;

@Repository
public class BoardDAO {

	@Autowired
	public SqlSessionTemplate sql;

	
	//전체 글 갯수 
	public int listcount() {
		return sql.selectOne("Board.listcount");
	}

	//시작행 과 끝행을 가지고 글 가져오기
	public List<PageDTO> boardlistpaging(PageDTO pdto) {
		return sql.selectList("Board.boardlistpaging",pdto);
	}
	
	//조회순 정렬
	public List<BoardDTO> boardlistpagingarrange() {
		return sql.selectList("Board.boardlistpagingarrange");
	}

	//글 쓰기
	public int boardwrite(BoardDTO bdto) {
		return sql.insert("Board.boardwrite", bdto);
	}

	//글 상세 보기
	public BoardDTO boardview(int bnum) {
		return sql.selectOne("Board.boardview", bnum);
	}

	//조회수 증가
	public void bhit(int bnum) {
		sql.update("Board.bhits", bnum);
	}

	//글 삭제
	public int boarddelete(int bnumber) {
		return sql.delete("Board.boarddelete", bnumber);
	}

	//글 수정
	public BoardDTO boardupdate(int bnumber) {
		return sql.selectOne("Board.boardupdate",bnumber);
	}
	
	//글 수정 프로세스
	public int boardupdatep(BoardDTO bdto) {
		return sql.update("Board.boardupdatep", bdto);
	}

	//검색
	public List<BoardDTO> boardsearch(String searchtype, String keyword) {
		Map<String,String> searchmap = new HashMap<String,String>();
		searchmap.put("searchtype", searchtype);
		searchmap.put("keyword",keyword );
		return sql.selectList("Board.boardsearch",searchmap);
	}
	
	public List<BoardDTO> boardview2(String mid) {
		return sql.selectList("Board.boardview2",mid);
	}

	//내가쓴 글 갯수
	public int myboardcount(String mid) {
		return sql.selectOne("Board.myboardcount", mid);
	}

	public List<BoardDTO> myboardlist(String bwriter) {
		return sql.selectList("Board.myboardlist",bwriter);
	}

	
	
	
}
