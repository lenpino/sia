<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" media="screen" href="css/estilos.css" />
<link rel="stylesheet" type="text/css" media="screen" href="css/web_publica.css" />
<link rel="stylesheet" type="text/css" media="screen" href="css/estilosE.css" />
<link rel="stylesheet" type="text/css" media="screen" href="css/lightbiz/style.css" />
<link rel="stylesheet" type="text/css" media="screen" href="css/lightbiz/reset.css" />
<link rel="stylesheet" type="text/css" media="screen" href="css/lightbiz/forms.css" />
<link rel="stylesheet" type="text/css" media="screen" href="css/lightbiz/skeleton.css" />
<link rel="stylesheet" type="text/css" media="screen" href="js/jquery/css/ui-lightness/jquery-ui-1.8.23.custom.css" />
<link rel="stylesheet" type="text/css" media="screen" href="<%=basePath %>css/validationEngine/validationEngine.jquery.css" />


<script type="text/javascript" src="js/jquery/js/jquery-1.8.0.min.js"></script>
<script type="text/javascript"  src="js/jquery/js/jquery.validate.js"></script>
<script type="text/javascript"  src="js/jquery/js/jquery-ui-1.8.23.custom.min.js"></script>    
<script type="text/javascript" src="<%=basePath %>js/jquery/plugins/validationEngine/jquery.validationEngine.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jquery/plugins/validationEngine/jquery.validationEngine-es.js"></script>

<script type="text/javascript"  src="<%=basePath %>js/portal/formLogin.js"></script>

<title>ALTAIR</title>
</head>
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  style="background: #d5d7d4 url(<%=basePath%>images/bg.gif) top center repeat; ">
		<!--INICIO CONTENEDOR-->
		<div id="contenedor">
				<div id="contenedor_central">
					<!--INICIO HEADER-->
						<jsp:include flush="true" page="/jsp/intranet/header.jsp" />
					<!--FIN HEADER-->
					
					<!--INICIO CUERPO-->
					 <div>
						<section id="bajada">
							<div id="respuestaAccion" style="padding-top:160px; padding-left:340px; width:400px;">	
							<div id="tab2" class="main" style="width: 340px; height: 280px;">
								<form id="formularioLogIn" name="formularioLogIn">
								<fieldset style="border: 0px groove threedface;">
						           <div class="cont_form_pestanas" id="tabla" style="padding-left: 30px;">
						             <div class="titulo_grilla_top" style="font-size:18px;">Ingrese sus Datos</div>
						             <div class="cont_form_iz">
						               <div class="text_form_fila_new12" style="padding-top: 10px; width: 62px; ">Email:</div>
						               <div class="cont_box_formulario_general">
						                 <input name="email" id="email" type="text" class="form-textbox validate[required,custom[email]]" style="font-size: 11px; width:165px;" placeholder="ej: minombre@ejemplo.com">
						               </div>
						             </div>
						             <div class="cont_form_iz">
						               <div class="text_form_fila_new12 a" style="padding-top: 10px;">Clave:</div>
						               <div class="cont_box_formulario_general">
						                 <input name="webclave" id="webclave" type="password" class="form-textbox validate[required]" style="font-size: 11px; width:165px;" maxlength="12">
						               </div>
						               <div id="checkme" class="form-sub-label" style="padding-left: 155px; cursor: pointer;text-decoration: underline;">
						               	¿Ha olvidado su clave?
						               </div>
						             </div>
						             <div class="cont_boton_pestana2 border-bottom" style="padding-left: 85px; padding-bottom:20px;">
										<button id="submit" name="submit"  type="submit" class="button"  style="font-family: arial;font-size:12px;text-align:right; padding: 7px 9px 7px;">Inicio de sesión</button>
						             </div>
						           <div class="cont_form_pestanas">
						           	<div class="text_form_fila" style="float:none; width:auto;">
						           		¿No tiene una cuenta con nosotros?
						           	</div>
						           	<div class="text_form_fila_opcion2" style="float:none; width:auto;">
						           		Inscríbase gratuitamente aquí
						           	</div>
						           </div>
						           </div>
						           <input type="hidden" name="reqName" value="prglogin">           
						      		<div id="extra" style="padding-left: 19px; width:300px;">
						      			<div class="titulo_grilla_top" style="width:100%; font-size:18px;">Solicitud Nueva Clave</div>     			
						   				<div class="border-bottom" style="color: #999999; padding-bottom:10px; font-size:12px;">
											Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
										</div>
						      			
						      			<div class="cont_form_iz" style="padding-top:10px;">
							             	<label class="text_form_fila_new12 " style="padding-top: 10px; width: 62px; ">Email:</label>
							             	<div class="cont_box_formulario_general">
							             		<input name="emailc" id="emailc" class="form-textbox validate[required,custom[email]]" type="text" style="font-size: 11px; width:165px;" placeholder="ej: minombre@ejemplo.com">
							             	</div>
							             	<div id="back" class="form-sub-label" style="padding-left: 230px; cursor: pointer;text-decoration: underline;">Volver</div>             	
						            	</div>
						            	<span class="cont_boton_pestana2" style="padding-left: 95px; padding-top:0px;">
						            		<button type="button" class="button"  style="font-family: arial;font-size:12px;text-align:right; padding: 7px 9px 7px;" onclick="solicitaClave();">Solicitar clave</button>
						            	</span>
						            </div>
						           
						           </fieldset>
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
		<div id="dialog" title="Error de Ingreso" style="text-align: center;"></div>
	</body>
</html>