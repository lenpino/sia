<%@ page language="java" contentType="text/html; charset=ISO-8859-1" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<div id="menu_cont">
	<ul id="menu">
		<li><a href="#" class="drop">Servicios</a>
			<div class="dropdown_1column">
				<div class="col_2">
					<ul>
						<li><a href="#">Cambio de Password</a></li>
					</ul>
				</div>
				
				<div class="col_2">
					<h3>Correspondencia</h3>
					<div class="col_2">
						<ul>
							<li><a href="#">Ingreso</a></li>
							<li><a href="#">Entrega</a></li>
						</ul>
					</div>
				</div>
			</div>
		</li>
	    <li><a href="#" class="drop">Reportes</a>
	    	<div class="dropdown_4columns">
	    		<div class="col_4">
	    			<h2>Opciones de Reportes</h2>
	    		</div>
	            
	            <div class="col_1">
	            	<h3>Administraci&oacute;n</h3>
	            	<ul>
	            		<li><a href="#">Documento Proveedores</a></li>
	            		<li><a href="#">Recepci&oacute;n Productos</a></li>
	            		<li><a href="#">Pago Proveedores</a></li>
	            		<li><a href="#">Cobranza</a></li>
	            		<li><a href="#">Personal Fuera Oficina</a></li>
	            	</ul>
	            </div>
	            
	            <div class="col_1">
	            	<h3>Ventas</h3>
	            	<ul>
	            		<li><a href="#">Ventas Mes</a></li>
	                    <li><a href="#">Ventas Año</a></li>
	                    <li><a href="#">Ventas por L&iacute;nea de Productos</a></li>
	                    <li><a href="#">Ventas por Producto</a></li>
	                    <li><a href="#">Archivo Carga Manager</a></li>
	                    <li><a href="#">Cuentas por Cobrar por Ejecutivo</a></li>                    
	                </ul>   
				</div>
				
				<div class="col_1">
					<h3>Contratos</h3>
					<ul>
						<li><a href="#">Clientes</a></li>
	                    <li><a href="#">Proveedores</a></li>
	                    <li><a href="#">Trabajadores</a></li>
	                </ul>
				</div>
	    
	            <div class="col_1">
	                <h3>SGC</h3>
	                <ul>
	                    <li><a href="#">ADF-04 Listado Proveedores</a></li>
	                    <li><a href="#">ADF-23 Evaluaci&oacute;n Proveedores</a></li>
	                </ul>   
	            </div>
	            
				<div class="col_1">
					<h3>Registros</h3>
	                <ul>
	                    <li><a href="#">Uso CRM</a></li>
	                </ul>   
	            </div>
			</div>
		</li>
		<li><a href="#" class="drop">Mantenedores</a>
			<div class="dropdown_1column">
				<div class="col_1">
				    <ul class="simple">
				        <li><a href="#" class="listMant" id="lnkmantusuarios">Usuarios</a></li>
				        <li><a href="#" class="listMant" id="lnkmanroles">Roles</a></li>
				        <li><a href="#" class="listMant" id="lnkmantestados">Estados</a></li>
				        <li><a href="#" class="listMant" id="lnkmantpaises">Paises</a></li>
				        <li><a href="#" class="listMant" id="lnkmantaplicaciones">Aplicaciones</a></li>
				        <li><a href="#" class="listMant" id="lnkmantempresas">Empresas</a></li>
				        <li><a href="#" class="listMant" id="lnkmantholding">Holding</a></li>
				    </ul>
				</div>
			</div>
		</li>
		<li><a href="#" class="drop">Soporte</a>
			<div class="dropdown_1column">
				<div class="col_1">
				    <ul class="simple">
				        <li><a href="#" class="listMant" id="lnkmantusuarios">Usuarios</a></li>
				    </ul>
				</div>
			</div>
		</li>	
		<li style="float:right;"><a href="#" class="drop">Leonardo Pino</a>
			<div class="dropdown_2columns">
				<div class="col_2">
					<ul style="margin:0 0 1px 0;">
						<li><a target="frame" href="<%=basePath%>fce?reqName=prglink&pagina=modificaUsuario">&nbsp;Editar Usuario</a></li>
						<li><a href="javascript:void(0);">&nbsp;Cambiar Perfil Activo</a></li>
						<li><a target="frame" href="<%=basePath%>fce?reqName=prglink&pagina=cambiaclave">&nbsp;Cambiar Contrase&ntilde;a</a></li>
					</ul>
				</div>
			</div>
		</li>
		
	</ul>
</div>