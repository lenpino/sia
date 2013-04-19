package cl.altair.intranet.mantenedores.perfiles;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cl.altair.perfilamiento.model.dao.AplicacionDAO;
import cl.mycompany.perfilamiento.model.Aplicacion;


import servicios.generales.WSException;
import servicios.generales.WSPgrmCallException;
import servicios.wsapi.BusinessObjectClass;
import servicios.wsapi.FceObjectInterface;

public class BOEditarAplicaciones extends BusinessObjectClass implements
		FceObjectInterface {
	@SuppressWarnings("unused")
	private String sgteServicio;
    public String otherPage;
    public HttpSession copySesion;
    public HttpServletRequest copyRequest;

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
		AplicacionDAO adao= new AplicacionDAO();
		Aplicacion aplicacion= new Aplicacion();
		aplicacion= adao.findById(Integer.parseInt(copyRequest.getParameter("idAplicacion")));
		copyRequest.setAttribute("laAplicacion", aplicacion);	
	}

	@Override
	public Object getObjectResult() {
		// TODO Auto-generated method stub
		return null;
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
