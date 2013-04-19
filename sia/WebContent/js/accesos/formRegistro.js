$(document).ready(function() {
	cargaElementos();
	validaFormCreacion();
	validaFormEdicion();
	cargaGrillaUsuarios();
	validaFormRol();
	validaFormLugar();
});

function eliminarUsuario(idUsuario){
	$.ajax({
		url: "fce?reqName=prgUsuariosEliminacion&" + "idUsuario="+ idUsuario,
		context: document.body,
	   success: function(responseText, textStatus, jqXHR) {
		   //Si la respuesta es correcta se pinta el JSP/HTML retornado en el DIV que corresponde
		   if (jqXHR.getResponseHeader('OK') == '1'){
			   $("#respuestaAccion").html(responseText, function() {
	            	$.getScript('js/jquery-1.7.1.min.js');
	            	$.getScript('js/usuario.js');
	            	$.getScript('js/jqgrid/js/jquery.jqGrid.min.js');
			   });
			   cargaGrillaUsuarios();
		   }
		   //Si no es correcta entonces se carga el JSP retornado por el FCE completo
		   else{
			   $("body").html(responseText);
		   }
	   	}
    });
};

function callLinkFCE(aliasJSP){
	$.ajax({
		url: "fce?reqName=prglink&" + "pagina="+ aliasJSP,
		context: document.body,
		success: function(responseText, textStatus, jqXHR) {
		   $("#respuestaAccion").html(responseText, function() {
            	$.getScript('js/jquery-1.7.1.min.js');
            	$.getScript('js/usuario.js');
            	$.getScript('js/jqgrid/js/jquery.jqGrid.min.js');
		   });
		   cargaGrillaUsuarios();
	   	}
    });
};

function crearUsuario() {
    $.ajax({
        url: "fce?reqName=prgCrearUsuarios",
        context: document.body,
        success: function(responseText) {
	        $("#respuestaAccion").html(responseText)
	        cargaElementos();
	        validaFormCreacion();
	        validaFormRol();
	        validaFormLugar();
	        //Inicializa el cuadro de dialogo para la creacion de nuevo ROL
	        $( "#dialog-newRol" ).dialog({
	            modal: true,
	            resizable: false,
	            autoOpen: false,
	            width: 320        
	        });
	      //Inicializa el cuadro de dialogo para la creacion de nuevo LUGAR
	        $( "#dialog-newUnidad" ).dialog({
	            modal: true,
	            resizable: false,
	            autoOpen: false,
	            width: 320        
	        });	        //Handler para el evento de cambio de valor en el select del rol
	        $("#rol").change(function() {
	        	if($("#rol").val() == 'NEW')
	        		showDialogoRol();
	         });
	        //Handler para el evento de cambio de valor en el select del rol
	        $("#lugar").change(function() {
	        	if($("#lugar").val() == 'NEW')
	        		showDialogoUnidad();
	         });
	     }
    });
}

function editarUsuario(idUsuario) {	
    $.ajax({
        url: "fce?reqName=prgUsuariosEditar" + "&idUsuario="+ idUsuario,
        context: document.body,
        success: function(responseText) {
            $("#respuestaAccion").html(responseText);
            cargaElementos();
	        validaFormEdicion();
        }
    });
};

function modificarRoles(){
	  dataString = $("#rolesform").serialize();
	  $.ajax({
	        url: "fce",
	        data: dataString,
	        context: document.body,
	        success: function(responseText) {
	            $("#respuestaAccion").html(responseText);
	            $.getScript('js/usuario.js');
	            $.getScript('js/ui.multiselect.js');
	            $.getScript('js/locale/ui-multiselect-es.js');
	            $.getScript('js/jquery-ui-1.8.16.custom.min.js');
	            $.getScript('js/css.js');       
	            $.getScript('js/jquery.cookie.js');
	            $.getScript('js/jquery.treeview.js');
	            $.getScript('js/jquery-1.7.1.min.js');
	        }
	    });
	};


