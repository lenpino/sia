package cl.altair.portal.usuario;

import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cl.altair.perfilamiento.control.PasswordHash;
import cl.altair.perfilamiento.control.PerfilAltair;
import cl.altair.perfilamiento.control.Perfilador;
import cl.altair.perfilamiento.model.dao.EntityManagerHelper;
import cl.altair.perfilamiento.model.dao.UsuarioDAO;
import cl.mycompany.perfilamiento.model.Usuario;

import servicios.generales.WSException;
import servicios.generales.WSPgrmCallException;
import servicios.wsapi.BusinessObjectClass;
import servicios.wsapi.FceObjectInterface;

public class BOLogin extends BusinessObjectClass implements FceObjectInterface {

	private static final int MAX_INTENTOS = 3;
	Integer integer;
	String weblogin = "";
	String webclave = "";
	UsuarioDAO userDAO = new UsuarioDAO();
//	private StringBuilder html = new StringBuilder();
	private String mensaje = "";
	
	@Override
	public void getContext(HttpServletRequest request) {
		copySesion = request.getSession(false); 
		copyRequest = request;
		weblogin = request.getParameter("email");
		logs.info("Usuario correo " + weblogin + " esta intentando logearse al sistema via usuario y password");
		webclave = request.getParameter("webclave");			
		integer = (Integer) request.getAttribute("tries");
		if(integer == null)
			integer = Integer.valueOf(0);
	}

	@Override
	public void getServiceResult() {
		// TODO Auto-generated method stub

	}

	@Override
	public void getServiceResult(Object resultado) throws WSException,
			WSPgrmCallException {
		// TODO Auto-generated method stub

	}

	@Override
	public void init() {
		// TODO Auto-generated method stub

	}

	@Override
	public void setParameter() {
		// TODO Auto-generated method stub

	}

	@Override
	public void setParameters(Object parametros) {
		// TODO Auto-generated method stub

	}

	@Override
	public void execute() throws WSException, WSPgrmCallException {
		try {
			// El usuario ingresado no existe o si su clave es incorrecta
			Perfilador profiler = new Perfilador();
			Usuario usuario = profiler.getUsuario(weblogin);
			if(usuario == null) {
				logs.info("Usuario email " + weblogin + " intento logearse pero no esta registrado");		    	
				integer = Integer.valueOf(integer.intValue() + 1);
				copySesion.setAttribute("tries", integer);
				copySesion.setAttribute("estado", Integer.valueOf(1));
				if(integer.intValue() >= MAX_INTENTOS)
					mensaje = "Usuario Bloqueado";				    	
				else
					mensaje = "Usuario o clave incorrecto";
				otherPage = "login";
			} else /*if(AdmSesiones.existeSesion(usuario.getDni())){
				logs.info("El usuario RUT " + usuario.getDni() + " ya tiene sesion");
				//Configura la salida para escribir los mensajes
				copyResponse.setContentType("text/html");
		    	copyResponse.setCharacterEncoding("UTF-8");
			    copyResponse.getWriter().write("Usuario ya esta conectado");
				copyResponse.getWriter().flush();
				sgteServicio = null;
				return;
			} else*/ if(!usuario.getEstado().getNombre().equalsIgnoreCase("activo")){
				logs.info("El usuario RUT " + usuario.getDni() + " no esta activo");
		    	mensaje = "Usuario no esta activo";
				otherPage = "login";
			} else if(!validaPassword(webclave, usuario)){
					logs.info("Clase: BOLogin - Error: Clave incorrecta");					
					integer = Integer.valueOf(integer.intValue() + 1);
					copySesion.setAttribute("tries", integer);
					copySesion.setAttribute("estado", Integer.valueOf(1));

					if(integer.intValue() >= MAX_INTENTOS){
				    	mensaje = "Usuario Bloqueado";				    	
					} else {
						mensaje = "Usuario o clave incorrecto";				    	
					}
					otherPage = "login";
				}  else {
					//Reset del numero de intentos
					if(integer.intValue() > 0)
						integer = Integer.valueOf(0);
					PerfilAltair elPerfil =  profiler.getPerfil(usuario);
					logs.info("Clase: BOLogin - Msg: El perfil fue creado");	
					//Si el usuario no tiene roles asociados se devuelve un mensaje de error
					if(elPerfil.getRoles().size() == 0){
						mensaje = "Usuario no posee roles";					
						otherPage = "login";
					}
					copySesion.setAttribute("estado", Integer.valueOf(0));
					//Se almacena su numero de identiicacion nacional para generar traza asociada a el
					copySesion.setAttribute("refNum", usuario.getDni());
					copySesion.setAttribute("usuario", usuario);
					copySesion.setAttribute("tries", integer);
					copySesion.setAttribute("perfil", elPerfil);
					logs.info("Clase: BOLogin - Msg: Variables fueron almacenadas en la sesion");
					//Se asigna por default la empresa activa aquella a la que el usuario pertenece
					copySesion.setAttribute("empresaActiva", elPerfil.getEmpresaEmpleadora(usuario));
					//Si el usuario solo posee un rol
					if(elPerfil.getRoles().size() == 1){
						//Si solo tiene un rol se respalda en la sesion para que quede disponible
						copySesion.setAttribute("rolActivo", elPerfil.getRoles().get(0));
						elPerfil.setRolActivo(elPerfil.getRoles().get(0));
						//Si el usuario no posee empresas asociadas se envia un mensaje de error (esto no deberia ocurrir)
						if(elPerfil.getEmpresas(elPerfil.getRoles().get(0)).isEmpty()){
							mensaje = "Usuario no posee empresas relacionadas";															
							otherPage = "login";
						}
					} else {
						//Se asigna por default el rol CONSULTA como rol activo tanto en el perfil como en la sesion
						for(int i=0; i<elPerfil.getRoles().size(); i++){
							if(elPerfil.getRoles().get(i).getNombre().equalsIgnoreCase("Usuario")){
								elPerfil.setRolActivo(elPerfil.getRoles().get(i));
								copySesion.setAttribute("rolActivo", elPerfil.getRoles().get(i));
							}
						}
						if(elPerfil.getRolActivo() == null){
					    	mensaje = "Usuario no posee rol consulta";					
							otherPage = "login";
						}
					}
				}
			//Coloco en el request  el mensaje que corresponda.
			copyRequest.setAttribute("msg", mensaje);
			sgteServicio = null;
			return;
		}
		catch(Exception exception)	{
			if(exception instanceof WSPgrmCallException)
			{
				throw (WSPgrmCallException)exception;
			}
			if(exception instanceof WSException)
			{
				throw (WSException)exception;
			} else {
				throw new WSException("Clase: BOLogin: Msg-Error en el objeto de negocios -  ERROR: " + exception.getMessage());
			}
		}
	}

