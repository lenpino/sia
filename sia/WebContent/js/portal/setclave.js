
$(document).ready(function() {	
	$("#form1").validationEngine('attach',{
		autoPositionUpdate:true,
		focusFirstField : true,
		onValidationComplete: function(form, status){
			if(status == true){
				dataString = $("#form1").serialize();
			    $.ajax({
			        url: "fce",
			        data: dataString,
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
					   }
					   else
						   $("body").html(responseText);
				   }
			    }); 
			} else {
				return false;
			}
		}  
	});
});
