<%@page import="java.util.List"%>
<%@page import="com.catp.product.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.text.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>고양이대통령</title>
    <link rel="stylesheet" href="./css/index.css">
    <link rel="stylesheet" href="./jq/bxslider-4-master/src/css/jquery.bxslider.css">
    <link rel="stylesheet" href="./css/owl.carousel.css">
	<link rel="stylesheet" href="./css/owl.theme.default.css">
	<link rel="stylesheet" href="./css/owl.theme.green.css">
	<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script src="./js/owl.carousel.js"></script>
	<script src="./js/owl.autoplay.js"></script>
	<script src="./js/owl.navigation.js"></script>
    <script src="./js/index.js"></script>
    <script src="./jq/bxslider-4-master/src/js/jquery.bxslider.js"></script>
    <script>
	    $(document).ready(function() {
	        $('.owl-carousel').owlCarousel({
	            items:4, //한번에 보여줄 아이템들의 개수
	            loop:true, //반복유무
	           
	            autoplay:true, // 다음아이템으로의 자동 슬라이드기능 여부
	        });
	    });
	    
	    $(document).ready(function() { 
	        $(".bxslider").bxSlider({
	            auto:true, //일정 시간마다 자동으로 이미지 슬라이드
	            pause:7000, // 자동슬라이드 되기전 이미지를 보여주는 시간 간격(기본 4000ms)
	            speed:500, //이미지가 다음이미지로 바뀌는데 걸리는 시간 (기본 500ms)
	            autoHover:true, // 마우스를 올렸을 경우에는 자동 슬라이드 중지 여부
	
	            touchEnabled: false, //터치슬라이드 사용 유무 (기본값이 true)
	            controls: true // 다음 , 이전 화살표버튼 표시여부 (기본 true)
	        });
	        
	        $(".bxslider").css('z-index', '1');
	    });
    </script>
</head>    

<body>
<jsp:include page="/include/header.jsp"></jsp:include>

	<div id="wrapper">
		<div class="bxslider">
        	<div><a href="#"><img src="./Images/wrapper/wrapper01.jpg"></a></div>
        	<div><a href="#"><img src="./Images/wrapper/wrapper02.jpg"></a></div>
        	<div><a href="#"><img src="./Images/wrapper/wrapper03.jpg"></a></div>
        	<div><a href="#"><img src="./Images/wrapper/wrapper04.jpg"></a></div>
        	<div><a href="#"><img src="./Images/wrapper/wrapper05.jpg"></a></div>
        </div>
   </div>
        
<div id="container">
<%
	ProductDBBean dbPro = ProductDBBean.getInstance();
	NumberFormat nf = NumberFormat.getInstance();
%>
    <div id="content">
    	<div class="best">
        <ul class="best-wrap">
            <li class="wrap-top">
                <span><a href="#">Best</a></span>
            </li>
            <li class="wrap-middle">
<%
	List<ProductDataBean> bestProducts = dbPro.getBestProducts();

	ProductDataBean product = new ProductDataBean();
	for(int i=0; i<bestProducts.size(); i++){
		product = bestProducts.get(i);
%>		
            	<ul>
                    <li><a href="./product/product_read.jsp?id=<%=product.getId() %>"><img src="./Images/product/<%=product.getImg1() %>"/></a></li>
                    <li><span><a href="./product/product_read.jsp?id=<%=product.getId() %>"><%=product.getPname() %></a></span></li>
                    <li><span>￦<%=nf.format(product.getDownPrice()) %></span></li>
                </ul>
<%		
		}
%>
		</ul>
	    </div>
	    
		<ul class="new-wrap">
            <li class="wrap-top">
                <span><a href="#">NEW</a></span>
            </li>
        </ul>
		<div id="wrapper_new">
	     	<div class="owl-carousel owl-theme">
<%	    	
		List<ProductDataBean> newProducts = dbPro.getNewProducts();

		for(int i=0; i<newProducts.size(); i++){
			product = newProducts.get(i);
%>
	                <figure class="new_products">
				        <img src="./Images/product/<%=product.getImg1() %>"/>
				        <figcaption>
				        <h5><%=product.getPname() %></h5>
				        <p>￦<%=nf.format(product.getDownPrice()) %></p><i class="ion-ios-arrow-right"></i>
				        </figcaption>
				        <a href="./product/product_read.jsp?id=<%=product.getId() %>"></a>
				    </figure>
<%

		}
%>	    
			</div>
		</div>
    </div>
</div>
<br><br><br><br><br><br>
   	<jsp:include page="./include/footer.jsp"></jsp:include>
</body>
</html>