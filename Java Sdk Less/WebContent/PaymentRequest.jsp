<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%@ page import="com.razorpay.sdkless.orders" %>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>


<button id="rzp-button1">Pay</button>
<script src="https://checkout.razorpay.com/v1/checkout.js"></script>

<script>


var options = {
		
   	"key": "",        //Replace your merchant api key
    "amount": "5000", // Amount is in currency subunits. Default currency is INR. Hence, 29935 refers to 29935 paise or INR 299.35.
    "currency": "INR",
    "name": "Acme Corp",
    "description": "Payment for test transaction", 
    "image": "https://example.com/your_logo",   
    "order_id": "<%= orders.generateOrder() %>",
    "callback_url": "http://localhost:8080/Java_SDKless/PaymentResponse.jsp",
    "redirect": "true",
        
    "prefill": {
         "name": "Mayur",
         "email": "praveen.gn@razorpay.com",
         "contact": "9960525050",
           
        },
         
    
   "notes": {
       "address": "9960525050",
       "name": "Mayur Mahale"
    },
    
   "theme": {
       "color": "##F0D53E",
      
    },
     
    
};

var rzp1 = new Razorpay(options);

document.getElementById('rzp-button1').onclick = function(e){
    rzp1.open();
    e.preventDefault();
}
</script>

</body>
</html>