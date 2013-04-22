<jsp:useBean id="url" class="java.lang.String" scope="request" />
<jsp:useBean id="msg" class="java.lang.String" scope="request" />
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html dir="ltr" lang="es-ES">
	<head>
		<title>Synnex - Aplicaciones</title>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="Tue, 03 Jul 2001 06:00:00 GMT">

		<script type="text/javascript" src="<%=basePath %>js/jquery/js/jquery-1.8.0.min.js"></script>
		<script type="text/javascript"  src="<%=basePath %>js/jquery/js/jquery-ui-1.8.23.custom.min.js"></script>
		<script type="text/javascript"  src="<%=basePath %>js/jquery/js/jquery.Rut.js"></script>
		<script type="text/javascript"  src="<%=basePath %>js/jquery/js/jquery.validate.js"></script>
		<script type="text/javascript" src="<%=basePath %>js/jquery/plugins/jqgrid/src/i18n/grid.locale-es.js"></script>
		<script type="text/javascript" src="<%=basePath %>js/jquery/plugins/jqgrid/js/jquery.jqGrid.min.js"></script>
		<script type="text/javascript" src="<%=basePath %>js/intranet/template.js"></script>
		
		<script type="text/javascript"  src="<%=basePath %>js/portal/formDatosUsr.js"></script>
		<script type="text/javascript" src="<%=basePath %>js/jquery/plugins/validationEngine/jquery.validationEngine.js"></script>
		<script type="text/javascript" src="<%=basePath %>js/jquery/plugins/validationEngine/jquery.validationEngine-es.js"></script>
		<script type="text/javascript" src="<%=basePath %>js/jquery/plugins/jquery.combobox.js"></script>

		
		<link rel="stylesheet" type="text/css" media="screen" href="<%=basePath %>js/jquery/css/ui-lightness/jquery-ui-1.8.23.custom.css" />
		<link rel="stylesheet" type="text/css" media="screen" href="<%=basePath %>css/estilos.css" />
		<link rel="stylesheet" type="text/css" media="screen" href="<%=basePath %>css/estilosE.css" />
		<link rel="stylesheet" type="text/css" media="screen" href="<%=basePath %>css/nuevo.css" />
 		<link rel="stylesheet" type="text/css" media="screen" href="<%=basePath %>css/menu.css" />
 		<link rel="stylesheet" type="text/css" media="screen" href="<%=basePath %>css/lightbiz/style.css" />
		<link rel="stylesheet" type="text/css" media="screen" href="<%=basePath %>css/lightbiz/reset.css" />
		<link rel="stylesheet" type="text/css" media="screen" href="<%=basePath %>css/lightbiz/forms.css" />
		<link rel="stylesheet" type="text/css" media="screen" href="<%=basePath %>css/lightbiz/skeleton.css" />
 		<link rel="stylesheet" type="text/css" media="screen" href="<%=basePath %>js/jquery/plugins/jqgrid/css/ui.jqgrid.css" />
		<link rel="stylesheet" type="text/css" media="screen" href="<%=basePath %>js/jquery/plugins/jqgrid/plugins/ui.multiselect.css" />
		<link rel="stylesheet" type="text/css" media="screen" href="<%=basePath %>css/validationEngine/validationEngine.jquery.css" />
 		
		<link href="icon/favicon.ico" rel="shortcut icon"/>
	</head>

	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  style="background: #d5d7d4 url(<%=basePath%>images/bg.gif) top center repeat; ">
		<!--INICIO CONTENEDOR-->
		<div id="contenedor" class="contenedor">
				<div id="contenedor_central">
					<!--INICIO HEADER-->
						<jsp:include flush="true" page="/jsp/intranet/header.jsp" />
					<!--FIN HEADER-->
					
	          		<!--INICIO BARRA DE CONTEXTO-->
						<jsp:include flush="true" page="/jsp/intranet/barracontexto.jsp" />
					<!--FIN BARRA DE CONTEXTO-->
					
					<!-- INICIO MENU -->
						<jsp:include flush="true" page="/jsp/intranet/menu.jsp" />
					<!-- FIN MENU -->
					
					<!--INICIO CUERPO-->
					 <div>
						<section id="bajada">
							<div id="respuestaAccion" style="padding-left:10px; width:100%; background-image: url(<%=basePath%>images/pxGris.png);">
							</div>
						</section>
					  </div>
					<!--FIN CUERPO-->
				</div>
		</div>
		<!--FIN CONTENEDOR-->
		
		<div id="dialog" title="Error de Ingreso" style="text-align: center;"><%=msg%></div>
		</body>
</html>