function eliminarApp(idDiv,idAplicacion,idEmpresa,idRol,idUsuario){
	if (confirm("Esta seguro que desea quitar la aplicacion al usuario")){
        $.ajax({
            url: "fce?reqName=prgadmperfil&accion=2" + "&idAplicacion=" + idAplicacion + "&idEmpresa="+idEmpresa + "&idRol=" + idRol + "&idUsuario=" + idUsuario,
	        context: document.body,
	        success: $('#'+idDiv).hide('slow')
	    });
	}
}
function eliminarEmpresa(idDiv,idEmpresa,idRol,idUsuario){
	if (confirm("Esta seguro que desea quitar la empresa al usuario")){
        $.ajax({
            url: "fce?reqName=prgadmperfil&accion=1" + "&idEmpresa="+idEmpresa + "&idRol=" + idRol + "&idUsuario=" + idUsuario,
	        context: document.body,
	        success: $('#'+idDiv).hide('slow')
	    });
	}
}
function eliminarRol(idDiv){	
	if (confirm("Esta seguro que desea quitar el rol al usuario"))
			$('#'+idDiv).hide('slow');
}

//popup de agregar

function llamarDialogo(){	
	$('#dialog').jqm();
}

function llamarDialogo2(){	
	$('#dialog2').jqm();
}

function agregarEmpresaApp(idRol, idUsuarioHidden){
	document.getElementById("idRolHidden").value = idRol;	
	document.getElementById("idUsuarioHidden").value = idUsuarioHidden;
	document.getElementById("idEmpresaSelect").value = '0';
	if (document.getElementById("aplicacionEmpresa")){
		document.getElementById("aplicacionEmpresa").innerHTML = "<select name='idAplicacionHidden' id='idAplicacionHidden'><option value='0'>Seleccione</option></select>";
	}
}
function agregarApp(idRol, idUsuarioHidden){
	
	confirm("Recuerde seleccionar misma Empresa para agregar Aplicacion");
	document.getElementById("idRolHidden").value = idRol;	
	document.getElementById("idUsuarioHidden").value = idUsuarioHidden;
	document.getElementById("idEmpresaSelect").value = '0';
	if (document.getElementById("aplicacionEmpresa")){
		document.getElementById("aplicacionEmpresa").innerHTML = "<select onchange='validarApp()' name='idAplicacionHidden' id='idAplicacionHidden'><option value='0'>Seleccione</option></select>";
	}
}

function validarApp(){
	if(document.getElementById("idAplicacionHidden").value != "0"){
		document.getElementById("idBtnGrabarPerfil").disabled = false;
	}else{
		document.getElementById("idBtnGrabarPerfil").disabled = true;
	}
}

function getAplicacionByEmpresa(idEmpresa){		
	    $.ajax({
	        url: "fce?reqName=prglistappemp&idEmpresa="+idEmpresa+"&idRol="+document.getElementById("idRolHidden").value+"&idUsuario="+document.getElementById("idUsuarioHidden").value,	        
	        context: document.body,
	        success: function(responseText) {
	            $("#aplicacionEmpresa").html(responseText);
	        }
	    });
	
}

function savePerfil(){
	$.ajax({
        url: "fce?reqName=prgguardaperfil&idRolHidden="+document.getElementById("idRolHidden").value+"&idUsuarioHidden="+document.getElementById("idUsuarioHidden").value+"&idEmpresaSelect="+document.getElementById("idEmpresaSelect").value+"&idAplicacionHidden="+document.getElementById("idAplicacionHidden").value,	        
        context: document.body,
        success: function(responseText) {
            $("#aplicacionEmpresa").html(responseText);
        }
    });
}


