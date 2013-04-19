$(document).ready(function() {
	cargaElementos();
	
	$(".btnCerrar").click(function()
	{
		$("#step-question-default").show();
		$("#step-NumSerial").hide();
		$("#step-TipDoc").hide();
		$("#step-VigCert").hide();
	});
	
	$.validator.addMethod(
		    "date",
		    function ( value, element ) {
		        var bits = value.match( /([0-9]+)/gi ), str;
		        if ( ! bits )
		            return this.optional(element) || false;
		        str = bits[ 1 ] + '-' + bits[ 0 ] + '-' + bits[ 2 ];
		        return this.optional(element) || !/Invalid|NaN/.test(new Date( str ));
		    },
		    "Ingrese la fecha en el formato dd-mm-yyyy"
	);
		
});


function cargaElementos(){
	
	$("#fechanac").datepicker(
			{
				showOn : 'focus',
				buttonText : 'Fecha',
				changeMonth: true,
				changeYear: true,
				yearRange: '-100y:+1y',
				dateFormat : 'dd-mm-yy',
				monthNames : [ 'Enero', 'Febrero', 'Marzo', 'Abril',	'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre',	'Octubre', 'Noviembre', 'Diciembre' ],
				monthNamesShort: ['Ene','Feb','Mar','Abr','May','Jun', 'Jul','Ago','Sep','Oct','Nov','Dic'],
				dayNames : [ 'Domingo', 'Lunes', 'Martes', 'Miercoles', 'Jueves', 'Viernes', 'Sabado' ],
				dayNamesShort : [ 'Dom', 'Lun', 'Mar', 'Mir', 'Jue', 'Vie','Sat' ],
				dayNamesMin : [ 'Do', 'Lu', 'Ma', 'Mi', 'Ju', 'Vi', 'Sa' ]
			});
	//Aplica el combo con autollenado al select con las comunas
    $("#comuna").combobox({});
    
    //Aplica estilos de ancho y alto al combo de las comunas
    $("#idcombo > input.ui-autocomplete-input").css('width', '157px');
    $("#idcombo > input.ui-autocomplete-input").css('height', '24px');

	// Smart Wizard 	
		$('#wizard').smartWizard({
			enableFinishButton: false,
			onLeaveStep:leaveAStepCallback,
			onFinish:onFinishCallback,
		    labelPrevious:'Anterior',
		    labelFinish:'Finalizar', 
			labelNext:'Siguiente'
		});
		
	    $("#dniUsuario2").Rut({
	    	format: true,
	    	format_on: 'keyup',
	    	on_error: function() {}
	    });
		
	    $("#rutemp").Rut({
	    	format: true,
	    	format_on: 'keyup',
	    	on_error: function() {}
	    });
	    
		$("#paso1").validationEngine('attach',{
			autoPositionUpdate:true,
			focusFirstField : true,
			'customFunctions': {
		        'checkRutField': function (field, rules, i, options){
		            if ($.Rut.validar(field.val())) {
		            } else {
		            	return "* Rut invalido";
		            }
		        }
		    }
		});
		

		$('#paso1').bind('jqv.field.result', function(event, field, errorFound, prompText) {
			event.preventDefault();
			if(errorFound){
				//alert('error');
			} else {
				//alert('sinerror');
			}
		});
}

function onFinishCallback(obj){
	// Obtiene el numero del paso
	var step_num = $("#wizard").smartWizard('currentStep');
	if(!validateSteps(step_num))
		return;
	dataString = $("#paso1").serialize();
    $.ajax({
        url: "/sia/fce",
        data: dataString,
        context: document.body,
	   success: function(responseText, textStatus, jqXHR) {
		   if (jqXHR.getResponseHeader('ERROR') == '0')
			   $("body").html(responseText);
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
  } 

function leaveAStepCallback(obj){
	// Obtiene el numero del paso
    var step_num= obj.attr('rel');
    // Con falso se permanece en el paso. Verdadero hace la transicion hacia el paso siguiente
   return validateSteps(step_num);
  }


// Logica de validacion por cada paso
function validateSteps(stepnumber){
  var isStepValid = true;
  // Valida Paso 1
  if(stepnumber == 1){
	  isStepValid = !($("#dniUsuario2").validationEngine('validate') ||
	    				$("#clave").validationEngine('validate') || 
	    				$("#confirmaClave").validationEngine('validate') || 
	    				$("#nombreUsuario").validationEngine('validate') ||
	    				$("#apellidoPaterno").validationEngine('validate') ||
	    				$("#emailUsuario").validationEngine('validate') ||
	    				$("#fechanac").validationEngine('validate') ||
	    				$("#movilUsuario").validationEngine('validate'));
  } else if(stepnumber == 2){
	  isStepValid = !($("#rutemp").validationEngine('validate') ||
			  			$("#razon").validationEngine('validate') ||
			  			$("#giro").validationEngine('validate') ||
			  			$("#direccion").validationEngine('validate') ||
			  			$("#comuna").validationEngine('validate') ||
			  			$("#ciudad").validationEngine('validate'));
  }
  return isStepValid;     
}
	