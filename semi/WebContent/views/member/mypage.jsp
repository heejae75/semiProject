<%@page import="java.awt.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "java.util.ArrayList, com.bbbox.lawyer.model.vo.*,
    								com.bbbox.board.model.vo.*" %>
<%
	ArrayList <Lawyer> lawList = (ArrayList <Lawyer>)request.getAttribute("lawList");
	
	ArrayList <Board> boardList = (ArrayList <Board>)request.getAttribute("boardList");
	
	ArrayList <Reply> replyList = (ArrayList <Reply>)request.getAttribute("replyList");
	
	ArrayList <Counsel> cList = (ArrayList<Counsel>)request.getAttribute("cList");
	
	ArrayList <LawReview> lawRev = (ArrayList<LawReview>)request.getAttribute("lawRev");
	
%>  
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My page</title>

<!-- font-awesome Copy Link Tag (아이콘 CDN) -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />

<style>
    .content{
        width: 800px;
        box-sizing: border-box;
        margin : auto;
        margin-top: 20px;
    }
    #info, table{
        width: 100%;
    }
    #List{
        background-color: rgb(223, 220, 220);
    }
    a{
        text-decoration: none;
        color: black;
        display: block;
    }
    
    #counsel-list a{
    	width : 50%;
    	float : left;
    }
    
    #review-btn{
    	margin-left: 10px;
    }
    a:hover +{
        cursor: pointer;
        
    }
</style>
</head>
<body>
<%@ include file = "../common/header.jsp" %>

