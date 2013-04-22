$(document).ready(function() {
	  //Validacion del formulario de usuario/password
		$("#formularioLogIn").validationEngine('attach',{
			autoPositionUpdate:true,
			focusFirstField : true,
		});
		
		//Esconde el formulario con el dato del rut para la solicitud de clave div w/id extra
		   $("#extra").css("display","none");

		   $("#checkme").click(function(){
				$("#extra").show("fast");
				$("#tabla").hide("fast");
		  });
		  
		   $("#back").click(function(){
				$("#tabla").show("fast");
				$("#extra").hide("fast");
		  });
		  
		   //Funcionalidad para mostrar dialogos con mensajes desde el servidor
		   var mensaje = $("#dialog").text();
		   if(mensaje != ""){
			   $("#dialog").html(mensaje);
	  			$("#dialog").dialog({
					modal: true,
					buttons: {
						Ok: function() {
							$( this ).dialog( "close" );
						}
					}
	  			});
		   }

});

function solicitaClave() {
	$.ajax({
        url: "fce?reqName=prgusrparaclave&emailc="+ document.getElementById("emailc").value,
        context: document.body,
   success: function(responseText, textStatus, jqXHR) {
	   if (jqXHR.getResponseHeader('ERROR') == '0')
		   $("body").html(responseText);
	   else if (jqXHR.getResponseHeader('ERROR') == '1'){
		   $("#dialog").html(responseText);
   			$("#dialog").dialog({
				modal: true,
				buttons: {
					Ok: function() {
						$( this ).dialog( "close" );
					}
				}
   			});
	   } else {
		   $("body").html(responseText);
	   }
   }
});   
};

function callFce(){
	$("form").submit();
}
