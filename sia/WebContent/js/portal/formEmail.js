$(document).ready(function() {
	
	$("#formEmail").validationEngine('attach',{
		scroll:false,
		autoPositionUpdate:true,
		focusFirstField : true,
		validationEventTrigger: 'submit blur',
		onSuccess: function() { alert("onSuccess 1");},
		onFailure: function(){ alert("onFailure 1"); },
		onValidationComplete: function(form, status) {
			if (status==true){
				$("#reqName").val('prgverificamail');
				dataString = $("#formEmail").serialize();
				$.ajax({
					url: "/sia/fce",
					data: dataString,
					context: document.body,
					success: function(responseText, textStatus, jqXHR) {
						   if (jqXHR.getResponseHeader('ERROR') == '0'){
							   $("#respuestaAccion").css("color", "#FFFFFF");
							   $("#respuestaAccion").html(responseText);
						   } else if (jqXHR.getResponseHeader('ERROR') == '1'){
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
						   else{
							   $("body").html(responseText);
						   }
					}
				});
			}
		}
	});
	
});