function cargaElementos(){
	$("#fechanac").datepicker(
			{
				showOn : 'both',
				buttonText : 'Fecha',
				changeMonth: true,
				changeYear: true,
				buttonImage : 'images/ic_calendario.gif',
				buttonImageOnly : true,
				yearRange: '-100y:+1y',
				dateFormat : 'dd-mm-yy',
				monthNames : [ 'Enero', 'Febrero', 'Marzo', 'Abril',	'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre',	'Octubre', 'Noviembre', 'Diciembre' ],
				monthNamesShort: ['Ene','Feb','Mar','Abr','May','Jun', 'Jul','Ago','Sep','Oct','Nov','Dic'],
				dayNames : [ 'Domingo', 'Lunes', 'Martes', 'Miercoles', 'Jueves', 'Viernes', 'Sabado' ],
				dayNamesShort : [ 'Dom', 'Lun', 'Mar', 'Mir', 'Jue', 'Vie','Sat' ],
				dayNamesMin : [ 'Do', 'Lu', 'Ma', 'Mi', 'Ju', 'Vi', 'Sa' ]
			});
	
		$( "#desde" ).datepicker({
			showOn: 'button',
			buttonImageOnly: true,
			beforeShow: customRange,
			changeMonth: true,
			changeYear: true,
			buttonImage: 'imagenes/ico_calendar.jpg',
			dateFormat:'dd-mm-yy',
			monthNames : [ 'Enero', 'Febrero', 'Marzo', 'Abril',	'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre',	'Octubre', 'Noviembre', 'Diciembre' ],
			monthNamesShort: ['Ene','Feb','Mar','Abr','May','Jun', 'Jul','Ago','Sep','Oct','Nov','Dic'],
			dayNames : [ 'Domingo', 'Lunes', 'Martes', 'Miercoles', 'Jueves', 'Viernes', 'Sabado' ],
			dayNamesShort : [ 'Dom', 'Lun', 'Mar', 'Mir', 'Jue', 'Vie','Sat' ],
			dayNamesMin : [ 'Do', 'Lu', 'Ma', 'Mi', 'Ju', 'Vi', 'Sa' ]					
		});
		
	$( "#hasta" ).datepicker({
		showOn: 'button',
		buttonImageOnly: true,
		beforeShow: customRange,
		changeMonth: true,
		changeYear: true,
		buttonImage: 'imagenes/ico_calendar.jpg',	
	    dateFormat:'dd-mm-yy',
		monthNames : [ 'Enero', 'Febrero', 'Marzo', 'Abril',	'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre',	'Octubre', 'Noviembre', 'Diciembre' ],
		monthNamesShort: ['Ene','Feb','Mar','Abr','May','Jun', 'Jul','Ago','Sep','Oct','Nov','Dic'],
		dayNames : [ 'Domingo', 'Lunes', 'Martes', 'Miercoles', 'Jueves', 'Viernes', 'Sabado' ],
		dayNamesShort : [ 'Dom', 'Lun', 'Mar', 'Mir', 'Jue', 'Vie','Sat' ],
		dayNamesMin : [ 'Do', 'Lu', 'Ma', 'Mi', 'Ju', 'Vi', 'Sa' ]
	});	
	  $(".multiselect").multiselect();	  
	  $(".multiselect").multiselect({sortable: false, searchable: false});
	  
	  $( "#tabs" ).tabs();	
		
	  $("#browser").treeview({collapsed: true});	
	  
		llamarDialogo();			
		llamarDialogo2();
}

function validaFormCreacion(){	
	$('#dniUsuario2').focus();
	$('#dniUsuario2').Rut({
		on_error : function() {
			   $("#dialog").html('Rut Usuario incorrecto');
	   			$("#dialog").dialog({
					modal: true,
					buttons: {
						Ok: function() {
							$( this ).dialog( "close" );
						}
					}
	   			});
	   			setTimeout(function() {
				$('#dniUsuario2').focus();
				$('#dniUsuario2').val('');
			}, 1);
		}
	});

	//Validacion de formulario de creacion
	$("#userform").validate({
        onfocusout: false,
        invalidHandler: function(form, validator) {
            var errors = validator.numberOfInvalids();
            if (errors) {
				   $("#dialog").html(validator.errorList[0].message);
		   			$("#dialog").dialog({
						modal: true,
						buttons: {
							Ok: function() {
								$( this ).dialog( "close" );
							}
						},
			   			close: function() {
			   				validator.errorList[0].element.focus();
			   			}
		   			});
            }
        },
		rules:{
			dniUsuario2: {required:true},
			nombreUsuario: {required:true},
			apellidoPaterno: {required:true},
			emailUsuario: {required:true, email: true},
			fonoUsuario: {required:true, digits:true},
			movilUsuario: {digits:true},
			rol: {required:true},
			desde: {required: true, date: true},
			hasta: {required: true, date: true},
			lugar: {required:true},
		},
		messages:{
			dniUsuario2:{required: "* Debe ingresar el rut del usuario"},
			nombreUsuario:{required: "* Debe ingresar el nombre del usuario"},
			emailUsuario: {required: 'Debe ingresar un correo electrónico', email: 'Debe ingresar el correo electrónico con el formato correcto. Por ejemplo: u@localhost.com' },
			fonoUsuario: {required:'Debe ingresar un teléfono', digits:'Debe ingresar solo números'},
			movilUsuario: {digits:'Debe ingresar solo números'},
			apellidoPaterno:{required:"* Debe ingresar el apellido paterno"},
			rol: {required: "* Seleccione un Rol para el usuario"},
			desde: {required: "* Ingrese una fecha a partir de la cual opera el usuario con el rol", date: 'Debe ingresar una fecha valida'},
			hasta: {required: "* Ingrese una fecha hasta la cual opera el usuario con este rol", date: 'Debe ingresar una fecha valida'},
			lugar: {required: "* Seleccione un lugar donde opera el usuario"}
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
				   if (jqXHR.getResponseHeader('REQUIRES_AUTH') == '1'){
					   $("#respuestaAccion").html(responseText);
					   cargaGrillaUsuarios();
				   }
				   //Manejo de error controlado
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
				   //Manejo de error no controlado
				   else{
					   $("body").html(responseText);
				   }
			   	}
		    });   
		}
	});
}

