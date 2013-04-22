package cl.altair.portal.usuario;



import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cl.altair.perfilamiento.control.PerfilAltair;
import cl.altair.perfilamiento.control.Perfilador;
import cl.mycompany.perfilamiento.model.*;
import cl.altair.perfilamiento.model.dao.*;

import servicios.generales.WSException;
import servicios.generales.WSPgrmCallException;
import servicios.wsapi.BusinessObjectClass;
import servicios.wsapi.FceObjectInterface;

public class BOModificarUsuarios extends BusinessObjectClass implements	FceObjectInterface {
	
	private StringBuilder html = new StringBuilder();
	private String mensaje = "";
	java.text.SimpleDateFormat fmt = new java.text.SimpleDateFormat("dd-MM-yyyy");
	Rol rolActivo;
	Empresa empresaActiva;
	Rol rolSeleccionado;
	Perfilador perfilator = new Perfilador();
	PerfilAltair perfil;
	RolDAO rdao = new RolDAO();
	UsuarioDAO udao= new UsuarioDAO();
	UsuarioRolDAO urdao = new UsuarioRolDAO();
	EstadoDAO edao = new EstadoDAO();
	EmpresaDAO emdao = new EmpresaDAO();
	
	@Override
	public void getContext(HttpServletRequest httpservletrequest) {
		copySesion = httpservletrequest.getSession(false);
        copyRequest = httpservletrequest;

	}

	@Override
	public void getServiceResult() {
		// TODO Auto-generated method stub

	}

	@Override
	public void getServiceResult(Object arg0) throws WSException,
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
	public void execute() throws WSException, WSPgrmCallException {
		try {
			Usuario usuario;
			if(copyRequest.getParameter("idUsuario") != null){
				usuario = udao.findById(new Integer(copyRequest.getParameter("idUsuario")));
			} else {
				usuario = (Usuario) copySesion.getAttribute("usuario");
			}
			rolActivo = (Rol)copySesion.getAttribute("rolActivo");
			empresaActiva = (Empresa)copySesion.getAttribute("empresaActiva");
			//Obtengo el perfil del usuario
			perfil = perfilator.getPerfil(usuario);
			

			//Cambios comunes a todos los formularios
			usuario.setApellidoPaterno(copyRequest.getParameter("apellidoPaterno"));
			usuario.setEmail(copyRequest.getParameter("emailUsuario"));
			usuario.setNombre(copyRequest.getParameter("nombreUsuario"));
			usuario.setFono(copyRequest.getParameter("fonoUsuario"));
			usuario.setMovil(copyRequest.getParameter("movilUsuario"));
			usuario.setSexo(copyRequest.getParameter("sexoUsuario"));
			usuario.setFechaNacimiento((Date)fmt.parse(copyRequest.getParameter("fechanac")));
			
			EntityManagerHelper.beginTransaction();			
			udao.update(usuario);
			EntityManagerHelper.commit();	
			EntityManagerHelper.closeEntityManager();
			logs.info("Clase: BOModificaUsuarios - Msg: Usuario rut " + usuario.getDni() + " fue actualizado en la base de datos");
			mensaje = "Sus datos fueron actualizados correctamente";
			copyRequest.setAttribute("msg", mensaje);
			sgteServicio = null;			
		} catch (Exception e) {
			if(EntityManagerHelper.getEntityManager().isOpen() && EntityManagerHelper.getEntityManager().getTransaction().isActive())
				EntityManagerHelper.closeEntityManager();
			e.printStackTrace();
			throw new WSException("Clase: BOModificarUsuarios - MSG: Error al grabar el usuario - ERROR: " + e.getMessage());
		} 		
	}

	@Override
	public Object getObjectResult() {
		if(html.length() == 0)
			return null;
		else{
			copyRequest.setAttribute("fmtSalida", "html");
			return html.toString();
		}
	}

	@Override
	public void init(HttpServletRequest arg0, HttpServletResponse arg1) {
		// TODO Auto-generated method stub

	}

	@Override
	public void setParameters(Object arg0) {
		// TODO Auto-generated method stub

	}
}
