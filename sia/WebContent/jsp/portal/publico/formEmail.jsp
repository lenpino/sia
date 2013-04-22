<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html dir="ltr" lang="es-ES">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO8859-1" />
	<title>ALTAIR</title>
	<link rel="stylesheet" type="text/css" media="screen" href="<%=basePath %>js/jquery/css/ui-lightness/jquery-ui-1.8.23.custom.css" />
	<link rel="stylesheet" type="text/css" media="screen" href="<%=basePath %>css/estilos.css"  />
	<link rel="stylesheet" type="text/css" media="screen" href="<%=basePath %>css/estilosE.css" />
	<link rel="stylesheet" type="text/css" media="screen" href="<%=basePath %>css/nuevo.css"  />
	<link rel="stylesheet" type="text/css" media="screen" href="<%=basePath %>css/menu.css" />
	<link rel="stylesheet" type="text/css" media="screen" href="<%=basePath %>css/lightbiz/style.css" />
	<link rel="stylesheet" type="text/css" media="screen" href="<%=basePath %>css/lightbiz/reset.css" />
	<link rel="stylesheet" type="text/css" media="screen" href="<%=basePath %>css/lightbiz/forms.css" />
	<link rel="stylesheet" type="text/css" media="screen" href="<%=basePath %>css/lightbiz/skeleton.css" />
	<link rel="stylesheet" type="text/css" media="screen" href="<%=basePath %>css/validationEngine/validationEngine.jquery.css" />
	
	<link href="<%=basePath %>icon/favicon.ico" rel="shortcut icon"/>
	
	
	<script type="text/javascript" src="<%=basePath %>js/jquery/js/jquery-1.8.0.min.js"></script>
	<script type="text/javascript"  src="<%=basePath %>js/jquery/js/jquery.validate.js"></script>
	<script type="text/javascript"  src="<%=basePath %>js/jquery/js/jquery-ui-1.8.23.custom.min.js"></script>
	<script type="text/javascript"  src="<%=basePath %>js/portal/formEmail.js"></script>
	 <script type="text/javascript" src="<%=basePath %>js/jquery/plugins/validationEngine/jquery.validationEngine.js"></script>
	 <script type="text/javascript" src="<%=basePath %>js/jquery/plugins/validationEngine/jquery.validationEngine-es.js"></script>
	 <script type="text/javascript" src="<%=basePath %>js/jquery/plugins/jquery.combobox.js"></script>
 
</head>
  
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  style="background: #d5d7d4 url(<%=basePath%>images/bg.gif) top center repeat; ">

<!--INICIO CONTENEDOR-->
<div id="contenedor">
	<div id="contenedor_central">

		<!--INICIO HEADER-->
		<jsp:include flush="true" page="/jsp/portal/header.jsp" />
		<!--FIN HEADER-->
	
			<!--INICIO CUERPO-->
				<div>
					<section id="bajada">
						<div id=.pag_interior>
							<div id="respuestaAccion" style="padding-left:100px; width:770px;">
								<form id="formEmail" action="" method="post" style="padding-top:90px;">
									<input type="hidden" name="reqName" id="reqName"/>
									
									<div class="userform" style="width:720px;">
										<strong>IPSUM LOREN</strong><br/><br/>
										Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.<br/><br/>
										Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.<br/><br/>
										Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.<br/><br/>
									</div>
									
									<br/>
									
									<div class="userform" style="width:653px; padding-left:88px;">

									
											<table style="width:500px;">
												<tr>
													<td style="float:right;">
													 <div class="cont_form_iz" style="width:350px;">
										               <div class="text_form_fila_new12" style="padding-top: 10px; width: 128px; ">Correo Electronico:</div>
										               <div class="cont_box_formulario_general">
										                 <input class="form-textbox validate[required,custom[email]]" type="text" name="emailUsuario" id= "emailUsuario" style="font-size: 11px; width:165px;" placeholder="ej: minombre@ejemplo.com"  maxlength="30"/>
										               </div>
										             </div>
													<td style="vertical-align:top;">
														<button id="submit" name="submit" type="submit" class="button"  style="font-family: arial;font-size:12px;text-align:right; float:none; padding: 7px 11px 5px 11px;">Enviar</button>
													</td>
												</tr>
											</table>
										
									</div>
								</form>
							</div>
						</div>
					</section>
  				</div>
  			<!--FIN CUERPO-->
  			
  		<!--INICIO FOOTER-->
  		<jsp:include flush="true" page="/jsp/comunes/footer.jsp" />
  		<!--FIN FOOTER-->  
  			
  	</div>
</div>
<!--FIN CONTENEDOR-->
<div id="dialog" title="Error de Ingreso" style="text-align: center;"></div>
</body>
</html>
