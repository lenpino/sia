package cl.altair.general;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import servicios.generales.WSException;
import servicios.generales.WSPgrmCallException;
import servicios.wsapi.BusinessObjectClass;
import servicios.wsapi.FceObjectInterface;

public class BOCallLink extends BusinessObjectClass implements
		FceObjectInterface {

	@Override
	public void getContext(HttpServletRequest arg0) {
		// TODO Auto-generated method stub

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
		otherPage = copyRequest.getParameter("pagina");
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
