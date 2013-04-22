<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>

<jsp:useBean id="perfil"  class="cl.altair.perfilamiento.control.PerfilAltair" scope="session" />
<jsp:useBean id="usuario" class="cl.mycompany.perfilamiento.model.Usuario" scope="session" />
<jsp:useBean id="elusuariorol" class="cl.mycompany.perfilamiento.model.UsuarioRol" scope="request" />
<%
	java.text.SimpleDateFormat fmt = new java.text.SimpleDateFormat("dd-MM-yyyy");
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<div style="padding-left:200px;padding-top:40px;">
<form id="userform" name="formularioPrincipalUsuario" action="fce" method="post">
	<div style="width:430px; height:350px; padding:5px; margin:0 auto; border: 1px solid #CCCCCC; border-radius: 7px 7px 7px 7px;">
		<div style="width:383px; height:40px; float:left; font-weight:bold; text-align:left; padding:0 0 0 45px; margin-bottom:10px; color:#fa4616; background-color:#F1F1F1; border: 1px solid #ededed;">
		<div style="margin:10px 0 0 0; font-size:15px;">Datos de Usuario:</div>
	</div>
		<div style="float:left; margin:0 0 4px 0;">
			<div style="width:148px; height:22px; float:left; text-align:left; margin:0 5px 0 40px; padding:0 0 0 5px; background-color:#F1F1F1; border:1px solid #ededed;"><span style="color:#525559; font-size:12px;">Nombre Usuario:</span><span style="float:right; color:#ff6916; font-size:12px; padding:0 5px 0 0;">*</span></div>
			<div style="width:190px; float:left; text-align:left;"><input class="form-textbox validate[required]" type="text" style="width:190px; border:1px solid #ededed; padding:0 0 0 3px; height: 22px;" name="nombreUsuario" id="nombreUsuario" value="<%=usuario.getNombre()%>" size="25"  maxlength="30"/><p class="hint">Ingrese nombre.</p></div>
		</div>
		<div style="float:left; margin:0 0 4px 0;">
			<div style="width:148px; height:22px; float:left; text-align:left; margin:0 5px 0 40px; padding:0 0 0 5px; background-color:#F1F1F1; border:1px solid #ededed;"><span style="color:#525559; font-size:12px;">Segundo Nombre:</span></div>
			<div style="width:190px; float:left; text-align:left;"><input class="form-textbox" type="text" style="width:190px; border:1px solid #ededed; padding:0 0 0 3px; height: 22px;" name="segNombreUsuario" id="segNombreUsuario" value="<%=usuario.getSegundoNombre() == null ? "" : usuario.getSegundoNombre()%>" size="25" maxlength="30"/></div>
		</div>
		<div style="float:left; margin:0 0 4px 0;">
			<div style="width:148px; height:22px; float:left; text-align:left; margin:0 5px 0 40px; padding:0 0 0 5px; background-color:#F1F1F1; border:1px solid #ededed;"><span style="color:#525559; font-size:12px;">Apellido Paterno:</span><span style="float:right; color:#ff6916; font-size:12px; padding:0 5px 0 0;">*</span></div>
			<div style="width:190px; float:left; text-align:left;"><input class="form-textbox validate[required]" type="text" style="width:190px; border:1px solid #ededed; padding:0 0 0 3px; height: 22px;" name="apellidoPaterno" id="apellidoPaterno" value="<%=usuario.getApellidoPaterno()%>" size="25" onblur="revisar_apellidoPaterno()" maxlength="30"/></div>
		</div>
		<div style="float:left; margin:0 0 4px 0;">
			<div style="width:148px; height:22px; float:left; text-align:left; margin:0 5px 0 40px; padding:0 0 0 5px; background-color:#F1F1F1; border:1px solid #ededed;"><span style="color:#525559; font-size:12px;">Apellido Materno:</span></div>
			<div style="width:190px; float:left; text-align:left;"><input class="form-textbox" type="text" style="width:190px; border:1px solid #ededed; padding: 0 0 0 3px; height: 22px;" name="apellidoMaterno" value="<%=usuario.getApellidoMaterno() == null ? "" : usuario.getApellidoMaterno()%>" size="25" maxlength="30"/></div>
		</div>
		<div style="float:left; margin:0 0 4px 0;">
			<div style="width:148px; height:22px; float:left; text-align:left; margin:0 5px 0 40px; padding:0 0 0 5px; background-color:#F1F1F1; border:1px solid #ededed;"><span style="color:#525559; font-size:12px;">Email:</span><span style="float:right; color:#ff6916; font-size:12px; padding:0 5px 0 0;">*</span></div>
			<div style="width:190px; float:left; text-align:left;"><input class="form-textbox validate[required,custom[email]]" type="text" style="width:190px; border:1px solid #ededed; padding: 0 0 0 3px; height: 22px;" name="emailUsuario" id="emailUsuario"	value="<%=usuario.getEmail()%>" size="25" /></div>
		</div>
		<div style="float:left; margin:0 0 4px 0;">
			<div style="width:148px; height:22px; float:left; text-align:left; margin:0 5px 0 40px; padding:0 0 0 5px; background-color:#F1F1F1; border:1px solid #ededed;"><span style="color:#525559; font-size:12px;">Fecha Nacimiento:</span><span style="float:right; color:#ff6916; font-size:12px; padding:0 5px 0 0;">*</span></div>
			<div style="width:194px; float:left; text-align:left;"><input class="form-textbox" type="text" style="width:162px; border:1px solid #ededed; padding:0 0 0 3px; height:22px;" readonly="readonly" size="25" maxlength="11" id="fechanac" name="fechanac" value="<%=fmt.format(usuario.getFechaNacimiento())%>"></div>
		</div>
		<div style="float:left; margin:0 0 4px 0;">
			<div style="width:148px; height:22px; float:left; text-align:left; margin:0 5px 0 40px; padding:0 0 0 5px; background-color:#F1F1F1; border:1px solid #ededed;"><span style="color:#525559; font-size:12px;">Sexo:</span></div>
			<div style="width:190px; float:left; text-align:left;">
			<select style="width:198px; border:1px solid #ededed; padding:0 0 0 3px; height:22px;" name="sexoUsuario" id="sexoUsuario" >
				<OPTION <%=usuario.getSexo().equalsIgnoreCase("F") ? "selected " : ""%> VALUE="F">Femenino</OPTION>
				<OPTION <%=usuario.getSexo().equalsIgnoreCase("M") ? "selected " : ""%>VALUE="M">Masculino</OPTION>
			</select>
			</div>
		</div>
		<div style="float:left; margin:0 0 4px 0;">
			<div style="width:148px; height:22px; float:left; text-align:left; margin:0 5px 0 40px; padding:0 0 0 5px; background-color:#F1F1F1; border:1px solid #ededed;"><span style="color:#525559; font-size:12px;">Telefono:</span><span style="float:right; color:#ff6916; font-size:12px; padding:0 5px 0 0;">*</span></div>
			<div style="width:190px; float:left; text-align:left;"><input class="form-textbox validate[required]" type="text" style="width:190px; border:1px solid #ededed; padding:0 0 0 3px; height:22px;" name="fonoUsuario" id="fonoUsuario" value="<%=usuario.getFono() == null ? "" : usuario.getFono()%>" size="25"  maxlength="9"/></div>
		</div>
		<div style="float:left; margin:0 0 4px 0;">
			<div style="width:148px; height:22px; float:left; text-align:left; margin:0 5px 0 40px; padding:0 0 0 5px; background-color:#F1F1F1; border:1px solid #ededed;"><span style="color:#525559; font-size:12px;">Celular:</span></div>
			<div style="width:190px; float:left; text-align:left;"><input class="form-textbox" type="text" style="width:190px; border:1px solid #ededed; padding:0 0 0 3px; height:22px;" name="movilUsuario" id="movilUsuario" value="<%=usuario.getMovil() == null ? "" : usuario.getMovil()%>" size="25" maxlength="11"/></div>
		</div>
		<div style="float:left; margin:0 0 4px 0;">
			<div style="width:148px; float:left; text-align:left; margin:0 5px 0 40px; padding:2px 0 1px 5px; border:1px solid #ffffff;">&nbsp;</div>
			<div style="width:190px; float:left; text-align:left;">
			<input class="input"  type="hidden"	value="prggrabausuario" name="reqName" id="reqName">
			<input id="submit" name="submit" type="submit" class="button" style="font-family: arial;font-size:12px;text-align:right; float:none; padding: 7px 11px 5px 11px;" value="Grabar" onclick="callFce()"/>
			</div>
		</div>
	</div>
</form>	
</div>

		
		
		



	