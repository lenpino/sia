<!DOCTYPE html>
<html dir="ltr" lang="es-ES">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<title>SIA</title>
	<link rel="stylesheet" type="text/css" media="screen" href="css/estilos.css" />
	<link rel="stylesheet" type="text/css" media="screen" href="css/web_publica.css" />
	<link rel="stylesheet" type="text/css" media="screen" href="/css/estilosE.css" />
	<link rel="stylesheet" type="text/css" media="screen" href="js/jquery/css/custom-theme/jquery-ui-1.8.23.custom.css" />
		
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
		<!--INICIO CONTENEDOR-->
		<div class="contenedor">
			<!--INICIO HEADER-->
			<jsp:include flush="true" page="/jsp/comunes/header.jsp" />
			<!--FIN HEADER-->

			<!--INICIO CUERPO-->
			<div class="cuerpo">
				<div class="contenedor_info">
					<div class="top_cont_form"></div>
					<div class="fondo_middle_cont_form" align="center">

						<!--INICIO CONTENIDO PROPIO DE LA FUNCIONALIDAD-->
						<div id="wraper">
							<div class="principal">
							</div>
							<section id="titulo">
								<h2>
									<div align="center"> 
										SERVICIO NO DISPONIBLE 
									</div>
								</h2>
							</section>
						</div>
						<section class="breadcrumb">
						</section>
						<section class="contenido">
							<table width="520" border="0" align="center" cellpadding="1" cellspacing="1">
								<tbody>
									<tr style="height : 20px;">
										<td>
										</td>
									</tr>
									<tr>
										<td>
											<table width="100%">
												<tr>
													<td width="20" style="vertical-align: top;">
														<br>
													</td>
													
													<td colspan="2">
														<table cellpadding="1" cellspacing="1" width="476" height="124">
															<tbody>
																<tr>
																	<td class="ph1">
																		Estimado Cliente.
																	</td>
																</tr>
																<tr>
																	<td class="ph2">
																		<!-- specific error message --> 
																		El servicio no est&aacute; disponible en este momento. Intente nuevamente en algunos minutos.<br><br /> 
																		Gracias 
																	</td>										
																<tr>
																<tr>
																	<td class="ph2">
																		<!-- error code if applied-->
																	</td>
																</tr>
																<tr>
																	<td class="ph2">
																		<!-- error message if applied-->
																	</td>
																</tr>
															</tbody>
														</table>
													</td>
												</tr>
											</table>
										</td>
									</tr>
									<tr>
										<td style="padding-right: 220px;">
											<button id="submit" name="submit"  type="submit" class="boton_der3 text_boton_sig_desd_hast3" onclick="location.href='<%=request.getContextPath()%>/'"  style="font-family: arial;font-size:9px;text-align:right;">ACEPTAR</button>
										</td>
									</tr>								
								</tbody>
							</table>
						</section>
						<!--FIN CONTENIDO PROPIO DE LA FUNCIONALIDAD-->
					</div>
					<div class="fondo_bottom_cont_form"></div>
				</div>
			</div>
			<!--FIN CUERPO-->
			<!--INICIO FOOTER-->
			<jsp:include flush="true" page="/jsp/comunes/footer.jsp" />
			<!--FIN FOOTER-->
		</div>
		<!--FIN CONTENEDOR-->
</body>
</html>

