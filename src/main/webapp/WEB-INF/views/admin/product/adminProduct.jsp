<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<link rel="icon" type="image/png"  href="/resources/images/favicon.ico"/>
<link rel="stylesheet" href="../resources/css/admin/button.css"/>
<meta charset="UTF-8">
<title>상품 관리</title>
<!-- 타이틀 밑에 아래 css링크 추가해줄것 -->
<link rel="stylesheet" href="/resources/css/main/mainHeader.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
	<jsp:include page="../../admin/adminHeader.jsp"></jsp:include>
	<div class="main-contents">
		<div>
						<jsp:include page="../../admin/adminSideBar.jsp"></jsp:include>
		</div>
		<div class="main-section">
			<div class="container col-lg-8"> 
			<!-- 이 안에서 작업! 여기가 본문-->
			<h1>상품 관리</h1>
			<h2>${msg }</h2>
			<table class="table table-hover">
				<thead>
					<tr bgcolor="#AA7139" style="color:white">
						<th><input type="checkbox" id="cbx_chkAll"></th>
						<th>상품번호</th>
						<th>책 제목</th>
						<th>저자</th>
						<th>출판사</th>
						<th>수정</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${bookList }" var="bookList" varStatus="i">
					<tr>
						<td><input type="checkbox" name="chBox"></td>
						<td>${bookList.bookNo }</td>
						<td>
							<a href="/book/detailView.kh?bookNo=${bookList.bookNo }">
								<c:choose>
									<c:when test="${fn:length(bookList.bookTitle) gt 25 }">
										<c:out value="${fn:substring(bookList.bookTitle, 0, 22) }...">
										</c:out></c:when>
								<c:otherwise>
									<c:out value="${bookList.bookTitle }">
								</c:out></c:otherwise>
								</c:choose>
							</a>
						</td>
						<td>
							<c:choose>
								<c:when test="${fn:length(bookList.bookWriter) gt 15 }">
									<c:out value="${fn:substring(bookList.bookWriter, 0, 12) }...">
								</c:out></c:when>
								<c:otherwise>
									<c:out value="${bookList.bookWriter }">
								</c:out></c:otherwise>
							</c:choose>
						</td>
						<td>${bookList.publisher }</td>
						<td>
							<span class="btn-section2">
								<button class="btn" type="button" onclick="modifyBook(${bookList.bookNo})">수정하기</button>
							</span>
						</td>
					</tr>
					</c:forEach>
					<tr align="center">
						<td colspan="6">
						<form class="col-12 search mb-3 mb-lg-auto me-lg-auto center"
							role="search" action="/admin/searchProduct" method="get">
							<div class="input-group">
								<select name="searchCondition" class="input-group-text" id="inputGroup-sizing-sm">
									<option value="all" <c:if test="${searchCondition eq 'all' }">selected</c:if>>전체</option>
									<option value="writer" <c:if test="${searchCondition eq 'writer' }">selected</c:if>>작가</option>
									<option value="title" <c:if test="${searchCondition eq 'title' }">selected</c:if>>제목</option>
									<option value="contents" <c:if test="${searchCondition eq 'contents' }">selected</c:if>>내용</option>
								</select>
								<input type="search" class="form-control" name="searchValue" value="${searchValue }"
									placeholder="도서 검색" aria-label="Search" />
							</div>
						</form>
						</td>
					</tr>
					<tr align="center" height="20">
			            <td colspan="6">
			                <c:if test="${currentPage != 1}">
			                    <a href="/admin/${urlVal }?page=${currentPage - 1 }">
			                    <button class="btn btn-outline-dark">이전</button>
			                    </a>
			                </c:if>
			                <c:if test="${currentPage == 1}">
			                    <button class="btn btn-outline-dark disabled">이전</button>
			                </c:if>
			                <c:forEach var="p" begin = "${startNavi }" end="${endNavi }">
			                    <c:if test="${currentPage eq p }">
			                       <button class="btn btn-dark">${p}</button>  
			                    </c:if>
			                    <c:if test="${currentPage ne p }">
			                        <a href = "/admin/${urlVal }?page=${p }&searchCondition=${searchCondition }&searchValue=${searchValue }">
			                        <button class="btn btn-outline-dark">${p}</button>
			                        </a>
			                    </c:if>
			                </c:forEach>
			            	<c:if test = "${currentPage < maxPage }">
			                	<a href = "/admin/${urlVal}?page=${currentPage + 1}">
			                	<button class="btn btn-outline-dark">
			                		다음
			                	</button>
			                	</a>
			            	</c:if>
			            	<c:if test = "${currentPage == maxPage }">
			                	<button class="btn btn-outline-dark disalbed">
			                		다음
			                	</button>
			            	</c:if>
			            </td>
		        	</tr>
				</tbody>
			</table>
			<div class="btn-section2" style="text-align:center">
				<button id="delBtn" class="btn">상품 삭제</button>
			</div>


			</div>
		<footer> 
							<jsp:include page="../../../views/main/footer.jsp"></jsp:include>
		</footer>
		</div>
		
	<script>
	$(document).ready(function() {
		$("#cbx_chkAll").click(function() {
			if($("#cbx_chkAll").is(":checked")) $("input[name=chBox]").prop("checked", true);
			else $("input[name=chBox]").prop("checked", false);
		});
		
		$("input[name=chBox]").click(function() {
			var total = $("input[name=chBox]").length;
			var checked = $("input[name=chBox]:checked").length;
			
			if(total != checked) $("#cbx_chkAll").prop("checked", false);
			else $("#cbx_chkAll").prop("checked", true); 
		});
	});
	
	$("#delBtn").click(function(){
		var bookNoArray = [];
		$("input[name=chBox]:checked").each(function(){
			bookNoArray.push($(this).parent().next().html());
		})
		$.ajax({
			url : "/admin/deleteProduct",
			data : {"bookNoArray" : bookNoArray},
			type : "post",
			success : function(result){
				alert("총 " + result + " 권이 삭제되었습니다.");
			},
			error : function(result){
				alert("에러 발생");
			}
		});
	});
	
	let msg = "${msg}";
	
	function newBook(){
		location.href = "/admin/admin-productForm";
	}
	
	function modifyBook(bookNo){
		location.href = "/admin/admin-productModifyForm?bookNo="+bookNo;
	}
	
	if(msg != ''){
		alert(msg);
		location.href='/admin/admin-product';
	}
	

	</script>
</body>
</html>