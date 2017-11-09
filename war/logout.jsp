<html>
<meta name="google-signin-client_id" content="430564811204-3vpmmbkd6j14vefia9ibsjnuvbuttbe8.apps.googleusercontent.com">

<body>

<% session.invalidate();
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache"); 
response.setHeader("Expires", "0");

    %>
  <jsp:forward page="index.jsp"></jsp:forward>
 
    <script src="https://apis.google.com/js/platform.js?onload=onLoad" async defer></script>
  
</body></html>