function validaFormEdicion(){	
	//Validacion de formulario de creacion
	$("#userform").validate({
        onfocusout: false,
        invalidHandler: function(form, validator) {
            var errors = validator.numberOfInvalids();
            if (errors) {
				   $("#dialog").html(validator.errorList[0].message);
		   			$("#dialog").dialog({
						modal: true,
						buttons: {
							Ok: function() {
								$( this ).dialog( "close" );
							}
						},
			   			close: function() {
			   				validator.errorList[0].element.focus();
			   			}
		   			});
            }
        },
		rules:{
			nombreUsuario: {required:true},
			apellidoPaterno: {required:true},
			emailUsuario: {required:true, email: true},
			fonoUsuario: {required:true, digits:true},
			movilUsuario: {digits:true},
			rol: {required:true},
			desde: {required: true, date: true},
			hasta: {required: true, date: true},
			lugar: {required:true},
		},
		messages:{
			nombreUsuario:{required: "* Debe ingresar el nombre del usuario"},
			emailUsuario: {required: 'Debe ingresar un correo electrónico', email: 'Debe ingresar el correo electrónico con el formato correcto. Por ejemplo: u@localhost.com' },
			fonoUsuario: {required:'Debe ingresar un teléfono', digits:'Debe ingresar solo números'},
			movilUsuario: {digits:'Debe ingresar solo números'},
			apellidoPaterno:{required:"* Debe ingresar el apellido paterno"},
			rol: {required: "* Seleccione un Rol para el usuario"},
			desde: {required: "* Ingrese una fecha a partir de la cual opera el usuario con el rol", date: 'Debe ingresar una fecha valida'},
			hasta: {required: "* Ingrese una fecha hasta la cual opera el usuario con este rol", date: 'Debe ingresar una fecha valida'},
			lugar: {required: "* Seleccione un lugar donde opera el usuario"}
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
				   if (jqXHR.getResponseHeader('REQUIRES_AUTH') == '1'){
					   $("#respuestaAccion").html(responseText);
					   cargaGrillaUsuarios();
				   }
				   //Manejo de error controlado
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
				   //Manejo de error no controlado
				   else{
					   $("body").html(responseText);
				   }
			   	}
		    });   
		}
	});
}

function cargaGrillaUsuarios(){
	jQuery("#detUsuarios").jqGrid({ 
		url:'fce?reqName=prglistausrxemp',
		datatype: "json",
	   	colNames:['RUT','Nombre','Apellido Paterno','Email','Telefono','Estado'],
	   	colModel:[
	  	   	{name:'Rut',index:'Rut', width:90, classes:'linkGrilla', searchtype:"integer", searchrules:{"required":true}, searchoptions: { sopt: ['eq']}},
	   		{name:'descripcion',index:'descripcion', width:130, search : false},
	   		{name:'apellidoPaterno',index:'apellidoPaterno', width:130, searchtype:"string", searchrules:{"required":true}, searchoptions: { sopt: ['cn']}},
	   		{name:'email',index:'email', width:160, search : false},
	   		{name:'telefono',index:'telefono', width:80, search : false},
	   		{name:'estado',index:'estado', width:70, search : false}   				
	   	],
	   	rowNum:10,
	   	rowList:[10,20,30],
	   	pager: '#pieDetUsuarios',
	   	sortname: 'id',
	    viewrecords: true,
	    sortorder: 'desc',
		jsonReader: {
			repeatitems : false,
			id: "id"
		},
		onSelectRow: function (id) {
			editarUsuario(id);
		},
		caption: "Listado de Usuarios",
		height: '100%'
		
		
	});
	jQuery("#detUsuarios").jqGrid('navGrid','#pieDetUsuarios',{edit:false,add:false,del:false, reload: true , search:true,searchtext:"Buscar"},
				{},
				{},
				{},
				{closeAfterSearch: true, onSearch: function() {	$('#detUsuarios').jqGrid('setGridParam', { rowNum: '50' }).trigger('reloadGrid');}}
	);
}

