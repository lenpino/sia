package cl.altair.intranet.mantenedores.perfiles;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cl.altair.perfilamiento.model.dao.AplicacionDAO;
import cl.altair.perfilamiento.model.dao.EmpresaAppDAO;
import cl.altair.perfilamiento.model.dao.EntityManagerHelper;
import cl.mycompany.perfilamiento.model.Aplicacion;
import cl.mycompany.perfilamiento.model.EmpresaApp;


import servicios.generales.WSException;
import servicios.generales.WSPgrmCallException;
import servicios.wsapi.BusinessObjectClass;
import servicios.wsapi.FceObjectInterface;

public class BOCRUDAplicaciones extends BusinessObjectClass implements
		FceObjectInterface {
	
    //Verdadero carga desde la base de datos (esta sucio)
    private Boolean flag = Boolean.FALSE;
    private StringBuilder html = new StringBuilder();
    
	public BOCRUDAplicaciones(){
		sgteServicio = "";
	    otherPage = "";
	}

	@Override
	public void getContext(HttpServletRequest httpservletrequest) {
		// TODO Auto-generated method stub
		copySesion = httpservletrequest.getSession(false);
        copyRequest = httpservletrequest;
        if(copySesion.getAttribute("flagAplicaciones") == null)
        	logs.warn("No existe el flag para controlar el cache de la lista de aplicaciones");
        	//copySesion.setAttribute("flagAplicaciones", Boolean.TRUE);
        else
        	flag = (Boolean)copySesion.getAttribute("flagAplicaciones");
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
		int accion = Integer.parseInt(copyRequest.getParameter("accion"));
		try {
		switch(accion){
			case 1:{
				AplicacionDAO adao= new AplicacionDAO();
				List<Aplicacion> unaAplicacion = adao.findByNombre(copyRequest.getParameter("id"));
				EmpresaAppDAO eadao = new EmpresaAppDAO();
				List<EmpresaApp> listaRelaciones = eadao.findByProperty("aplicacion", unaAplicacion.get(0));
				if(listaRelaciones.size() == 0){
					EntityManagerHelper.beginTransaction();
					adao.delete(unaAplicacion.get(0));				
					EntityManagerHelper.commit();
					EntityManagerHelper.closeEntityManager();
					copySesion.setAttribute("flagAplicaciones", Boolean.TRUE);
				} else {
					  html.append("Aplicación esta asociada a alguna empresa");
					  sgteServicio = null;
					  return;
				 }
				break;
			}
			case 2:{
				AplicacionDAO adao= new AplicacionDAO();
				if(adao.findByNombre(copyRequest.getParameter("descripcion")).isEmpty()){
					EntityManagerHelper.beginTransaction();
					Aplicacion unaAplicacion = new Aplicacion(0,copyRequest.getParameter("descripcion"));
					unaAplicacion.setWebroot(copyRequest.getParameter("webroot"));
					unaAplicacion.setInicio(copyRequest.getParameter("inicio"));
					adao.save(unaAplicacion);
					EntityManagerHelper.commit();
					EntityManagerHelper.closeEntityManager();
					copySesion.setAttribute("flagAplicaciones", Boolean.TRUE);
				 }else {
					  html.append("Aplicación ya existe");
					  sgteServicio = null;
					  return;
				 }
				break;
			}
			case 3:{				
				AplicacionDAO adao= new AplicacionDAO();
				List<Aplicacion> unaAplicacion = adao.findByNombre(copyRequest.getParameter("id"));
				if(unaAplicacion.get(0) != null){
					unaAplicacion.get(0).setNombre(copyRequest.getParameter("descripcion"));
					unaAplicacion.get(0).setWebroot(copyRequest.getParameter("webroot"));
					unaAplicacion.get(0).setInicio(copyRequest.getParameter("inicio"));
					EntityManagerHelper.beginTransaction();
					adao.update(unaAplicacion.get(0));					
					EntityManagerHelper.commit();
					EntityManagerHelper.closeEntityManager();
					copySesion.setAttribute("flagAplicaciones", Boolean.TRUE);
		     	}else {
					  html.append("Aplicación no existe, verifique antes de editar");
					  sgteServicio = null;
					  return;
			     }
				break;
			}
			default:{
				WSException error = new WSException("Clase: BOCRUDAplicaciones - ERROR: Parametro de accion invalido");
				throw error;
			}
		}
		copySesion.removeAttribute("totalAplicaciones");
		copySesion.removeAttribute("aplicaciones");
		copyResponse.setHeader("OK_FLAG", "1");
		sgteServicio = null;
		} catch (Exception e) {
			if(e instanceof WSException)
				throw (WSException)e;
			else{
				EntityManagerHelper.rollback();
				WSException error = new WSException("Clase: BOCRUDAplicaciones - ERROR: Error al realizar accion de tipo " + accion + " - MSG: " + e.getMessage());
				throw error;				
			}
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