<div class="content">
    <h2 align="center">마이페이지</h2>
    <h4>기본정보</h4>
    <hr>
    <!-- 기본정보 뷰 -->
        <table id="info">
            <tr>
                <td width="150">아이디 </td>
                <td width="200"><%=loginUser.getUserId()%></td>
                <td></td>
            </tr>
            <tr>
                <td>이름 </td>
                <td><%=loginUser.getUserName()%></td>
                <td></td>
            </tr>
            <tr>
                <td>email </td>
                <td><%=loginUser.getEmail()%></td>
                <td></td>
            </tr>
            <tr>
                <td>회원타입 </td>
            <%if(loginUser.getLawyer().equals("N")){ %>
	            <td>일반회원</td>
               	<td><button id="applyLawyer" onclick = "return apply();">변호사회원 신청하기</button></td>
             <%}else{%>
	         	<td>변호사회원</td>   
	         <%} %>	
            </tr>
        </table>
        <br>
    <!-- 버튼 -->
    <div id="btn" align="center">
        <button onclick = "main();">메인으로</button>
        <button onclick = "modify();">수정하기</button>
    </div>
    <hr>
    <%if(loginUser.getLawyer().equals("N")){ %>
    <!-- 찜한리스트 뷰 -->
    <h3>내가 찜한 변호사</h3>
    <hr>
        <table id="dibs-lawyer">
            <thead id="List">
                <tr>
                    <td width="50">No.</td>
                    <td width="300">변호사</td>
                    <td width="100"></td>
                </tr>
            </thead>
            <!-- 찜한 변호사 리스트가 비어있지 않다면 -->
            <% if (!lawList.isEmpty()){ %>
	            <% for(int i =0; i<lawList.size() ;i++){ %>
	            <tr>
	                <td><a href="<%=contextPath %>/detail.la?lno=<%=lawList.get(i).getLawNo()%>"><%= i+1 %></a></td>
	                <td><a href="<%=contextPath %>/detail.la?lno=<%=lawList.get(i).getLawNo()%>"><%= lawList.get(i).getRefUno()%></a></td>
	                <td id="heart"><i id="solidHeart" class="fa-sharp fa-solid fa-heart fa-lg" style="color: #ff0000;"></i></td>
	            </tr>
	            <%} %>
	        <!-- 찜한 변호사 리스트가 비어있다면  -->    
	       <%}else{ %>
	       		<tr>
	       			<td></td>
	       			<td> 찜한 변호사가 없습니다</td>
	       			<td></td>
	       		</tr>
	       <%} %>     
        </table>
        <%} %>
    <hr>
    <h3>내 게시글 관리 </h3>
    <hr>
    	<table>
            <thead id="List">
                <tr>
                    <td width="50">No.</td>
                    <td width="230">게시글 제목 </td>
                    <td width="70">작성 게시판</td>
                    <td width="100">작성 날짜</td>
                </tr>
            </thead>
            <!-- 게시글 리스트가 비어있지 않다면  -->
            <% if(!boardList.isEmpty()){%>
	           	<%for(int i=0; i<boardList.size(); i++){ %>
	            <tr>
	                <td><a href="<%=contextPath%>/detail.bo?bno=<%=boardList.get(i).getBoardNo()%>"><%=i+1 %></a></td>
	                <td><a href="<%=contextPath%>/detail.bo?bno=<%=boardList.get(i).getBoardNo()%>"><%=boardList.get(i).getTitle()%></a></td>
	                <%if(boardList.get(i).getCategoryName().equals("해결")){ %>
	               	 	<td><%=boardList.get(i).getCategoryName()%> <button id="review-btn">리뷰작성</button></td>
	                <%}else{ %>
	                <td><%=boardList.get(i).getCategoryName()%></td>
	                <%} %>
	                <td><%= boardList.get(i).getCreateDate()%></td>
	            </tr>
				<%} %>
			<!-- 게시글 리스트가 비어있다면  -->	
			<%}else{%>
				<tr>
	       			<td></td>
	       			<td> 조회된 게시글이 없습니다. </td>
	       			<td></td>
	       			<td></td>
	       		</tr>
			<%} %>
        </table>
    <h3>내 댓글 관리</h3>
    <hr>
    	<table>
            <thead id="List">
                <tr>
                    <td width="50">No.</td>
                    <td width="230">댓글 내용</td>
                    <td width="70">작성 게시판</td>
                    <td width="100">작성 날짜</td>
                </tr>
            </thead>
             <!-- 댓글 리스트가 비어있지 않다면  -->
            <% if(!replyList.isEmpty()){%> 
				<%for(int i = 0 ; i<replyList.size() ; i++){%>
	            <tr>
	                <td><a href="<%=contextPath%>/detail.bo?bno=<%=replyList.get(i).getRefBno()%>"><%=i+1 %></a></td>
	                <td><a href="<%=contextPath%>/detail.bo?bno=<%=replyList.get(i).getRefBno()%>"><%=replyList.get(i).getContent()%></a></td>
					<td><%= replyList.get(i).getCategoryName()%></td>               
	                <td><%= replyList.get(i).getCreateDate()%></td>
	            </tr>
	            <%} %>
	         <!-- 댓글 리스트가 비어있다면  -->   
	        <%}else{ %>
	        	<tr>
	       			<td></td>
	       			<td> 조회된 댓글이 없습니다. </td>
	       			<td></td>
	       			<td></td>
	       		</tr>
	        <%} %>    
        </table>
	    <!-- 상담리스트 뷰 -->
	    <h3>내 상담 내역</h3>
	    <hr>
	        <table id="counsel-list">
	            <thead id="List">
	                <tr>
	                    <td width="50">No.</td>
	                    <td width="200">상담 제목</td>
	                    <td width ="40">상태</td>
	                    <td width="70">상담 일자</td>
	                    <td width="100">수정/삭제</td>
	                </tr>
	            </thead>
	            <% if(!cList.isEmpty()){ %>
	            	<% for(int i = 0 ; i < cList.size() ; i++){ %>
		            <tr>
		                <td><a href=""><%= i+1 %></a></td>
		                <td><a href=""><%= cList.get(i).getCsTitle()%></a></td> 
		                <% if(cList.get(i).getAccept().equals("W")){%>
		                <td><b style = "color : red ">대기중</b></td> <!-- 답변 대기중 넣기  -->
		                <%}else{ %>
		               	<td><b style = "color : green ">답변 완료</b></td> 	
		                <%} %>
		                <td><%= cList.get(i).getCreateDate()%></td>
		                <td><% if(cList.get(i).getAccept().equals("Y")){ %>  <!-- cs_answer이 Y 면 수정하기 버튼 비활성화 시키기  -->
		                	<!-- 답변완료된 경우 상담 내용 수정 불가능 -->
		                	<button disabled>수정</button> <button id="delete1">삭제</button>
		                <%}else{%>
		                <a href="">수정</a> <button id="delete2">삭제</button></td>
		                <%} %>
		            </tr>
		            <%} %>
	            <%}else{ %>
	            	<tr>
	            		<td></td>
	            		<td>상담 내역이 존재하지 않습니다.</td>
	            		<td></td>
	            		<td></td>
	            	</tr>
	            <%} %>
	        </table>
	    <hr>
	    <!-- 리뷰 내역 -->
	    <h3>리뷰</h3>
	   		 <hr>
	         <table>
	            <thead id="List">
	                <tr>
	                    <td width="50">No.</td>
	                    <td width="230">내용</td>
	                    <td width="70">별점</td>
	                    <td width="100">수정/삭제</td>
	                </tr>
	            </thead>
	    <% if(loginUser.getLawyer().equals("Y")){ %>
			<!-- 변호사 회원의 사건 리뷰 위치  -->
			<tr>
				<td><a href=""></a></td> <!-- 누를시에 어디로 이동할지 정하기  -->
		        <td><a href=""></a></td>
		   		<td><a href=""></a></td>
		   		<td><button>수정하기</button> <button>삭제하기</button></td>
				
			</tr>	    
	    <%}else{ %>
				<% if(!lawRev.isEmpty()){%>
					<%for(int i = 0 ; i < lawRev.size() ; i++){ %>
		            <tr>
		                <td><a href=""><%= i+1 %></a></td> <!-- 누를시에 어디로 이동할지 정하기  -->
		                <td><a href=""><%= lawRev.get(i).getReviewContent()%></a></td>
		                <td><a href=""><%= lawRev.get(i).getStar() %></a></td>
		                <td><button>수정</button> <button id = "delete3">삭제</button></td>
		            </tr>
		            <%} %>
	            <%}else{ %>
	            <tr>
	            	<td></td>
	            	<td>조회된 리뷰 내역이 없습니다. </td>
	            	<td></td>
	            	<td></td>
	            </tr>
	            <%} %>
	    <%} %>
	        </table>
	    <br>

    <br><br><br>
