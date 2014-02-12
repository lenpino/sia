<%
boolean flag = false;
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
HttpSession laSesion = request.getSession(false);
Integer elEstado = (Integer)laSesion.getAttribute("estado");
if(elEstado != null)
	flag = true;
%>
		<div id="header_cont">
			<div id="header_logo"><img src="<%=basePath %>imagenes/logo.png" border="0"/></div>
			<div id="header_barra">
				<div class="header_col_1"><img src="<%=basePath %>imagenes/chat.png" border="0"/></div>
				<div class="header_col_2"><a class="secciones" style="color: #FFFFFF;font-size:12px;" href="javascript:void(0);">Chat</a></div>
				<div class="header_col_1"><img src="<%=basePath %>imagenes/email.png" border="0"/></div>
				<div class="header_col_2"><a class="secciones" style="color: #FFFFFF;font-size:12px;" href="javascript:void(0);">Contacto</a></div>
				<div class="header_col_3"><img src="<%=basePath %>imagenes/telefono.png" border="0"/></div>
				<div class="header_col_2" style="color: #FFFFFF;font-size:12px;"><span class="secciones">(56)2 2xxxxxxx</span></div>
				<div class="header_col_4"><img src="<%=basePath %>imagenes/pxGris.png" border="0"/></div>
				<%if(flag){ %>
					<div class="header_col_5"><a href="<%=basePath%>fce?reqName=prglogoff" title="Salir">Cerrar Sesi&oacute;n</a></div>
				<%}%>	
			</div>
		</div>
		