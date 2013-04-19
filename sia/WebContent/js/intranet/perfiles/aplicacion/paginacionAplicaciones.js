jQuery(document).ready(function(){
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
});

