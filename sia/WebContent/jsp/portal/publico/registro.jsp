<%@page contentType="text/html;charset=UTF-8"%>
<jsp:useBean id="codigo" scope="request" class="java.lang.String" />
<jsp:useBean id="email" scope="request" class="java.lang.String" />
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html dir="ltr" lang="es-ES">
<head>

	<title>ALTAIR</title>
	<link rel="stylesheet" type="text/css" media="screen" href="<%=basePath %>js/jquery/css/synnex/jquery-ui-1.10.3.custom.css" />
	<link rel="stylesheet" type="text/css" media="screen" href="<%=basePath %>css/estilos.css"  />
	<link rel="stylesheet" type="text/css" media="screen" href="<%=basePath %>css/nuevo.css"  />
	<link rel="stylesheet" type="text/css" media="screen" href="<%=basePath %>css/menu.css" />
	<link rel="stylesheet" type="text/css" media="screen" href="<%=basePath %>css/validationEngine/validationEngine.jquery.css" />
	<link rel="stylesheet" type="text/css" media="screen" href="<%=basePath %>css/smartWizard/smart_wizard.css"  />
	<link rel="stylesheet" type="text/css" media="screen" href="<%=basePath %>css/lightbiz/style.css" />
	<link rel="stylesheet" type="text/css" media="screen" href="<%=basePath %>css/lightbiz/reset.css" />
	<link rel="stylesheet" type="text/css" media="screen" href="<%=basePath %>css/lightbiz/forms.css" />
	<link rel="stylesheet" type="text/css" media="screen" href="<%=basePath %>css/lightbiz/skeleton.css" />
	<link rel="stylesheet" type="text/css" media="screen" href="<%=basePath %>js/jquery/plugins/passfield/passfield.min.css" />
	
	<link href="<%=basePath %>icon/favicon.ico" rel="shortcut icon"/>
	
	
	<script type="text/javascript" src="<%=basePath %>js/jquery/js/jquery-1.8.0.min.js"></script>
	<script type="text/javascript"  src="<%=basePath %>js/jquery/js/jquery.validate.js"></script>
	<script type="text/javascript"  src="<%=basePath %>js/jquery/js/jquery-ui-1.8.23.custom.min.js"></script>
	<script type="text/javascript" src="<%=basePath %>js/jquery/plugins/validationEngine/jquery.validationEngine.js"></script>
	<script type="text/javascript" src="<%=basePath %>js/jquery/plugins/validationEngine/jquery.validationEngine-es.js"></script>
	<script type="text/javascript" src="<%=basePath %>js/jquery/plugins/jquery.combobox.js"></script>
	<script type="text/javascript" src="<%=basePath %>js/jquery/plugins/passfield/passfield.min.js"></script>
	<script type="text/javascript"  src="<%=basePath %>js/jquery/plugins/smartWizard/jquery.smartWizard.js"></script>
	<script type="text/javascript"  src="<%=basePath %>js/jquery/js/jquery.Rut.js"></script>
	<script type="text/javascript"  src="<%=basePath %>js/portal/registro.js"></script>
	<script type="text/javascript"  src="<%=basePath %>js/comun/password.js"></script>
 

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
							<div id="respuestaAccion" style="padding-left:100px; width:100%; padding-top:90px;">
							<form id="paso1">
							
							<div style="width:750px; color: #FFFFFF;">
								<strong>REGISTRO DE USUARIOS</strong><br/><br/>
								En dos simples pasos regístrese como usuario y podrá descargar y utilizar Gratuitamente y en forma indefinida nuestro software de Control de acceso y administración de edificios.<br/><br/>
							</div>
								
							<div id="wizard" class="swMain" style="width:750px;">
					  			<ul>
					  				<li><a href="#step-1">
					                <label class="stepNumber">1</label>
					                <span class="stepDesc">Paso 1<br />
					                	<small>Informaci&oacute;n Personal</small>
					                </span>
					            </a></li>
					  				<li><a href="#step-2">
					                <label class="stepNumber">2</label>
					                <span class="stepDesc">
					                   Paso 2<br />
					                   <small>Datos del Condominio</small>
					                </span>
					            </a></li>
					  			</ul>
									<div id="step-1" style="width:auto; height:317px;">
										<div class="userform" style="float:left; width:400px; height:274px; overflow:hidden;">
																				
											<fieldset>
													<div>
													<table border="0" style="width:420px;">
														<tr style="height:30px;">
															<td style="width:150px; font-size: 12px; font-weight: bold; text-shadow: 2px 2px 2px #ccc;">RUT:</td>
															<td style="width:10px;"><font color="#ff0000">*</font></td>
															<td style="width:200px;"><input class="input validate[required,funcCall[checkRutField]]" type="text" id="dniUsuario2" name="dniUsuario2"  maxlength="18" data-prompt-position="bottomRight"/></td>
															<td style="width:5px;">&nbsp;</td>
														</tr>
														<tr style="height:30px;">								
															<td	style="font-size:12px; font-weight:bold; text-shadow:2px 2px 2px #ccc;">Clave:</td>
															<td><font color="#ff0000">*</font></td>
															<td><input class="input validate[required, minSize[6]] text-input" type="password" name="clave" id="clave" size="25" maxlength="30" /></td>
															<td>&nbsp;</td>
														</tr>
														<tr style="height:30px;">								
															<td	style="font-size:12px; font-weight:bold; text-shadow:2px 2px 2px #ccc;">Confirma Clave:</td>
															<td><font color="#ff0000">*</font></td>
															<td><input class="input validate[required,equals[clave]] text-input" type="password" name="confirmaClave" id="confirmaClave" size="25" maxlength="30" /></td>
															<td>&nbsp;</td>
														</tr>
														<tr style="height:30px;">								
															<td	style="font-size:12px; font-weight:bold; text-shadow:2px 2px 2px #ccc;">Nombres:</td>
															<td><font color="#ff0000">*</font></td>
															<td><input class="input validate[required] text-input" type="text" name="nombreUsuario" id="nombreUsuario" size="25" maxlength="30" /></td>
															<td>&nbsp;</td>
														</tr>
														<tr style="height:30px;">
															<td style="font-size: 12px; font-weight: bold; text-shadow: 2px 2px 2px #ccc;">Apellido Paterno:</td>
															<td><font color="#ff0000">*</font></td>
															<td><input class="input validate[required] text-input" type="text" name="apellidoPaterno" id="apellidoPaterno" size="25"  maxlength="30" /></td>
															<td>&nbsp;</td>
														</tr>
														<tr style="height:30px;">
															<td style="font-size: 12px; font-weight: bold; text-shadow: 2px 2px 2px #ccc;">Apellido Materno:</td>
															<td>&nbsp;</td>
															<td><input class="input" type="text" name="apellidoMaterno" size="25" maxlength="30" /></td>
															<td>&nbsp;</td>
														</tr>
														<tr style="height:30px;">								
															<td	style="font-size: 12px; font-weight: bold; text-shadow: 2px 2px 2px #ccc;">Email:</td>
															<td><font color="#ff0000">*</font></td>
															<td><input readonly class="input" type="text" name="emailUsuario" id= "emailUsuario" size="25" value="<%=email %>"/></td>
															<td>&nbsp;</td>
														</tr>
														<tr style="height:30px;">								
															<td style="font-size: 12px; font-weight: bold; text-shadow: 2px 2px 2px #ccc;">Telefono Contacto:</td>
															<td>&nbsp;</td>
															<td><input class="input validate[custom[phone]]" type="text" name="movilUsuario"  id="movilUsuario" size="25"  maxlength="13" /></td>
															<td>&nbsp;</td>															
														</tr>
														
														<tr style="height:30px;">
															<td	style="font-size: 12px; font-weight: bold; text-shadow: 2px 2px 2px #ccc;">Fecha Nacimiento:</td>
															<td><font color="#ff0000">*</font></td>
															<td><input class="input validate[required] text-input datepicker" type="text" readonly="readonly" size="25" maxlength="11"	id="fechanac" name="fechanac"></td>
														</tr>
																											
													</table>
													</div>
													</fieldset>
											</div>
											
											<div id="step-question-default1" class="userform" style="float:left; margin: 0 0 0 6px; width:247px; height:274px;">
												<font size="2"><strong>Informacion Personal</strong></font><br/><br/>
												La información personal es utilizada 
												únicamente para su registro.<br/><br/> 
												Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.<br/><br/> 
												Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.<br/><br/>
												<!-- <img id="btnCerrarDefault" src="/acepta/imagenes/btn_cerrar.png" border="0"/> -->
											</div>
										</div>
										<div id="step-2" style="width:auto;height:317px;">
											<div class="userform"style="float:left; width:400px; height:274px; overflow:hidden;">
												<fieldset>
													<br>
														<table border="0" style="width: 420px;">
															<tr style="height:30px;">
																<td style="font-size: 12px; font-weight: bold; text-shadow: 2px 2px 2px #ccc; width:150px;">RUT Empresa:</td>
																<td style="width:10px;"><font color="#ff0000">*</font></td>
																<td style="width:190px;"><input class="input validate[required,funcCall[checkRutField]]" type="text" id="rutemp" name="rutemp"  maxlength="18" data-prompt-position="bottomRight"/></td>
																<td><img id="questionRut" src="<%=basePath%>imagenes/question.png" border="0" /></td>
															</tr>
															<tr style="height:30px;">
																<td style="font-size: 12px; font-weight: bold; text-shadow: 2px 2px 2px #ccc;">Raz&oacute;n Social:</td>
																<td><font color="#ff0000">*</font></td>
																<td><input class="input validate[required] text-input" type="text" id="razon" name="razon"  maxlength="50"/></td>
																<td><img id="questionRazon" src="<%=basePath%>imagenes/question.png" border="0" /></td>
															</tr>
															<tr style="height:30px;">								
																<td	style="font-size: 12px; font-weight: bold; text-shadow: 2px 2px 2px #ccc;">Giro:</td>
																<td><font color="#ff0000">*</font></td>
																<td><input class="input validate[required] text-input" type="text" name="giro" id="giro" size="25" maxlength="30" /></td>
																<td><img id="questionGiro" src="<%=basePath%>imagenes/question.png" border="0" /></td>
															</tr>
															
															<tr style="height:30px;">
																<td style="font-size: 12px; font-weight: bold; text-shadow: 2px 2px 2px #ccc;">Direcci&oacute;n:</td>
																<td><font color="#ff0000">*</font></td>
																<td><input class="input validate[required] text-input" type="text" name="direccion" id="direccion" size="25"  maxlength="30" /></td>
																<td>&nbsp;</td>
															</tr>
															<tr style="height:30px;">										
																<td style="font-size: 12px; font-weight: bold; text-shadow: 2px 2px 2px #ccc;">Comuna:</td>
																<td><font color="#ff0000">*</font></td>
																<td>
																	<div id="idcombo" class="ui-widget" >
																		&nbsp;&nbsp;
																		<select name="comuna" id="comuna" >
																			<option value="1101">Iquique</option>
																			<option value="1107">Alto Hospicio</option>
																			<option value="1401">Pozo Almonte</option>
																			<option value="1402">Camiña</option>
																			<option value="1403">Colchane</option>
																			<option value="1404">Huara</option>
																			<option value="1405">Pica</option>
																			<option value="2101">Antofagasta</option>
																			<option value="2102">Mejillones</option>
																			<option value="2103">Sierra Gorda</option>
																			<option value="2104">Taltal</option>
																			<option value="2201">Calama</option>
																			<option value="2202">Ollagüe</option>
																			<option value="2203">San Pedro de Atacama</option>
																			<option value="2301">Tocopilla</option>
																			<option value="2302">María Elena</option>
																			<option value="3101">Copiapó</option>
																			<option value="3102">Caldera</option>
																			<option value="3103">Tierra Amarilla</option>
																			<option value="3201">Chañaral</option>
																			<option value="3202">Diego de Almagro</option>
																			<option value="3301">Vallenar</option>
																			<option value="3302">Alto del Carmen</option>
																			<option value="3303">Freirina</option>
																			<option value="3304">Huasco</option>
																			<option value="4101">La Serena</option>
																			<option value="4102">Coquimbo</option>
																			<option value="4103">Andacollo</option>
																			<option value="4104">La Higuera</option>
																			<option value="4105">Paihuano</option>
																			<option value="4106">Vicuña</option>
																			<option value="4201">Illapel</option>
																			<option value="4202">Canela</option>
																			<option value="4203">Los Vilos</option>
																			<option value="4204">Salamanca</option>
																			<option value="4301">Ovalle</option>
																			<option value="4302">Combarbalá</option>
																			<option value="4303">Monte Patria</option>
																			<option value="4304">Punitaqui</option>
																			<option value="4305">Río Hurtado</option>
																			<option value="5101">Valparaíso</option>
																			<option value="5102">Casablanca</option>
																			<option value="5103">Concón</option>
																			<option value="5104">Juan Fernández</option>
																			<option value="5105">Puchuncaví</option>
																			<option value="5107">Quintero</option>
																			<option value="5109">Viña del Mar</option>
																			<option value="5201">Isla de Pascua</option>
																			<option value="5301">Los Andes</option>
																			<option value="5302">Calle Larga</option>
																			<option value="5303">Rinconada</option>
																			<option value="5304">San Esteban</option>
																			<option value="5401">La Ligua</option>
																			<option value="5402">Cabildo</option>
																			<option value="5403">Papudo</option>
																			<option value="5404">Petorca</option>
																			<option value="5405">Zapallar</option>
																			<option value="5501">Quillota</option>
																			<option value="5502">La Calera</option>
																			<option value="5503">Hijuelas</option>
																			<option value="5504">La Cruz</option>
																			<option value="5506">Nogales</option>
																			<option value="5601">San Antonio</option>
																			<option value="5602">Algarrobo</option>
																			<option value="5603">Cartagena</option>
																			<option value="5604">El Quisco</option>
																			<option value="5605">El Tabo</option>
																			<option value="5606">Santo Domingo</option>
																			<option value="5701">San Felipe</option>
																			<option value="5702">Catemu</option>
																			<option value="5703">Llay Llay</option>
																			<option value="5704">Panquehue</option>
																			<option value="5705">Putaendo</option>
																			<option value="5706">Santa María</option>
																			<option value="5801">Quilpué</option>
																			<option value="5802">Limache</option>
																			<option value="5803">Olmué</option>
																			<option value="5804">Villa Alemana</option>
																			<option value="6101">Rancagua</option>
																			<option value="6102">Codegua</option>
																			<option value="6103">Coinco</option>
																			<option value="6104">Coltauco</option>
																			<option value="6105">Doñihue</option>
																			<option value="6106">Graneros</option>
																			<option value="6107">Las Cabras</option>
																			<option value="6108">Machalí</option>
																			<option value="6109">Malloa</option>
																			<option value="6110">Mostazal</option>
																			<option value="6111">Olivar</option>
																			<option value="6112">Peumo</option>
																			<option value="6113">Pichidegua</option>
																			<option value="6114">Quinta de Tilcoco</option>
																			<option value="6115">Rengo</option>
																			<option value="6116">Requínoa</option>
																			<option value="6117">San Vicente</option>
																			<option value="6201">Pichilemu</option>
																			<option value="6202">La Estrella</option>
																			<option value="6203">Litueche</option>
																			<option value="6204">Marchihue</option>
																			<option value="6205">Navidad</option>
																			<option value="6206">Paredones</option>
																			<option value="6301">San Fernando</option>
																			<option value="6302">Chépica</option>
																			<option value="6303">Chimbarongo</option>
																			<option value="6304">Lolol</option>
																			<option value="6305">Nancagua</option>
																			<option value="6306">Palmilla</option>
																			<option value="6307">Peralillo</option>
																			<option value="6308">Placilla</option>
																			<option value="6309">Pumanque</option>
																			<option value="6310">Santa Cruz</option>
																			<option value="7101">Talca</option>
																			<option value="7102">Constitución</option>
																			<option value="7103">Curepto</option>
																			<option value="7104">Empedrado</option>
																			<option value="7105">Maule</option>
																			<option value="7106">Pelarco</option>
																			<option value="7107">Pencahue</option>
																			<option value="7108">Río Claro</option>
																			<option value="7109">San Clemente</option>
																			<option value="7110">San Rafael</option>
																			<option value="7201">Cauquenes</option>
																			<option value="7202">Chanco</option>
																			<option value="7203">Pelluhue</option>
																			<option value="7301">Curicó</option>
																			<option value="7302">Hualañé</option>
																			<option value="7303">Licantén</option>
																			<option value="7304">Molina</option>
																			<option value="7305">Rauco</option>
																			<option value="7306">Romeral</option>
																			<option value="7307">Sagrada Familia</option>
																			<option value="7308">Teno</option>
																			<option value="7309">Vichuquén</option>
																			<option value="7401">Linares</option>
																			<option value="7402">Colbún</option>
																			<option value="7403">Longaví</option>
																			<option value="7404">Parral</option>
																			<option value="7405">Retiro</option>
																			<option value="7406">San Javier</option>
																			<option value="7407">Villa Alegre</option>
																			<option value="7408">Yerbas Buenas</option>
																			<option value="8101">Concepción</option>
																			<option value="8102">Coronel</option>
																			<option value="8103">Chiguayante</option>
																			<option value="8104">Florida</option>
																			<option value="8105">Hualqui</option>
																			<option value="8106">Lota</option>
																			<option value="8107">Penco</option>
																			<option value="8108">San Pedro de la Paz</option>
																			<option value="8109">Santa Juana</option>
																			<option value="8110">Talcahuano</option>
																			<option value="8111">Tomé</option>
																			<option value="8112">Hualpén</option>
																			<option value="8201">Lebu</option>
																			<option value="8202">Arauco</option>
																			<option value="8203">Cañete</option>
																			<option value="8204">Contulmo</option>
																			<option value="8205">Curanilahue</option>
																			<option value="8206">Los Álamos</option>
																			<option value="8207">Tirúa</option>
																			<option value="8301">Los Ángeles</option>
																			<option value="8302">Antuco</option>
																			<option value="8303">Cabrero</option>
																			<option value="8304">Laja</option>
																			<option value="8305">Mulchén</option>
																			<option value="8306">Nacimiento</option>
																			<option value="8307">Negrete</option>
																			<option value="8308">Quilaco</option>
																			<option value="8309">Quilleco</option>
																			<option value="8310">San Rosendo</option>
																			<option value="8311">Santa Bárbara</option>
																			<option value="8312">Tucapel</option>
																			<option value="8313">Yumbel</option>
																			<option value="8314">Alto Biobío</option>
																			<option value="8401">Chillán</option>
																			<option value="8402">Bulnes</option>
																			<option value="8403">Cobquecura</option>
																			<option value="8404">Coelemu</option>
																			<option value="8405">Coihueco</option>
																			<option value="8406">Chillán Viejo</option>
																			<option value="8407">El Carmen</option>
																			<option value="8408">Ninhue</option>
																			<option value="8409">Ñiquén</option>
																			<option value="8410">Pemuco</option>
																			<option value="8411">Pinto</option>
																			<option value="8412">Portezuelo</option>
																			<option value="8413">Quillón</option>
																			<option value="8414">Quirihue</option>
																			<option value="8415">Ránquil</option>
																			<option value="8416">San Carlos</option>
																			<option value="8417">San Fabián</option>
																			<option value="8418">San Ignacio</option>
																			<option value="8419">San Nicolás</option>
																			<option value="8420">Treguaco</option>
																			<option value="8421">Yungay</option>
																			<option value="9101">Temuco</option>
																			<option value="9102">Carahue</option>
																			<option value="9103">Cunco</option>
																			<option value="9104">Curarrehue</option>
																			<option value="9105">Freire</option>
																			<option value="9106">Galvarino</option>
																			<option value="9107">Gorbea</option>
																			<option value="9108">Lautaro</option>
																			<option value="9109">Loncoche</option>
																			<option value="9110">Melipeuco</option>
																			<option value="9111">Nueva Imperial</option>
																			<option value="9112">Padre las Casas</option>
																			<option value="9113">Perquenco</option>
																			<option value="9114">Pitrufquén</option>
																			<option value="9115">Pucón</option>
																			<option value="9116">Saavedra</option>
																			<option value="9117">Teodoro Schmidt</option>
																			<option value="9118">Toltén</option>
																			<option value="9119">Vilcún</option>
																			<option value="9120">Villarrica</option>
																			<option value="9121">Cholchol</option>
																			<option value="9201">Angol</option>
																			<option value="9202">Collipulli</option>
																			<option value="9203">Curacautín</option>
																			<option value="9204">Ercilla</option>
																			<option value="9205">Lonquimay</option>
																			<option value="9206">Los Sauces</option>
																			<option value="9207">Lumaco</option>
																			<option value="9208">Purén</option>
																			<option value="9209">Renaico</option>
																			<option value="9210">Traiguén</option>
																			<option value="9211">Victoria</option>
																			<option value="10101">Puerto Montt</option>
																			<option value="10102">Calbuco</option>
																			<option value="10103">Cochamó</option>
																			<option value="10104">Fresia</option>
																			<option value="10105">Frutillar</option>
																			<option value="10106">Los Muermos</option>
																			<option value="10107">Llanquihue</option>
																			<option value="10108">Maullín</option>
																			<option value="10109">Puerto Varas</option>
																			<option value="10201">Castro</option>
																			<option value="10202">Ancud</option>
																			<option value="10203">Chonchi</option>
																			<option value="10204">Curaco de Vélez</option>
																			<option value="10205">Dalcahue</option>
																			<option value="10206">Puqueldón</option>
																			<option value="10207">Queilén</option>
																			<option value="10208">Quellón</option>
																			<option value="10209">Quemchi</option>
																			<option value="10210">Quinchao</option>
																			<option value="10301">Osorno</option>
																			<option value="10302">Puerto Octay</option>
																			<option value="10303">Purranque</option>
																			<option value="10304">Puyehue</option>
																			<option value="10305">Río Negro</option>
																			<option value="10306">San Juan de la Costa</option>
																			<option value="10307">San Pablo</option>
																			<option value="10401">Chaitén</option>
																			<option value="10402">Futaleufú</option>
																			<option value="10403">Hualaihué</option>
																			<option value="10404">Palena</option>
																			<option value="11101">Coyhaique</option>
																			<option value="11102">Lago Verde</option>
																			<option value="11201">Aysén</option>
																			<option value="11202">Cisnes</option>
																			<option value="11203">Guaitecas</option>
																			<option value="11301">Cochrane</option>
																			<option value="11302">O''Higgins</option>
																			<option value="11303">Tortel</option>
																			<option value="11401">Chile Chico</option>
																			<option value="11402">Río Ibáñez</option>
																			<option value="12101">Punta Arenas</option>
																			<option value="12102">Laguna Blanca</option>
																			<option value="12103">Río Verde</option>
																			<option value="12104">San Gregorio</option>
																			<option value="12201">Cabo de Hornos</option>
																			<option value="12202">Antártica</option>
																			<option value="12301">Porvenir</option>
																			<option value="12302">Primavera</option>
																			<option value="12303">Timaukel</option>
																			<option value="12401">Natales</option>
																			<option value="12402">Torres del Paine</option>
																			<option value="13101">Santiago</option>
																			<option value="13102">Cerrillos</option>
																			<option value="13103">Cerro Navia</option>
																			<option value="13104">Conchalí</option>
																			<option value="13105">El Bosque</option>
																			<option value="13106">Estación Central</option>
																			<option value="13107">Huechuraba</option>
																			<option value="13108">Independencia</option>
																			<option value="13109">La Cisterna</option>
																			<option value="13110">La Florida</option>
																			<option value="13111">La Granja</option>
																			<option value="13112">La Pintana</option>
																			<option value="13113">La Reina</option>
																			<option value="13114">Las Condes</option>
																			<option value="13115">Lo Barnechea</option>
																			<option value="13116">Lo Espejo</option>
																			<option value="13117">Lo Prado</option>
																			<option value="13118">Macul</option>
																			<option value="13119">Maipú</option>
																			<option value="13120">Ñuñoa</option>
																			<option value="13121">Pedro Aguirre Cerda</option>
																			<option value="13122">Peñalolén</option>
																			<option value="13123">Providencia</option>
																			<option value="13124">Pudahuel</option>
																			<option value="13125">Quilicura</option>
																			<option value="13126">Quinta Normal</option>
																			<option value="13127">Recoleta</option>
																			<option value="13128">Renca</option>
																			<option value="13129">San Joaquín</option>
																			<option value="13130">San Miguel</option>
																			<option value="13131">San Ramón</option>
																			<option value="13132">Vitacura</option>
																			<option value="13201">Puente Alto</option>
																			<option value="13202">Pirque</option>
																			<option value="13203">San José de Maipo</option>
																			<option value="13301">Colina</option>
																			<option value="13302">Lampa</option>
																			<option value="13303">Tiltil</option>
																			<option value="13401">San Bernardo</option>
																			<option value="13402">Buin</option>
																			<option value="13403">Calera de Tango</option>
																			<option value="13404">Paine</option>
																			<option value="13501">Melipilla</option>
																			<option value="13502">Alhué</option>
																			<option value="13503">Curacaví</option>
																			<option value="13504">María Pinto</option>
																			<option value="13505">San Pedro</option>
																			<option value="13601">Talagante</option>
																			<option value="13602">El Monte</option>
																			<option value="13603">Isla de Maipo</option>
																			<option value="13604">Padre Hurtado</option>
																			<option value="13605">Peñaflor</option>
																			<option value="14101">Valdivia</option>
																			<option value="14102">Corral</option>
																			<option value="14103">Lanco</option>
																			<option value="14104">Los Lagos</option>
																			<option value="14105">Máfil</option>
																			<option value="14106">Mariquina</option>
																			<option value="14107">Paillaco</option>
																			<option value="14108">Panguipulli</option>
																			<option value="14201">La Unión</option>
																			<option value="14202">Futrono</option>
																			<option value="14203">Lago Ranco</option>
																			<option value="14204">Río Bueno</option>
																			<option value="15101">Arica</option>
																			<option value="15102">Camarones</option>
																			<option value="15201">Putre</option>
																			<option value="15202">General Lagos</option>
																		</select>
																	</div>
																</td>
																<td>&nbsp;</td>
															</tr>
															<tr style="height:30px;">
																<td style="font-size: 12px; font-weight: bold; text-shadow: 2px 2px 2px #ccc;"> Ciudad: </td>
																<td><font color="#ff0000">*</font></td>
																<td><input class="input validate[required] text-input" type="text" name="ciudad" id= "ciudad" size="25" />
																</td>
																<td>&nbsp;</td>
															</tr>
														</table>
														</fieldset>											
												</div>
											<div id="step-question-default" class="userform" style="float:left; margin: 0 0 0 6px; width:247px; height:274px;">
												<font size="2"><strong>Descripci&oacute;n</strong></font><br/><br/>
												Lorem ipsum dolor sit amet, consectetur adipisicing elit, 
												sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.<br/><br/> 
												Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.<br/><br/> 
												Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.<br/><br/>
												<!-- <img id="btnCerrarDefault" src="/acepta/imagenes/btn_cerrar.png" border="0"/> -->
											</div>	
											<div id="step-Rut" class="userform" style="float:left; margin: 0 0 0 6px; width:247px; height:274px;">
												<font size="2"><strong>Rut</strong></font><br/><br/>
												Lorem ipsum dolor sit amet, consectetur adipisicing elit, 
												sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.<br/><br/> 
												Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.<br/><br/> 
												Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.<br/><br/>
												<img id="btnCerrar" src="<%=basePath%>imagenes/btn_cerrar.png" border="0"/>
											</div>
											<div id="step-Razon" class="userform" style="display:none; float:left; margin: 0 0 0 6px; width:247px; height:274px;">
												<font size="2"><strong>Razon</strong></font><br/><br/>
												Lorem ipsum dolor sit amet, consectetur adipisicing elit, 
												sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.<br/><br/> 
												Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.<br/><br/> 
												Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.<br/><br/>
												<img class="btnCerrar" src="<%=basePath%>imagenes/btn_cerrar.png" border="0"/>
											</div>
											<div id="step-Giro" class="userform" style="display:none; float:left; margin: 0 0 0 6px; width:247px; height:274px;">
												<font size="2"><strong>Giro</strong></font><br/><br/>
												Lorem ipsum dolor sit amet, consectetur adipisicing elit, 
												sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.<br/><br/> 
												Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.<br/><br/> 
												Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.<br/><br/>
												<img class="btnCerrar" src="<%=basePath%>imagenes/btn_cerrar.png" border="0"/>
											</div>
										</div>
									</div>	
							<input class="input" type="hidden" name="reqName" value="prgregistrousr">			
							<input class="input" type="hidden" name="codigo" value="<%=codigo %>">										
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
<div id="dialog" title="Error de Registro" style="text-align: center;"></div>
</body>
</html>