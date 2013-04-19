<%@ page import="java.util.Date"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String mensaje;
mensaje = request.getAttribute("mensaje") == null ? "": (String)request.getAttribute("mensaje");
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
		<link rel="stylesheet" type="text/css" media="screen" href="<%=basePath %>css/lightbiz/style.css"  />

		
		<script type="text/javascript" src="<%=basePath %>js/jquery/js/jquery-1.8.0.min.js"></script>
		<script type="text/javascript"  src="<%=basePath %>js/jquery/js/jquery-ui-1.8.23.custom.min.js"></script>

	</head>
	
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  style="background: #d5d7d4 url(<%=basePath%>images/body-tail.gif) top center repeat; ">

<!--INICIO CONTENEDOR-->
<div class="contenedor">
	<!--INICIO HEADER-->
	<jsp:include flush="true" page="/jsp/portal/publico/header.jsp" />
	<!--FIN HEADER-->

			<!--INICIO CUERPO-->
			 <div class="contenedor">
			     <div class="cuerpo">
			     <div class="contenedor_info">
			     <div id="wraper">
					<div class="principal">
					<form name="form1" method="post">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr align="left" valign="top"> 
                        <td> 
                          <table width="731" border="0" cellpadding="0" cellspacing="0" class="tdbordetabla" height="21">
                            <tr bgcolor="#FFFFFF" align="left"> 
                              <td height="18" nowrap class="field"><b><strong>Su enlace presenta un problema</strong></b> 
                              </td>
                              <tr>
                            </tr>
                           
                              <td height="120" align="left" nowrap bgcolor="#FFFFFF"> 
                                <table width="727" border="0" cellspacing="0" cellpadding="0" height="31">                                 
                                  <tr> 
                                    <td> 
                                      <table width="100%" border="1" cellspacing="0" cellpadding="2" bordercolor="#FFFFFF" style="width: 723px;">
										<!--Quedo fuera por convencion de que no deberia mostrarse la passowrd, ni menos en un textbox-->
                                        <tr> 
                                        
                                     <div class="principal"> 
                                     <%=mensaje %> <br></tr>
                                     </div>                             
                                        <tr>
                                        
                                      </table>
                                    </td>
                                  </tr>
                                </table>
                              </td>
                          
                          </table>
                        </td>
                      </tr>                      
                        <tr align="center" valign="top"> 
                        <td>
                          <!-- input name="finaliza" type="button" class="botonenter1" onClick="javascript:finalizar();return false;" value="Finalizar"-->
                         <div class="volver"><a href="<%=basePath%>" title="Volver al Sistema"><img	src="imagenes/flecha_izquierda.png" /></div></a>	
                        </td>
                      </tr>
                    </table>
                    </form>
                    </div>
                    </div>
                    </div>
                    </div>
                    </div>

			
			<!--INICIO FOOTER-->
			<jsp:include flush="true" page="/jsp/comunes/footer.jsp" />
			<!--FIN FOOTER-->
		</div>
		<!--FIN CONTENEDOR-->
</body>
</html>		
	