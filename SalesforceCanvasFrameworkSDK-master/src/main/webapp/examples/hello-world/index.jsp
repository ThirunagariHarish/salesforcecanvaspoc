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
    	try {
    		console.log(window);
    		console.log(window.parent);
    		window.parent.postMessage('Sending Message','*');
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
		<select multiple class="form-control" id="exampleFormControlSelect2">
			<option>Property 1</option>
			<option>Property 2</option>
			<option>Property 3</option>
			<option>Property 4</option>
			<option>Property 5</option>
		</select>
	</div>
	<div>
		<button onclick="callSendEvent()" class="btn btn-primary">Attach</button>
	</div>
</body>
</html>
