/**
 * 
 */
package cl.altair.portal.registro;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cl.altair.modelo.portal.Registro;
import cl.altair.modelo.portal.RegistroDAO;
import cl.altair.perfilamiento.control.PasswordHash;
import cl.altair.perfilamiento.model.dao.AplicacionDAO;
import cl.altair.perfilamiento.model.dao.EmpresaDAO;
import cl.altair.perfilamiento.model.dao.EntityManagerHelper;
import cl.altair.perfilamiento.model.dao.EstadoDAO;
import cl.altair.perfilamiento.model.dao.PerfilDAO;
import cl.altair.perfilamiento.model.dao.RolDAO;
import cl.altair.perfilamiento.model.dao.UnidadDAO;
import cl.altair.perfilamiento.model.dao.UsuarioDAO;
import cl.altair.servel.model.Persona;
import cl.altair.servel.model.PersonaDAO;
import cl.mycompany.perfilamiento.model.Aplicacion;
import cl.mycompany.perfilamiento.model.Empresa;
import cl.mycompany.perfilamiento.model.EmpresaApp;
import cl.mycompany.perfilamiento.model.Perfil;
import cl.mycompany.perfilamiento.model.Rol;
import cl.mycompany.perfilamiento.model.Unidad;
import cl.mycompany.perfilamiento.model.Usuario;
import cl.mycompany.perfilamiento.model.UsuarioRol;
import cl.mycompany.perfilamiento.model.UsuarioUnidad;

import servicios.generales.WSException;
import servicios.generales.WSPgrmCallException;
import servicios.wsapi.BusinessObjectClass;
import servicios.wsapi.FceObjectInterface;

/**
 * @author lpino
 *
 */
public class BORegistroUsr extends BusinessObjectClass implements FceObjectInterface {

	private StringBuilder html = new StringBuilder();
	/* (non-Javadoc)
	 * @see servicios.wsapi.BusinessObjectInterface#getContext(javax.servlet.http.HttpServletRequest)
	 */
	@Override
	public void getContext(HttpServletRequest request) {
		copyRequest = request;
	}

	/* (non-Javadoc)
	 * @see servicios.wsapi.BusinessObjectInterface#getServiceResult()
	 */
	@Override
	public void getServiceResult() {
		// TODO Auto-generated method stub

	}

	/* (non-Javadoc)
	 * @see servicios.wsapi.BusinessObjectInterface#getServiceResult(java.lang.Object)
	 */
	@Override
	public void getServiceResult(Object resultado) throws WSException,
			WSPgrmCallException {
		// TODO Auto-generated method stub

	}

	/* (non-Javadoc)
	 * @see servicios.wsapi.BusinessObjectInterface#init()
	 */
	@Override
	public void init() {
		// TODO Auto-generated method stub

	}

	/* (non-Javadoc)
	 * @see servicios.wsapi.BusinessObjectInterface#setParameter()
	 */
	@Override
	public void setParameter() {
		// TODO Auto-generated method stub

	}

	/* (non-Javadoc)
	 * @see servicios.wsapi.FceObjectInterface#setParameters(java.lang.Object)
	 */
	@Override
	public void setParameters(Object parametros) {
		// TODO Auto-generated method stub

	}

