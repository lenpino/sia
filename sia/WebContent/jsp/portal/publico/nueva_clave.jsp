<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String mensaje= request.getAttribute("mensaje") == null ? "": (String)request.getAttribute("mensaje");
%>
<!DOCTYPE html>
<html dir="ltr" lang="es-ES">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		
		<title>ALTAIR</title>
		<link rel="stylesheet" type="text/css" media="screen" href="<%=basePath %>js/jquery/css/ui-lightness/jquery-ui-1.8.23.custom.css" />
		<link rel="stylesheet" type="text/css" media="screen" href="<%=basePath %>css/estilos.css"  />
		<link rel="stylesheet" type="text/css" media="screen" href="<%=basePath %>css/nuevo.css"  />
		<link rel="stylesheet" type="text/css" media="screen" href="<%=basePath %>css/password.css"  />
		<link rel="stylesheet" type="text/css" media="screen" href="<%=basePath %>css/validationEngine/validationEngine.jquery.css" />
		<link rel="stylesheet" type="text/css" media="screen" href="<%=basePath %>css/lightbiz/style.css"  />
		
		<script type="text/javascript" src="<%=basePath %>js/jquery/js/jquery-1.8.0.min.js"></script>
		<script type="text/javascript"  src="<%=basePath %>js/jquery/js/jquery.validate.js"></script>
		<script type="text/javascript"  src="<%=basePath %>js/jquery/js/jquery-ui-1.8.23.custom.min.js"></script>
		<script type="text/javascript"  src="<%=basePath %>js/portal/setclave.js"></script>
		<script type="text/javascript" src="<%=basePath %>js/jquery/plugins/validationEngine/jquery.validationEngine.js"></script>
		<script type="text/javascript" src="<%=basePath %>js/jquery/plugins/validationEngine/jquery.validationEngine-es.js"></script>
		<script type="text/javascript"  src="<%=basePath %>js/comun/password.js"></script>
		

		
	</head>
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  style="background: #d5d7d4 url(<%=basePath%>images/body-tail.gif) top center repeat; ">
	
	<!--INICIO CONTENEDOR-->
		<div id="contenedor" class="contenedor">
			<div id="backSombraIzq"></div>
				<div id="contenedor_central">
		<!--INICIO HEADER-->
		<jsp:include flush="true" page="/jsp/portal/publico/header.jsp" />
		<!--FIN HEADER-->
			<!--INICIO CUERPO-->
            <section class="contenido" >
              <div class="cuerpo">                

                	<div class="contenedor_info" style="float:none; padding-left:250px;"">

                		<form name="form1"  id="form1" class="userform">
			                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
			                    <tr align="center" valign="top"> 
			                      <td> 
			                        <table width="100%" border="0" cellpadding="0" cellspacing="0" bordercolor="#FFFFFF"" bgcolor="#FFFFFF" height="190">
			                          <tr align="center" > 
			                            <td  bgcolor="#FFFFFF" class="titulo_grilla_top"  colspan="2" style="float:none; font-size:21px;" >&nbsp;&nbsp;<b><strong>Complete los siguientes campos<br></strong></b></td>
			                          </tr>
			                          <tr> 
			                            <td bgcolor="#FFFFFF" width="40%" align="right" height="30">&nbsp;</td>
			                            <!-- td width="60%" bgcolor="#FFFFDD" height="30">&nbsp;<br></td-->
			                          </tr>
			                                      <tr bgcolor="#FFFFFF"> 
			                                        <td	style="font-size: 14px; font-weight: bold;" height="30" align="right" >Email usuario:</td>
			                                        <td height="30" style="font-size: 16px; font-weight: bold; padding-left:20px;" height="30" width="21%"><%=mensaje%></tr>
			                                      <tr bgcolor="#FFFFFF"> 
			                                        <td style="font-size: 14px; font-weight: bold;" height="30" width="21%" align="right" >Ingrese Clave :</td>
			                                        <td height="30" width="79%" style="padding-left:20px;"> 
			                                          <input id="webclave1" name="webclave1" type="password" class="input validate[required,minSize[6]] text-input" size="15" maxlength="10">
			                                        </td>
			                                      </tr>
			                                      <tr bgcolor="#FFFFFF"> 
			                                        <td  style="font-size: 14px; font-weight: bold;" height="30" width="21%" align="right" >Repita la Clave :</td>
			                                        <td height="30" width="79%" style="padding-left:20px;"> 
			                                          <input id="webclave2"  name="webclave2" type="password" class="input validate[required,minSize[6],equals[webclave1]] text-input" size="15" maxlength="10" >
			                                        </td>
			                                      </tr>
			                        </table>
			                      </td>
			                    </tr>
			                    <tr align="center" valign="top"> 
			                      <td>&nbsp;</td>
			                    </tr>
			                    <tr align="center" valign="top"> 
			                      <td>
			                       <input name="continua" type="submit" class="button"  style="font-family: arial;font-size:18px;text-align:right; padding: 7px 9px 7px;" value="Continuar">  
			                      </td>	                       
			                    </tr>
			                    <tr align="center" valign="top">
			                      <td>&nbsp;</td>
			                    </tr>
			                  </table>
			             	<input type="hidden" name="reqName" value="prgsetclave">
			             	<input type="hidden" name="weblogin" value="<%=mensaje %>">
			             	<input type="hidden" name="token" value="<%=request.getParameter("token")%>">
							<input type="hidden" name="password">
							<input type="hidden" name="nuevo_password">
							<input type="hidden" name="web_rut">
			             </form>
                 </div>

            </div>
            </section>
            <!--FIN CUERPO-->
			</div>
			<div id="backSombraDer"></div>
			</div>						
		<!--FIN CONTENEDOR-->
		<div id="dialog" title="Error de Ingreso" style="text-align: center;"></div>
</body>
</html>		
	