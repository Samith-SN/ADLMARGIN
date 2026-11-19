var data_vec=null;
var data_vec_no=null;
function load_interface(m_url,m_type,asyn){
	
	var http_request = false;
	
	if (window.XMLHttpRequest) {
		http_request = new XMLHttpRequest();
		if (http_request.overrideMimeType) {
			if(m_type=="XML"){
				http_request.overrideMimeType('text/xml');
			}else{
				http_request.overrideMimeType('text/html');
			}
		}
	} 
	else if (window.ActiveXObject) { 
		try {
			http_request = new ActiveXObject("Msxml2.XMLHTTP");
		} 
		catch (e) {
			try {
				http_request = new ActiveXObject("Microsoft.XMLHTTP");
			} 
			catch (e) {}
		}
	}
	
	if (!http_request) {
		alert('Giving up :( Cannot create an XMLHTTP instance');
		return false;
	}
	
	http_request.onreadystatechange = function() {
		
		if(m_type=="XML"){//retrun in xml format
			
			load_data_new(http_request);
			
		}
		else{
			load_data_normal(http_request); 
		}
	};
	
	/*
	data_vec= new Array();
	
	if (http_request.readyState == 4) {
		if (http_request.status == 200) {
				var xmlbody=http_request.responseXML.documentElement;
				var vsize=0;
					for(var i=0;i<xmlbody.childNodes.length;i++){
						for(var j=0;j<xmlbody.childNodes[i].childNodes.length;j++){
							data_vec[vsize]=xmlbody.childNodes[i].childNodes[j].text;
							vsize++;
						}
					}
				get_vector(data_vec);
			}
	}
	*/
	
	http_request.open('GET',m_url,asyn);//asyn
	http_request.send(null);
	
}


function load_data_new(http_request){ // Modified by Chatura Jayawardena on 19-03-2010
	
	data_vec= new Array();
	//alert(http_request.readyState);
	if (http_request.readyState == 4) {
		//alert(http_request.status);
		if (http_request.status == 200) {
			
			
			xmlDoc=http_request.responseXML;
			//alert('test1');
			var not_whitespace = new RegExp(/[^\s]/);
			var vsize=0;
			for(var i=0;i<xmlDoc.getElementsByTagName("ITEM").length;i++){
				
				for(var j=0;j<xmlDoc.getElementsByTagName("ITEM")[i].childNodes.length;j++){
					
					if(xmlDoc.getElementsByTagName("ITEM")[i].childNodes[j].firstChild!=null ){
						
						if(not_whitespace.test(xmlDoc.getElementsByTagName("ITEM")[i].childNodes[j].firstChild.nodeValue)&& xmlDoc.getElementsByTagName("ITEM")[i].childNodes[j].firstChild.nodeType == 3){
							
							data_vec[vsize]=xmlDoc.getElementsByTagName("ITEM")[i].childNodes[j].firstChild.nodeValue.replace('&amp;','&');
							vsize++;
						}
						
					}
					else{
						if(xmlDoc.getElementsByTagName("ITEM")[i].childNodes[j].nodeValue==null){
							data_vec[vsize]= " ";
							vsize++;
						}
						
						
					}
					
				}
			}
			//       get_vector(data_vec);
			
			
			
			
		}
	}
	
}

function load_data_normal(http_request){ 
	
	
	
	if (http_request.readyState == 4) {
		if (http_request.status == 200) {
		
			if(http_request.responseText!=""){
			
				get_vector_normal(http_request.responseText);
				data_vec_no=http_request.responseText;
				
				
			}
		}
	}
}





/*
function load_data(http_request){

var data_vec= new Array();


var  xmlbody=http_request.responseXML.documentElement;
var vsize=0;

for(var i=0;i<xmlbody.childNodes.length;i++){
	for(var j=0;j<xmlbody.childNodes[i].childNodes.length;j++){
		data_vec[vsize]=xmlbody.childNodes[i].childNodes[j].text;
		vsize++;
	}
}

return data_vec;

}

*/
