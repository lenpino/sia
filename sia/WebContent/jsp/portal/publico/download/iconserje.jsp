<jsp:useBean id="url" class="java.lang.String" scope="request" />
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html dir="ltr" lang="es-ES">
	<head>
		<title>SIA</title>
		<link rel="stylesheet" type="text/css" media="screen" href="<%=basePath %>js/jquery/css/custom-theme/jquery-ui-1.8.23.custom.css" />
		<link rel="stylesheet" type="text/css" media="screen" href="<%=basePath %>css/estilos.css" />
		<link rel="stylesheet" type="text/css" media="screen" href="<%=basePath %>css/nuevo.css" />
 		<link rel="stylesheet" type="text/css" media="screen" href="<%=basePath %>css/menu.css" />
		<link rel="stylesheet" type="text/css" media="screen" href="<%=basePath %>css/lightbiz/style.css" />
		<link rel="stylesheet" type="text/css" media="screen" href="<%=basePath %>css/lightbiz/reset.css" />
		<link rel="stylesheet" type="text/css" media="screen" href="<%=basePath %>css/lightbiz/forms.css" />
		<link rel="stylesheet" type="text/css" media="screen" href="<%=basePath %>css/lightbiz/skeleton.css" />
		<link rel="stylesheet" type="text/css" media="screen" href="<%=basePath %>js/jquery/css/ui-lightness/jquery-ui-1.8.23.custom.css" />		
		<link href="icon/favicon.ico" rel="shortcut icon"/>
		
		
		<script type="text/javascript" src="<%=basePath %>js/jquery/js/jquery-1.8.0.min.js"></script>
		<script type="text/javascript"  src="<%=basePath %>js/jquery/js/jquery.validate.js"></script>
		<script type="text/javascript"  src="<%=basePath %>js/jquery/js/jquery-ui-1.8.23.custom.min.js"></script>    
		<script type="text/javascript"  src="<%=basePath %>js/jquery/js/jquery.Rut.js"></script>

	</head>

	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  style="background: #d5d7d4 url(<%=basePath%>images/bg.gif) top center repeat; ">
		<!--INICIO CONTENEDOR-->
		<div id="contenedor" class="contenedor">
				<div id="contenedor_central">
					<!--INICIO HEADER-->
						<jsp:include flush="true" page="/jsp/accesos/header.jsp" />
					<!--FIN HEADER-->
					
					<!--INICIO CUERPO-->
					 <div>
						<section id="bajada">
							<div id="respuestaAccion" style="padding-left:10px; width:100%; background-image: url(<%=basePath%>images/pxGris.png);">
							<div>
								<a class="button" href="<%=basePath %>recursos/iconserje/iConserje.exe" rel="nofollow">Bajar Aqui</a>
								<span>&nbsp;&nbsp;iConserje version 0.2.1</span>
							</div>
							</div>
						</section>
					  </div>
					<!--FIN CUERPO-->
				</div>
		</div>
		<!--FIN CONTENEDOR-->
		<div id="dialog" title="Error de Ingreso" style="text-align: center;"></div>
		</body>
</html>
