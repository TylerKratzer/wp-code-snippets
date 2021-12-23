<script type="text/javascript">
function callback(e) {
    const debug = false;
    var e = window.e || e;
    var el;
    var url;
    var lt;
    
    switch (e.target.tagName) {
    	case 'A':
    		if (debug == true) {console.log ("Clicked element is A");}
    		lt = "Outbound_link:Text";
    		el = e.target;
    		break;
    	case 'IMG':
    		lt = "Outbound_link:Image";
    		el = e.target.parentNode;
    		if (el.tagName != "A"){
    			if (debug == true) {console.log ("Clicked element is IMG but parent is not A");}
    			return;
    			}
    		else {
    			if (debug == true) {console.log ("Clicked element is IMG and parent is A");}
    			}
    		break;
    	default:
    		if (debug == true) {console.log ("Clicked element is " + element.target.tagName + " so QUIT");}
    		return;
    }
    
    if (el.href.indexOf(location.host) == -1 && el.href.match(/^http:\/\//i)){
    	url = el.href.replace(/http:\/\//i,"");
    	if (debug == true) {console.log("Sending event to GA for : " + url);}
    	// 'Event Category', 'Event Action', 'Event Label'
    	ga('send', 'event', lt, url, window.location.href);
    	}
    else{
    	if (debug == true) {console.log ("Didn't process GA event for : " + element.href);}
    	return;
    	}
}
if (document.addEventListener)
    document.addEventListener('click', callback, false);
else
    document.attachEvent('onclick', callback);
</script>