	@Override
	public Object getObjectResult() {
		return null;
	}

	@Override
	public void init(HttpServletRequest req, HttpServletResponse res) {
		// TODO Auto-generated method stub

	}
	private boolean validaPassword(String clave, Usuario usuario){
		String claveDB = usuario.getClave();
		if(claveDB.split(":").length == 1){
			logs.info("Clase: BOLogin - Msg: Clave MD5 encontrada");
			if(Perfilador.hashPassword(clave).equalsIgnoreCase(claveDB)){
				logs.info("Clase: BOLogin - Msg: Clave esta correcta");
                try {
					//Actualizo la clave del usuario con el nuevo formato
					EntityManagerHelper.beginTransaction();
					usuario.setClave(PasswordHash.createHash(clave));
					usuario = userDAO.update(usuario);
					EntityManagerHelper.commit();
					EntityManagerHelper.closeEntityManager();
					logs.info("Clase: BOLogin - Msg: Clave del usuario actualizada");
				} catch (NoSuchAlgorithmException e) {
					e.printStackTrace();
				} catch (InvalidKeySpecException e) {
					e.printStackTrace();
				}
				return true;
			} else {
				logs.info("Clase: BOLogin - Msg: Clave incorrecta");
				return false;
			}
		} else if(claveDB.split(":").length == 2){
			logs.info("Clase: BOLogin - Msg: Clave PBKDF2WithHmacSHA1 encontrada");
			try {
				if (PasswordHash.validatePassword(clave, claveDB)){
					logs.info("Clase: BOLogin - Msg: Clave esta correcta");
					return true;
				} else {
					logs.info("Clase: BOLogin - Msg: Clave incorrecta");
					return false;
				}
			} catch (NoSuchAlgorithmException e) {
				e.printStackTrace();
			} catch (InvalidKeySpecException e) {
				e.printStackTrace();
			}
		} else {
			logs.info("Clase: BOLogin - Msg: Formato de clave desconocido");
			return false;
		}
		//Por default devuelve false
		return false;
	}

}
