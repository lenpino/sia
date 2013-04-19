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
		
		<link href="icon/favicon.ico" rel="shortcut icon"/>
		
		
		<script type="text/javascript" src="<%=basePath %>js/jquery/js/jquery-1.8.0.min.js"></script>
		<script type="text/javascript"  src="<%=basePath %>js/jquery/js/jquery.validate.js"></script>
		<script type="text/javascript"  src="<%=basePath %>js/jquery/js/jquery-ui-1.8.23.custom.min.js"></script>    
		<script type="text/javascript"  src="<%=basePath %>js/jquery/js/jquery.Rut.js"></script>

	</head>

	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  style="background: #d5d7d4 url(<%=basePath%>images/body-tail.gif) top center repeat; ">
		<!--INICIO CONTENEDOR-->
		<div id="contenedor" class="contenedor">
			<div id="backSombraIzq"></div>
				<div id="contenedor_central">
					<!--INICIO HEADER-->
						<jsp:include flush="true" page="/jsp/accesos/header.jsp" />
					<!--FIN HEADER-->
					
	          		<!--INICIO BARRA DE CONTEXTO-->
						<jsp:include flush="true" page="/jsp/accesos/barracontexto.jsp" />
					<!--FIN BARRA DE CONTEXTO-->
					
					<!-- INICIO MENU -->
						<jsp:include flush="true" page="/jsp/accesos/menu.jsp" />
					<!-- FIN MENU -->
					
					<!--INICIO CUERPO-->
					 <div class="cuerpo_">
					        <div class="container_">
								<section id="bajada">
									<div id=.pag_interior>
										<div id="respuestaAccion" style="padding-left:20px; width:100%">
										</div>
									</div>
								</section>
							</div>
					  </div>
					<!--FIN CUERPO-->
				</div>
			<div id="backSombraDer"></div>
		</div>
		<!--FIN CONTENEDOR-->
		
		<!--INICIO FOOTER-->
  	<!--		<jsp:include flush="true" page="/jsp/comunes/footer.jsp" /> -->
  		<!--FIN FOOTER--> 
  
		<div id="dialog" title="Error de Ingreso" style="text-align: center;"></div>
		</body>
</html>
