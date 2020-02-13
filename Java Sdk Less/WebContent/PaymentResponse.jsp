<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%!

static String secret_key = ""; //Replace your merchant secret key

%>

<%!

static boolean verifyPayments(String order_id, String payment_id, String signature) throws Exception{ 
	
	if (order_id == null || payment_id == null || signature == null) {
		return false;
	}
	
	String data = order_id + "|" + payment_id;
	
	javax.crypto.Mac mac = javax.crypto.Mac.getInstance("HmacSHA256");
	mac.init(new javax.crypto.spec.SecretKeySpec(secret_key.getBytes(), "HmacSHA256"));
	
	byte[] hexBytes = new org.apache.commons.codec.binary.Hex().encode(mac.doFinal(data.getBytes()));
	
	String generated_signature = new String(hexBytes, "UTF-8");
	
	if (generated_signature.equalsIgnoreCase(signature)) {
	    return true;
	}
	
	return false;
	
}
%>

<%

String order_id=request.getParameter("razorpay_order_id");
String payment_id=request.getParameter("razorpay_payment_id");
String signature=request.getParameter("razorpay_signature"); 
String code= request.getParameter("error[code]");
String description= request.getParameter("error[description]");



boolean isSignatureValid= verifyPayments(order_id, payment_id, signature);
boolean isError = code != null;

if (isError) {
%>
       Error_code :           <%=code%>
       Error_description :    <%=description%>
   
<% } else if (isSignatureValid) { %>
   Your Unique Order Id : <%=order_id%>
    Razorpay_payment_id :  <%=payment_id%>
    Razorpay_Signature :   <%=signature%>
<% } else {%>
           Razorpay's Response Signature and Our (Merchant) Signature Mis-Match
            
<% } %>

</body>
</html>