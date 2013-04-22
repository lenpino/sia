function cargaGrillaAplicaciones(){
	var idAplicacion;
	jQuery("#detAplicaciones").jqGrid({        
		url:'fce?reqName=prgAplicaciones',
		datatype: "json",
	   	colNames:['Nombre','WebRoot','Inicio'],
	   	colModel:[
	   		{name:'descripcion',index:'descripcion', width:200, search : true, editable: true, searchrules:{"required":true}, searchoptions: { sopt: ['cn']}, editrules:{required:true, number:false}},
	   		{name:'webroot',index:'webroot', width:210, search : false, editable: true, searchrules:{"required":true}, searchoptions: { sopt: ['cn']}, editrules:{required:true, number:false}},	   				
	   		{name:'inicio',index:'inicio', width:210, search : false, editable: true, searchrules:{"required":true}, searchoptions: { sopt: ['cn']}, editrules:{required:true, number:false}}	   				
	   	],
	   	rowNum:10,
	   	rowList:[10,20,30],
	   	pager: '#pieDetAplicaciones',
	   	sortname: 'id',
	    viewrecords: true,
	    sortorder: "desc",
		jsonReader: {
			repeatitems : false,
			id: "0"
		},
		onSelectRow: function (id) {
			idAplicacion = id;
		},
		caption: "Listado de Aplicaciones",
		height: '100%',
		width:950
		
	});
	jQuery("#detAplicaciones").jqGrid('navGrid','#pieDetAplicaciones',{edit:true,add:true,del:true, reload: true , search:true,searchtext:"Buscar"},

	{		
		url:'fce',
		editData: {reqName: "prgCrudAplicaciones", accion: "3"},
	    jqModal:false,
        closeAfterEdit:true,
        reloadAfterSubmit: true,
        afterSubmit: function(response, postdata) {
        	if (response.getResponseHeader('OK_FLAG') == '1') {
        		return [true,""];
        	}
        	else {
        		return [false, response.responseText]
        	}
        }
	},
	{
		url:'fce',
		editData: {reqName: "prgCrudAplicaciones", accion: "2"},
        jqModal:false,
        reloadAfterSubmit:true,
        closeAfterAdd:true,
        afterSubmit: function(response, postdata) {
        	if (response.getResponseHeader('OK_FLAG') == '1') {
        		return [true,""];
        	}
        	else {
        		return [false, response.responseText]
        	}
        }
	},
	{
		url:'fce?reqName=prgCrudAplicaciones&accion=1',
//		editData: {reqName: "prgCrudAplicaciones", accion: "1"},
        reloadAfterSubmit: true,
        jqModal: false, 
        closeAfterDel:true,
        afterSubmit: function(response, postdata) {
        	if (response.getResponseHeader('OK_FLAG') == '1') {
        		return [true,""];
        	}
        	else {
        		return [false, response.responseText]
        	}
        }
	},
	{closeAfterSearch: true }	
	);
}

$(document).ready(function() {
	cargaGrillaAplicaciones();  
	muestraMensaje();
	$("#lnkmantaplicaciones").on('click', function(){
		$.ajax({
	        url: "fce?reqName=prglink&pagina=salidaAplicacionesJSP",
	        context: document.body,
			success: function(responseText, textStatus, jqXHR) {
				$("#respuestaAccion").html(responseText, function() {
					$.getScript('js/jquery/js/jquery-1.8.0.min.js');
				});
				cargaGrillaAplicaciones();
			}
		});   
	});

	$("#lnkmantusuario").on('click', function(){
		$.ajax({
	        url: "fce?reqName=prglink&pagina=modificaUsuario",
	        context: document.body,
			success: function(responseText, textStatus, jqXHR) {
				$("#respuestaAccion").html(responseText, function() {
					$.getScript('js/jquery/js/jquery-1.8.0.min.js');
					$.getScript('js/portal/formDatosUsr.js');
					$.getScript('js/jquery/plugins/validationEngine/jquery.validationEngine.js');
					$.getScript('js/jquery/plugins/validationEngine/jquery.validationEngine-es.js');
				});
				cargaElementos();
			}
		});   
	});

});

function muestraMensaje(){
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
}