	/* (non-Javadoc)
	 * @see servicios.wsapi.FceObjectInterface#execute()
	 */
	@Override
	public void execute() throws WSException, WSPgrmCallException {
		try {
//			SecureRandom random = new SecureRandom();
			java.util.Date utilDate = new java.util.Date();
			java.text.SimpleDateFormat fmt = new java.text.SimpleDateFormat("dd-MM-yyyy"); 
			//fecha actual
			long lnMilisegundos = utilDate.getTime();
			java.sql.Timestamp fechaActual = new java.sql.Timestamp(lnMilisegundos);
			RegistroDAO rdao = new RegistroDAO();
			PersonaDAO pdao = new PersonaDAO();
			EmpresaDAO emdao = new EmpresaDAO();
			EstadoDAO edao = new EstadoDAO();
			UsuarioDAO udao= new UsuarioDAO();
			AplicacionDAO appdao = new AplicacionDAO();
			RolDAO roldao = new RolDAO();
			PerfilDAO perfildao = new PerfilDAO();
			
			String codigo = copyRequest.getParameter("codigo");
			logs.info("Clase: BORegistroUsr - MSG: Codigo de auditoria a validar:" +  codigo);
			Registro elRegistro = rdao.findByCodigoAuditoria(Long.parseLong(codigo), null).get(0);
			logs.info("Clase: BORegistroUsr - MSG: Asignando valores del formulario al registro:");
			
			String[] temp = copyRequest.getParameter("dniUsuario2").trim().split("-");
			String rutSinDV = temp[0].replace(".", "");
			String dv = temp[1].toUpperCase();
			elRegistro.setRut(Integer.parseInt(rutSinDV));
			elRegistro.setDv(dv);
			Persona laPersona = new Persona();
			Usuario usuario = new Usuario();
			Empresa laEmpresa = new Empresa();

			//Verifica que el rut no este registrado
			List<Registro> listaRegistros = rdao.findByRut(Integer.valueOf(rutSinDV));
			if(!listaRegistros.isEmpty()){
				logs.debug("BORegistroUsr - MSG: Usuario rut " + rutSinDV + " ya existe en los registros");
				html.append("Su RUT ya esta registrado");
				copyResponse.addHeader("ERROR","1");
				this.sgteServicio = null;
				return;
			}
			//Valida que el rut este en la base del SERVEL
			List<Persona> listadoPersonas = pdao.findByRut(Integer.valueOf(rutSinDV));
			if(listadoPersonas.isEmpty()){
				logs.debug("BORegistroUsr - MSG: Usuario rut " + rutSinDV + " no existe en el registro del SERVEL");
				html.append("El RUT no existe, por favor revise sus datos");
				copyResponse.addHeader("ERROR","1");
				this.sgteServicio = null;
				return;
			} 
			
			logs.debug("BORegistroUsr - MSG: Leyendo desde el servel el usuario rut " + rutSinDV);
			laPersona = listadoPersonas.get(0);

			//Crea la clave para el usuario
			elRegistro.setClave(PasswordHash.createHash(copyRequest.getParameter("clave")));
			elRegistro.setNombres(copyRequest.getParameter("nombreUsuario"));
			elRegistro.setApellido(copyRequest.getParameter("apellidoPaterno"));
			elRegistro.setApellidoMaterno(copyRequest.getParameter("apellidoMaterno"));

			elRegistro.setFechaUltimaActualizacion(fechaActual);
			elRegistro.setEstado("usuario_registrado");
			elRegistro.setTelefono(copyRequest.getParameter("movilUsuario"));
			String tipoDoc = copyRequest.getParameter("tipodoc");
			elRegistro.setTipo(tipoDoc);
			elRegistro.setFechaNacimiento((Date)fmt.parse(copyRequest.getParameter("fechanac")));
			
		    String[] temp2 = copyRequest.getParameter("rutemp").trim().split("-");
		    String rutEmpresa = temp2[0].replace(".", "");
		    String dvEmp = temp2[1].toUpperCase();
			elRegistro.setRutEmpresa(Integer.parseInt(rutEmpresa));
			elRegistro.setDvEmpresa(dvEmp);
			
			elRegistro.setRazonSocial(copyRequest.getParameter("razon"));
			elRegistro.setGiro(copyRequest.getParameter("giro"));
			elRegistro.setDireccion(copyRequest.getParameter("direccion"));
			elRegistro.setComuna(new Integer(copyRequest.getParameter("comuna")));
			elRegistro.setCiudad(copyRequest.getParameter("ciudad"));
			
			logs.info("Clase: BORegistroUsr - MSG: Valores del formulario asignados a el registro");
			
			//Puebla el objeto del usuario con los datos requeridos
			logs.debug("Clase: BORegistroUsr - MSG: Puebla el objeto del usuario con los datos requeridos");
			//Se inicializa como activo el usuario
			usuario.setEstado(edao.findById(Integer.valueOf(1)));
			//La fecha de nacimiento se puebla desde el registro
			usuario.setFechaNacimiento(elRegistro.getFechaNacimiento());
			//El usuario es delegado
			usuario.setTipo("D");
			//El sexo viene desde la base del servel
			usuario.setSexo(laPersona.getSexo());
			usuario.setApellidoPaterno(elRegistro.getApellido());
			//El login es el correo electronico
			usuario.setLogin(elRegistro.getEmail());
			usuario.setEmail(elRegistro.getEmail());
			//La clave es la que quedo registrada en la base de registros
			usuario.setClave(elRegistro.getClave());			
			usuario.setFechaIncorporacion(fechaActual);
			usuario.setDni(elRegistro.getRut());
			usuario.setNombre(elRegistro.getNombres());
			usuario.setDv(elRegistro.getDv());
			usuario.setFono(elRegistro.getTelefono());
			usuario.setMovil(elRegistro.getTelefono());
				    	
	    	//Puebla los datos de la empresa
			logs.debug("Clase: BORegistroUsr - MSG: Puebla los datos de la empresa");
	    	laEmpresa.setDv(elRegistro.getDvEmpresa());
	    	laEmpresa.setEstado("Registrada");
	    	laEmpresa.setNombre(elRegistro.getRazonSocial());
	    	//En el registro se asume que el usuario registrado es el primer usuario de la empresa
	    	laEmpresa.setNusuarios(Integer.valueOf(1));
	    	laEmpresa.setRut(elRegistro.getRutEmpresa());
	    	//Solo se tiene el telefono del usuario
	    	//TODO Incorporar el telefono de la empresa al formulario de ingreso y al registro
	    	laEmpresa.setTelefono(elRegistro.getTelefono());
	    	
	    	//Crea la Unidad y la asocia a la empresa
	    	logs.debug("Clase: BORegistroUsr - MSG: Crea la Unidad y la asocia a la empresa");
	    	UnidadDAO ud = new UnidadDAO();
	    	//Busca al Padre de todas las unidades- Requiere que exista una unidad con este nombre como unico registro al momento de iniciar el proceso
	    	Unidad elPadre = ud.findById(Integer.valueOf(1));
	    	Unidad laUnidad = new Unidad(0, laEmpresa, elPadre, laEmpresa.getNombre(), null, null);
			HashSet<Unidad> lasUnidades = new HashSet<Unidad>();
			lasUnidades.add(laUnidad);
			laEmpresa.setUnidads(lasUnidades);
			
			//Crea la relacion de pertenencia entre el usuario y la empresa en el modelo de perfilamiento
			logs.debug("Clase: BORegistroUsr - MSG: Crea la relacion de pertenencia entre el usuario y la empresa en el modelo de perfilamiento");
			UsuarioUnidad laRelacion = new UsuarioUnidad(0, laUnidad, usuario);
			List<UsuarioUnidad> lista = new ArrayList<UsuarioUnidad>();
			lista.add(laRelacion);
			usuario.setUsuarioUnidads(lista);
			
			//Crea la relacion entre el usuario y el rol administrador
			logs.debug("Clase: BORegistroUsr - MSG: Crea la relacion entre el usuario y el rol administrador");
			Rol rolSeleccionado = roldao.findByNombre("Administrador Empresa").get(0);
			UsuarioRol usuarioRol = new UsuarioRol(0, rolSeleccionado, usuario);
			List<UsuarioRol> listaRoles = new ArrayList<UsuarioRol>();
			listaRoles.add(usuarioRol);
			usuario.setUsuarioRols(listaRoles);
			
			//Crea la relacion entre la empresa y la aplicacion de acceso
			logs.debug("Clase: BORegistroUsr - MSG: Crea la relacion entre la empresa y la aplicacion de acceso");
			Aplicacion laAplicacion = appdao.findByNombre("Acceso Edificio").get(0);
			EmpresaApp unaRelacion = new EmpresaApp();
			unaRelacion.setAplicacion(laAplicacion);
			unaRelacion.setEmpresa(laEmpresa);
			HashSet<EmpresaApp> listaRelaciones = new HashSet<EmpresaApp>();
			listaRelaciones.add(unaRelacion);
			laEmpresa.setEmpresaApps(listaRelaciones);
			
			//Crea la relacion en el perfil
			Perfil nuevaRelacion = new Perfil(0, usuarioRol, unaRelacion);
			
			// Graba la informacion basica del usuario en la BD
	    	logs.info("Clase: BORegistroUsr - MSG: Grabando RUT: "+ rutSinDV + " en la base de datos");

			EntityManagerHelper.beginTransaction();
			rdao.update(elRegistro);
			emdao.save(laEmpresa);
			udao.save(usuario);
			perfildao.save(nuevaRelacion);
			EntityManagerHelper.commit();
			EntityManagerHelper.closeEntityManager();
			
			logs.info("Clase: BORegistroUsr - MSG: Registro grabado en base de datos y usuario basico creado");
		} catch (Exception e) {
			e.printStackTrace();
			logs.error("BORegistroUsr - MSG: Error no controlado al registrar el usuario");
			html.append("Hubo un inconveniente en su registro. Por favor intente mas tarde");
			copyResponse.addHeader("ERROR","1");
			this.sgteServicio = null;
			return;
		} 
		sgteServicio = null;
		copyResponse.addHeader("ERROR","0");
	}

	/* (non-Javadoc)
	 * @see servicios.wsapi.FceObjectInterface#getObjectResult()
	 */
	@Override
	public Object getObjectResult() {
		if(html.length() == 0)
			return null;
		else{
			copyRequest.setAttribute("fmtSalida", "html");
			return html.toString();
		}
	}

	/* (non-Javadoc)
	 * @see servicios.wsapi.FceObjectInterface#init(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 */
	@Override
	public void init(HttpServletRequest req, HttpServletResponse res) {
		// TODO Auto-generated method stub

	}

}
