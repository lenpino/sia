function eliminarAplicacion(idAplicacion){
	  $.ajax({
		  	url: "fce?reqName=prgCrudAplicaciones&&idAplicacion=" + idAplicacion + "&accion=1",
	        context: document.body,
	        success: function(responseText, textStatus, jqXHR) {
				   if (jqXHR.getResponseHeader('REQUIRES_AUTH') === '1')
					   alert(responseText);
				   return true;
	        }
	    });
}

function crearAplicacion(){
	var nombreAplicacion = document.getElementById("descripcion").value;
	var webroot = document.getElementById("webroot").value;
	  $.ajax({
		  	url: "fce?reqName=prgCrudAplicaciones&nombreAplicacion="+nombreAplicacion + "&webroot="+webroot + "&accion=2",
	        context: document.body,
	        success: function(responseText) {
				   if (jqXHR.getResponseHeader('REQUIRES_AUTH') === '1')
					   alert(responseText);
				   return true;
	        }
	    });
}


function modificarAplicacion(idAplicacion){
	var nombreAplicacion = document.getElementById("descripcion").value;
	var webroot = document.getElementById("webroot").value;
	  $.ajax({
		  	url: "fce?reqName=prgCrudAplicaciones&nombreAplicacion="+nombreAplicacion+"&idAplicacion="+idAplicacion + "&webroot="+webroot + "&accion=3",
	        context: document.body,
	        success: function(responseText) {
				   if (jqXHR.getResponseHeader('REQUIRES_AUTH') === '1')
					   alert(responseText);
				   return true;
	        }
	    });
};
