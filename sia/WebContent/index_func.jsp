<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html dir="ltr" lang="es-ES">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO8859-1" />
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="Tue, 03 Jul 2001 06:00:00 GMT">

<title>SIA</title>
<link rel="stylesheet" type="text/css" media="screen" href="js/jquery/css/custom-theme/jquery-ui-1.8.23.custom.css" />
<link rel="stylesheet" type="text/css" media="screen" href="css/themes/acepta/jquery.ui.tabs.css" />
<link rel="stylesheet" type="text/css" media="screen" href="css/estilos.css" />
<link rel="stylesheet" type="text/css" media="screen" href="css/nuevo.css" />
<link rel="stylesheet" type="text/css" media="screen" href="css/menu.css" />

<link href="icon/favicon.ico" rel="shortcut icon"/>


<script type="text/javascript" src="js/jquery/js/jquery-1.8.0.min.js"></script>
<script type="text/javascript"  src="js/jquery/js/jquery.validate.js"></script>
<script type="text/javascript"  src="js/jquery/js/jquery-ui-1.8.23.custom.min.js"></script>    
<script type="text/javascript"  src="js/jquery/js/jquery.Rut.js"></script>

</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  style="background: #d5d7d4 url(imagenes/bg.jpg) top repeat-x; ">

<!--INICIO CONTENEDOR-->
<div class="contenedor">
	<!--INICIO HEADER-->
	<jsp:include flush="true" page="/jsp/comunes/header.jsp" />
	<!--FIN HEADER-->
	
	<!--INICIO CUERPO-->
	<div class="cuerpo">
		<div>
			<!--INICIO BARRA DE CONTEXTO-->
			<jsp:include flush="true" page="/jsp/comunes/barracontexto.jsp" />
			<!--FIN BARRA DE CONTEXTO-->
		</div>
		<div>
			<!--INICIO MENU LATERAL-->
			<jsp:include flush="true" page="/jsp/comunes/menu.jsp" />
			<!--FIN MENU LATERAL-->
		</div>
		
		<div class="contenedor_info">
			<div class="fondo_middle_cont_form">
				<!--INICIO CONTENIDO PROPIO DE LA FUNCIONALIDAD-->
				<section class="contenido">
					<section id="bajada">
						<div id=.pag_interior>
							<div id="respuestaAccion" style="padding-left:20px; width:100%">
							</div>
						</div>
					</section>
				</section>
				<!--FIN CONTENIDO PROPIO DE LA FUNCIONALIDAD-->
			</div>
		</div>
  </div>
  <!--FIN CUERPO-->
  
  <!--INICIO FOOTER-->
  <jsp:include flush="true" page="/jsp/comunes/footer.jsp" />
  <!--FIN FOOTER-->  
</div>
<!--FIN CONTENEDOR-->

</body>
</html>