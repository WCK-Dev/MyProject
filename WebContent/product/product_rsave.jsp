'<%@page import="com.catp.product.ProductDBBean"%>
<%@page import="com.sun.org.glassfish.gmbal.util.GenericConstructor"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*, java.text.*" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<!DOCTYPE html>
<html>
<style>
	.move { text-align: center;}
</style>
<head>
<meta charset="UTF-8">
<title>제품 정보 수정 처리</title>
</head>
<body>
<%	request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="product" class="com.catp.product.ProductDataBean"/>
<%
	//1번 방법 - 업로드 된 파일을 외부 폴더로 지정하는 방법(서버상의 경로를 지정) - 주로 쓰이며, 권장되는 방식
	String fileurl = "/ncs_wck/jsp01/workspace/MyProject/WebContent/Images/product";
	
	int maxsize = 5 * 1024 * 1024; // 5MB (파일 최대허용 크기)
	
	DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();
	MultipartRequest multi = new MultipartRequest(request, fileurl, maxsize, "UTF-8", policy);
	
	product.setId(Integer.parseInt(multi.getParameter("id")));
	product.setWname(multi.getParameter("wname"));
	product.setCategory1(multi.getParameter("category1"));
	product.setCategory2(multi.getParameter("category2"));
	product.setPname(multi.getParameter("pname"));
	product.setSname(multi.getParameter("sname"));
	product.setPrice(Integer.parseInt(multi.getParameter("price")));
	product.setDownPrice(Integer.parseInt(multi.getParameter("downprice")));
	product.setStock(Integer.parseInt(multi.getParameter("stock")));
	product.setDescription(multi.getParameter("description"));
	
	Enumeration files = multi.getFileNames();
	String img3 = (String)files.nextElement();
	String img2 = (String)files.nextElement(); 
	String img1 = (String)files.nextElement(); 
	// files에서 nextElement()로 파일명을 꺼낼경우, input에서 name으로 넘겨준 property의 역순 Enumeration에 담긴다
	String filename1 = multi.getFilesystemName(img1);
	String filename2 = multi.getFilesystemName(img2);
	String filename3 = multi.getFilesystemName(img3);
	if(filename2 == null) filename2 = filename1;
	
	java.util.Date yymmdd = new java.util.Date();
	SimpleDateFormat myformat = new SimpleDateFormat("yyyy-MM-dd a hh:mm:ss");
	String inputdate = myformat.format(yymmdd);
	
	product.setInputDate(inputdate);
	product.setImg1(filename1);	
	product.setImg2(filename2);	
	product.setImg3(filename3);
	
	
	ProductDBBean dbPro = ProductDBBean.getInstance();
	
	int check = dbPro.updateProduct(product);
	
	if(check != 0)out.print("<script>alert('상품 정보가 수정되었습니다.');</script>");
	else out.print("<script>alert('상품 정보 수정에 오류가 발생했습니다.');</script>");
	
	out.print("<script>location.href='product_write.jsp'</script>");
%>
</body>
</html>