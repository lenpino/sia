<%@page import="cl.mycompany.perfilamiento.model.Usuario"%>
<%
	HttpSession sesion = request.getSession(true);
	Usuario usuario = (Usuario) sesion.getAttribute("usuario");
%>
<div class="banner_usuario">
	<div class="cont_usuario_empresa">
		<div class="cont_usuario">
			Nombre:
			<span class="estilo_text_usuario_empresa"><%=usuario.getNombre() + " " + usuario.getApellidoPaterno()
					+ " " + usuario.getApellidoMaterno()%></span>
		</div>
	</div>
	<div class="cont_usuario_empresa">
	</div>
</div>
