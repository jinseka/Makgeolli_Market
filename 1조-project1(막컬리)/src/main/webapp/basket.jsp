<%@page import="java.util.ArrayList"%>
<%@page import="basket.BasketDAO"%>
<%@page import="basket.BasketDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- icon Style -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous">
    <!-- swiper Style -->
    <link rel="stylesheet"href="https://unpkg.com/swiper/swiper-bundle.min.css"/>
    <!-- common Style -->
    <link rel="stylesheet" href="css/style.css">
    <!-- jquery CDN -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <title>막컬리::매일매일 신선한 장보기</title>
</head>
<body>
	
    <div id="wrap">
    	<!-- header 건들지마시오 -->
        <jsp:include page="header.jsp"></jsp:include>
        <div id="contents">
        <div class="container">
        	
        
        
        
       
	        <!-- 이곳 안으로 편집해주시면 됩니다. 가운데 정렬은 class="container"걸어주시면 자동으로 걸립니다. -->
        	<%
				BasketDAO dao = new BasketDAO();
				
				if( null != request.getParameter("id") ){ // 넘어온 상품이 있을때 저장
					String id = request.getParameter("id"); // 상품번호
				    String count =request.getParameter("count"); // 개수
				    String productPrice= request.getParameter("price");
				    int pp2=Integer.parseInt(productPrice);
				    int intCount = 0;
				    if(null != count){
				    	intCount = Integer.parseInt(count);
				    }
				    
				  	//가방을 만들어서 테이터를 넣자.
					BasketDTO bag = new BasketDTO();
					bag.setProductId(id);
					bag.setAmount(intCount);
					bag.setProductPrice(pp2);
					bag.setUserId(""); // 
					//bag.setUserId("AAA0001"); // TODO 일단 하드코딩
					
				    
					// 이미 상품이 있는지 확인
					dao = new BasketDAO();
					int itemCnt = dao.basketInUpdChk(bag); //상품 개수 조회
					
					//없으면 insert
					if(0 == itemCnt && 0 != intCount){ // 상품개수가 있을때 inset
						// 상품정보 inset 시작
						dao = new BasketDAO();
						int result = dao.insBasket(bag); // 상품정보 basket에 insert
						
						// 성공 실패 여부 확인용 텍스트 세팅 
						String text = "회원수정 실패했습니다. 재수정해주세요.";			
						if(result == 1){
							text = "회원수정 성공했습니다. 축하드립니다";
						}
					}else if(0 < itemCnt){
						//있으면 update
						// 조회한 개수 값이랑 이전화면에서 받아온 개수 값의 합
						bag.setAmount( intCount + itemCnt );
						
						dao = new BasketDAO();
						int result = dao.updBasket(bag); // 상품정보 basket에 insert
						
						String text = "회원수정 실패했습니다. 재수정해주세요.";			
						if(result == 1){
							text = "회원수정 성공했습니다. 축하드립니다";
						}
					}else{
						String text = "insert, update 불필요";
					}
					
					// 데이터 저장_ 끝
				}
				
				//조회_시작
				dao = new BasketDAO();
				
				// 조회 조건 설정
				BasketDTO getBasketLisSrv = new BasketDTO();
				getBasketLisSrv.setUserId("");
				//getBasketLisSrv.setUserId("AAA0001");
					
				// 조회 결과
				ArrayList<BasketDTO> basketList = new ArrayList<BasketDTO>();
				basketList = dao.sltBasketList(getBasketLisSrv); // basket정보 select
				// 조회_끝
				int allTotal = 0;
				if(null == basketList || 0 == basketList.size()){
				%>
					<p class="container">장바구니가 비어 있습니다.</p>
				<%
				}else{
				%>
					<table border="1"  align="center" >
			    	<colgroup>
			        	<col />
			        	<col width="30%"/>
			    	</colgroup>
			    	<thead>
			    		<tr>
			            	<th>상품명</th>
			            	<th>개수</th>
			            	<th>금액</th>
			        	</tr>
			        <%
			        	for(int i = 0 ; i < basketList.size() ; i++){
			        		// 테이블 row 세팅
			        		BasketDTO basketMap = basketList.get(i);
			        		System.out.println(basketMap.getProductName());
			        		int getAmount = basketMap.getAmount();
			        		int getPp = basketMap.getProductPrice();
			        		int total = getAmount * getPp; // 현재 금액
			        		allTotal = allTotal + total; // 장바구니 총 금액
			        %>
				        	<tr>
					            <th><%=basketMap.getProductName()%></th>
					            <th><%=basketMap.getAmount()%></th>
					            <th><%=total%></th>
					        </tr>
			        <%		if(i == basketList.size() -1){
		        	%> 			<tr>
				        			<th colspan="4"></th>
				        		</tr>
				        		<tr>
				        			<th>총 합계</th>
						            <th colspan="2" id="allTotal"><%=allTotal%></th>
						        </tr>
	        		<%
			        		}
			        	}
			        %>
						</thead>
					</table>
					<%
					}
					%>

<!-- 버큰 만들기 -->
	<table>
	
<a href="pay01.jsp?cost=<%=allTotal%>"
		style="background-color: white; font-size: 17px; width: 100px; height: 30px;">결제하기</a>
</table>		
	




<!-- 
 function onClick() { // 버튼 클릭시
	// 결제 DB Insert 결제 Id 생성 해야함
	// 1.결제 테이블에 결제ID, 사용자ID, 상품ID, 개수, 총금액, 납입금액, 납입방멉, 최초결제시간, 납입완료시간
	// 2.장바구니에서 실제 주문한 개수 빼기 update
	// 3.개수가 0인것 delete
	
 }
   -->



 </div>
        </div>
        <!-- footer 건들지마시오 -->
        <jsp:include page="footer.jsp"></jsp:include>
    </div>
</body>
</html>