</div>

	<script>
		/* 메인페이지 버튼 클릭 함수 script */
		function main(){
			location.href="<%=contextPath%>";
		}
		
		/* 회원정보 수정페이지로 이동 script */
		
		function modify(){
			location.href="<%=contextPath%>/update_info.me";
		}
		
		/* 변호사회원 신청페이지로 이동 */
		function apply(){
			/* 클릭시 이미 신청한 회원이라면, 알림 띄워주기 */
			
			$.ajax({
			 	url : "chkapply.me",
			 	
			 	data : { userNo : <%=loginUser.getUserNo()%>},
			 	
			 	type : "post",
			 	
			 	success : function(result){
			 			console.log(result);
			 			
			 			if(result == 'W'){
			 			 	alert("이미 신청하였습니다.");
			 			 	return false;
			 			}else{
							location.href="<%=contextPath%>/apply_Lawyer.me;"
			 			}
			 	},
			 	
			 	error : function(){
			 		console.log("통신 실패")
			 	}
			}); //ajax 끝
			
		}//함수 끝 

		 
		$('#counsel-list button').on('click',function(){
			if(confirm("삭제한 글은 복구가 불가능 합니다. 정말 삭제하시겠습니까?")){
				//삭제 서블릿으로 위임 
			}
		});
		
		
	</script>
</body>
</html>