$(document).ready(function() {
	  //Validacion del formulario de usuario/password
		$("#formularioLogIn").validationEngine('attach',{
			autoPositionUpdate:true,
			focusFirstField : true,
		    onValidationComplete: function(form, status){
		    	if(status == true){
				dataString = $("#formularioLogIn").serialize();
			    $.ajax({
			        url: "fce",
			        data: dataString,
			        context: document.body,
				   success: function(responseText, textStatus, jqXHR) {
					   if (jqXHR.getResponseHeader('ERROR') == '0'){
						   //Respuesta correcta desde el servidor
						   $("body").html(responseText);
						   $.getScript('js/portal/formLogin.js');
						   //Setea el background del cuerpo
					   }
					   else{
						   $("#dialog").html(responseText);
				   			$("#dialog").dialog({
								modal: true,
								buttons: {
									Ok: function() {
										$( this ).dialog( "close" );
									}
								}
				   			});
					   }
				   	}
			    }); 
			 }else {
			    return false;
			 }
		    } 
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