function customRange(input) { 
    var min = new Date(2003, 11 - 1, 1),
        dateMin = min,
        dateMax = null,
        dayRange = 3650; // Configura el numero de dias para el rango (10 años)

    if (input.id === "desde") {
        if ($("#hasta").datepicker("getDate") != null) {
            dateMax = $("#hasta").datepicker("getDate");
            dateMin = $("#hasta").datepicker("getDate");
            dateMin.setDate(dateMin.getDate() - dayRange);
            if (dateMin < min) {
                dateMin = min;
            }
        }
        else {
            dateMax = new Date; //Poner como maxima fecha
        }                      
    }
    else if (input.id === "hasta") {
        dateMax = new Date; //Poner como maxima fecha
        if ($("#desde").datepicker("getDate") != null) {
            dateMin = $("#desde").datepicker("getDate");
            var rangeMax = new Date(dateMin.getFullYear(), dateMin.getMonth(),dateMin.getDate() + dayRange);

            if(rangeMax < dateMax) {
                dateMax = rangeMax; 
            }
        }
    }
    return {
        minDate: dateMin, 
        maxDate: dateMax
    };     
}

function showDialogoRol(){
	$('#dialog-newRol').dialog('option', 'modal', true).dialog('open').dialog('option','resizable',false);
}

function showDialogoUnidad(){
	$('#dialog-newUnidad').dialog('option', 'modal', true).dialog('open').dialog('option','resizable',false);
}

function validaFormRol(){	
	//Validacion de formulario de creacion
	$("#rolform").validate({
        onfocusout: false,
        invalidHandler: function(form, validator) {
            var errors = validator.numberOfInvalids();
            if (errors) {
				   $("#dialog").html(validator.errorList[0].message);
		   			$("#dialog").dialog({
						modal: true,
						buttons: {
							Ok: function() {
								$( this ).dialog( "close" );
							}
						},
			   			close: function() {
			   				validator.errorList[0].element.focus();
			   			}
		   			});
            }
        },
		rules:{
			nombreRol: {required:true},
		},
		messages:{
			nombreRol:{required: "* Debe ingresar el nombre del rol"},
		},
        errorPlacement: function(error, element) {
            // Colaca los errores en un alert y no junto a los campos deformando la grafica //
        },
		submitHandler: function(){
			dataString = $("#rolform").serialize();
		    $.ajax({
		        url: "fce",
		        data: dataString,
		        context: document.body,
			   success: function(responseText, textStatus, jqXHR) {
				   if (jqXHR.getResponseHeader('REQUIRES_AUTH') == '1'){
					   $('#dialog-newRol').dialog( "close" );
					   $("#losroles").html(responseText);
				        //Handler para el evento de cambio de valor en el select del rol
				        $("#rol").change(function() {
				        	if($("#rol").val() == 'NEW')
				        		showDialogoRol();
				         });
				   }
				   //Manejo de error controlado
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
				   //Manejo de error no controlado
				   else{
					   $("body").html(responseText);
				   }
			   	}
		    });   
		}
	});
}

function validaFormLugar(){	
	//Validacion de formulario de creacion
	$("#unidadform").validate({
        onfocusout: false,
        invalidHandler: function(form, validator) {
            var errors = validator.numberOfInvalids();
            if (errors) {
				   $("#dialog").html(validator.errorList[0].message);
		   			$("#dialog").dialog({
						modal: true,
						buttons: {
							Ok: function() {
								$( this ).dialog( "close" );
							}
						},
			   			close: function() {
			   				validator.errorList[0].element.focus();
			   			}
		   			});
            }
        },
		rules:{
			nombreUnidad: {required:true},
		},
		messages:{
			nombreUnidad:{required: "* Debe ingresar el nombre del lugar"},
		},
        errorPlacement: function(error, element) {
            // Colaca los errores en un alert y no junto a los campos deformando la grafica //
        },
		submitHandler: function(){
			dataString = $("#unidadform").serialize();
		    $.ajax({
		        url: "fce",
		        data: dataString,
		        context: document.body,
			   success: function(responseText, textStatus, jqXHR) {
				   if (jqXHR.getResponseHeader('REQUIRES_AUTH') == '1'){
					   $('#dialog-newUnidad').dialog( "close" );
					   $("#lasunidades").html(responseText);
				        //Handler para el evento de cambio de valor en el select del rol
				        $("#lugar").change(function() {
				        	if($("#lugar").val() == 'NEW')
				        		showDialogoUnidad();
				         });
				   }
				   //Manejo de error controlado
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
				   //Manejo de error no controlado
				   else{
					   $("body").html(responseText);
				   }
			   	}
		    });   
		}
	});
}

