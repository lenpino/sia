<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<div class="header">
	<div class="cont_iconos_top_menu">
		<div class="contenedo_menu_top">
				<div class="icono_text_menu">
					<!-- <div class="icono_top_menu"><img src="<%=basePath%>imagenes/padlock.png" border="0" /></div> -->
					<div class="icono_top_menu"><img src="<%=basePath%>imagenes/candao.png" border="0" /></div>
					<div class="text_top_menu"><a href="<%=basePath%>fce?reqName=prglogoff" title="Salir"><font color="#ffffff">Cerrar Sesi&oacute;n</font></a></div>
				</div>

			<div class="icono_text_menu">
				<div class="icono_top_menu" style="padding-top:2px;"><img src="<%=basePath%>imagenes/email.png" /></div>
				<div class="text_top_menu">Contacto</div>
			</div>			
		</div>
	</div>
	
	<div class="banner">
		<div class="logo"><img src="<%=basePath%>imagenes/logo.png" width="240" height="68" /></div>
		<div class="titulo_header">
			<div class="titulo_banner_principal">Servicios de apoyo al negocio<br></div>
		</div>
	</div>
</div>