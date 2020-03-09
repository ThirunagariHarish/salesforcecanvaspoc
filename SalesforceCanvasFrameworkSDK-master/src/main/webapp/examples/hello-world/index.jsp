<%@ page import="canvas.SignedRequest"%>
<%@ page import="java.util.Map"%>
<%
	// Pull the signed request out of the request body and verify/decode it.
	Map<String, String[]> parameters = request.getParameterMap();
	String[] signedRequest = parameters.get("signed_request");
	if (signedRequest == null) {
%>
This App must be invoked via a signed request!<%
	return;
	}
	String yourConsumerSecret = System.getenv("CANVAS_CONSUMER_SECRET");
	//String yourConsumerSecret="1818663124211010887";
	String signedRequestJson = SignedRequest.verifyAndDecodeAsJson(signedRequest[0], yourConsumerSecret);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head>
<title>Hello World Canvas Example</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
<!-- Include all the canvas JS dependencies in one file -->
<script type="text/javascript"
	src="https://canvaspoctest.herokuapp.com/sdk/js/canvas.js"></script>
<script type="text/javascript"
	src="https://canvaspoctest.herokuapp.com/sdk/js/cookies.js"></script>
<script type="text/javascript"
	src="https://canvaspoctest.herokuapp.com/sdk/js/oauth.js"></script>
<script type="text/javascript"
	src="https://canvaspoctest.herokuapp.com/sdk/js/xd.js"></script>
<script type="text/javascript"
	src="https://canvaspoctest.herokuapp.com/sdk/js/client.js"></script>
<script type="text/javascript"
	src="https://canvaspoctest.herokuapp.com/scripts/json2.js"></script>


<script>  
    function callSendEvent() {
    	var selectedValues = $('#selectProperties').val();
    	try {
    		sr = JSON.parse('<%=signedRequestJson%>');
    		Sfdc.canvas.client.publish(sr.client,{
    			name : 'mynamespace.message',
    			payload : {value:selectedValues} });
		}
    	catch(err)
    	{
    		console.log(err);
    	}
	}
</script>
</head>
<body>
	<div class="form-group">
		<h1>Select Properties that need to be attached to the opportunity</h1>
	</div>
	<div class="form-group">
		<select multiple class="form-control" id="selectProperties">
			<option value="property 1">Property 1</option>
			<option value="property 2">Property 2</option>
			<option value="property 3">Property 3</option>
			<option value="property 4">Property 4</option>
			<option value="property 5">Property 5</option>
		</select>
	</div>
	<div>
		<button onclick="callSendEvent()" class="btn btn-primary">Attach</button>
	</div>
</body>
</html>
