package com.bbbox.member.model.service;

import java.sql.Connection;

import com.bbbox.common.JDBCTemplate;
import com.bbbox.lawyer.model.vo.LawAttachment;
import com.bbbox.lawyer.model.vo.Lawyer;
import com.bbbox.member.model.dao.MemberDao;
import com.bbbox.member.model.vo.Member;

public class MemberService {
	
	//회원 로그인 메소드	
	public Member loginMember(String userId, String userPwd) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		Member loginUser = new MemberDao().loginMember(conn, userId, userPwd);
		
		JDBCTemplate.close(conn);
		
		return loginUser;
	}
	
	//회원가입 메소드 
	public int insertMember(Member insertMember) {

		Connection conn = JDBCTemplate.getConnection();
		
		int result = new MemberDao().insertMember(conn, insertMember);
		
		if(result>0) {
			JDBCTemplate.commit(conn);
			
		}else {
			JDBCTemplate.rollback(conn);
		}
		
		JDBCTemplate.close(conn);
		
		return result;
	}
	
	//아이디 중복확인
	public int MemberIdCheck(String checkId) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		int count = new MemberDao().MemberIdCheck(conn, checkId);
		
		JDBCTemplate.close(conn);
		
		return count;
	}
	
	//이메일 중복 확인
	public Member selectEmail(String testEmail) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		Member m = new MemberDao().selectEmail(conn, testEmail);
		
		JDBCTemplate.close(conn);
		
		return m;
	}

	
	//회원정보 수정 메소드
	public int updateMember(Member m) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		int result = new MemberDao().updateMember(conn, m);
		
		if(result>0) {
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);
		}
		
		JDBCTemplate.close(conn);
		return result;
	}

	public int updatePwd(String email, String tempPwd) {
		Connection conn = JDBCTemplate.getConnection();
		
		int result = new MemberDao().updatePwd(conn, email, tempPwd);
		
		if(result>0) {
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);
		}
		
		JDBCTemplate.close(conn);
	
		return result;
	}

	//변호사 회원 신청 
	public int ApplyLawyar(LawAttachment lat, Lawyer applyla) {

		Connection conn = JDBCTemplate.getConnection();
		//사진 등록 결과 
		int result1 = new MemberDao().insertProfile(conn,lat);
		
		//신청결과 
		int result2 = new MemberDao().insertApply(conn, applyla);
		
		//신청 유저의 lawyer 상태값 변경
		int result3 = new MemberDao().updateLawyerGrant(conn, applyla);
		
		
		if(result1*result2*result3>0) {
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);
		}
		
		return result1*result2*result3;
	}

	public String selectLawyerGrant(int userNo) {
		Connection conn = JDBCTemplate.getConnection();
		
		String lawyer = new MemberDao().selectLawyerGrant(conn,userNo);
		
		JDBCTemplate.close(conn);
		
		return lawyer;
	}

}
