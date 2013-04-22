$(document).ready(function() {

	$("#fechanac").datepicker(
			{
				showOn : 'both',
				buttonText : 'Fecha',
				changeMonth: true,
				changeYear: true,
				buttonImage : 'images/calendario.png',
				buttonImageOnly : true,
				yearRange: '-100y:+1y',
				dateFormat : 'dd-mm-yy',
				monthNames : [ 'Enero', 'Febrero', 'Marzo', 'Abril',	'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre',	'Octubre', 'Noviembre', 'Diciembre' ],
				monthNamesShort: ['Ene','Feb','Mar','Abr','May','Jun', 'Jul','Ago','Sep','Oct','Nov','Dic'],
				dayNames : [ 'Domingo', 'Lunes', 'Martes', 'Miercoles', 'Jueves', 'Viernes', 'Sabado' ],
				dayNamesShort : [ 'Dom', 'Lun', 'Mar', 'Mir', 'Jue', 'Vie','Sat' ],
				dayNamesMin : [ 'Do', 'Lu', 'Ma', 'Mi', 'Ju', 'Vi', 'Sa' ]
			});
	
	//Validacion del formulario de usuario/password
	$("#userform").validationEngine('attach',{
		autoPositionUpdate:true,
		focusFirstField : true,
	});
/*
	$("#userform").validate({
        onfocusout: false,
        invalidHandler: function(form, validator) {
            var errors = validator.numberOfInvalids();
            if (errors) {
                alert(validator.errorList[0].message);
                validator.errorList[0].element.focus();
            }
        },
		rules:{
			nombreUsuario: {
				required:true,
				number: false
			},
			segNombreUsuario: {
				number:false
			},
			apellidoPaterno: {
				required:true,
				number: false
			},
			apellidoMaterno: {
				number:false
			},
			emailUsuario: {
				required:true,
				email: true
			},
			fechanac: {
				required:true
			},
			fonoUsuario: {
				required:true,
				digits:true
			},
			movilUsuario: {
				digits:true
			}
		},
		messages:{
			nombreUsuario:{
				required: " Campo Obligatorio",
				number: "El campo no debe contener numeros"
			},
			segNombreUsuario:{
				number: "El campo no debe contener numeros"
			},	
			apellidoPaterno:{
				required:" Campo Obligatorio",
				number: "Ingrese solo letras por favor"
			},
			apellidoMaterno:{
				number: "El campo no debe contener numeros"
			},
			emailUsuario:{
				required: " Campo Obligatorio",
				email: "Debe ingresar un correo válido"
			},
			fechanac:{required: " Campo Obligatorio"},
			fonoUsuario:{
				required: " Debe ingresar un número de teléfono",
				digits: " Ingrese solo números, por favor"
			},
			movilUsuario:{
				digits: " Ingrese solo números, por favor"
			}
		},
        errorPlacement: function(error, element) {
            // Colaca los errores en un alert y no junto a los campos deformando la grafica //
        },
		submitHandler: function(){
			dataString = $("#userform").serialize();
		    $.ajax({
		        url: "fce",
		        data: dataString,
		        context: document.body,
			   success: function(responseText, textStatus, jqXHR) {
//				   if (jqXHR.getResponseHeader('REQUIRES_AUTH') == '1')
					   $("body").html(responseText);
//				   else
//					   alert(responseText);
			   }
		    });   
		}
	});
	*/
});

function cargaElementos(){
	//Calendario para el formulario
	$("#fechanac").datepicker(
			{
				showOn : 'both',
				buttonText : 'Fecha',
				changeMonth: true,
				changeYear: true,
				buttonImage : 'images/calendario.png',
				buttonImageOnly : true,
				yearRange: '-100y:+1y',
				dateFormat : 'dd-mm-yy',
				monthNames : [ 'Enero', 'Febrero', 'Marzo', 'Abril',	'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre',	'Octubre', 'Noviembre', 'Diciembre' ],
				monthNamesShort: ['Ene','Feb','Mar','Abr','May','Jun', 'Jul','Ago','Sep','Oct','Nov','Dic'],
				dayNames : [ 'Domingo', 'Lunes', 'Martes', 'Miercoles', 'Jueves', 'Viernes', 'Sabado' ],
				dayNamesShort : [ 'Dom', 'Lun', 'Mar', 'Mir', 'Jue', 'Vie','Sat' ],
				dayNamesMin : [ 'Do', 'Lu', 'Ma', 'Mi', 'Ju', 'Vi', 'Sa' ]
			});
	//Carga motor de validacion
	
	$("#userform").validationEngine('attach',{
		autoPositionUpdate:true,
		focusFirstField : true
		/*
	    onValidationComplete: function(form, status){
	    	if(status == true){
			dataString = $("#userform").serialize();
		    $.ajax({
		        url: "fce",
		        data: dataString,
		        context: document.body,
			   success: function(responseText, textStatus, jqXHR) {
				   if (jqXHR.getResponseHeader('ERROR') == '0'){
					   //Respuesta correcta desde el servidor
					   $("body").html(responseText);
					   $.getScript('js/intranet/template.js');
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
		} */
	});

	function callFce(){
		$("form").submit();
	}

}
	
	