<%@page import="cl.mycompany.perfilamiento.model.Empresa"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	Empresa activa = (Empresa)session.getAttribute("empresaActiva");
%>
		<div id="contexto_cont">
			<div id="contexto_tit">INTRANET SYNNEX</div>
				<div id="contexto_emp">
					Empresa:&nbsp;&nbsp;<span id="empresasel" class="estilo_text_usuario_empresa"><%=activa.getNombre() %></span>
				</div>
		</div>
		<div class="bordeNormal"></div>
