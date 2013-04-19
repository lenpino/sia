/**
 * 
 */
package cl.altair.portal.registro;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cl.altair.modelo.portal.Registro;
import cl.altair.modelo.portal.RegistroDAO;
import cl.altair.perfilamiento.model.dao.EntityManagerHelper;
import servicios.generales.WSException;
import servicios.generales.WSPgrmCallException;
import servicios.wsapi.BusinessObjectClass;
import servicios.wsapi.FceObjectInterface;

/**
 * @author lpino
 *
 */
public class BOValidaCodigo extends BusinessObjectClass implements
		FceObjectInterface {

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
		RegistroDAO rdao = new RegistroDAO();
		String codigo = copyRequest.getParameter("codigo");
		logs.info("Clase: BOValidaCodigo - MSG: Codigo de auditoria a validar:" +  codigo);
		Registro elRegistro = rdao.findByCodigoAuditoria(Long.parseLong(codigo), null).get(0);
		if(elRegistro == null){
			throw new WSException("Clase: BOValidaCodigo - MSG: No existe registro para codigo de auditoria " + codigo);
		} else {
			String estado = elRegistro.getEstado();
			if(!estado.equalsIgnoreCase("validacioncorreo") && !estado.equalsIgnoreCase("correo_valido")){
				throw new WSException("Clase: BOValidaCodigo - MSG: Estado de la solicitud incorrecto - ESTADO=" + estado);
			} else {
				elRegistro.setEstado("correo_valido");
				EntityManagerHelper.beginTransaction();
				rdao.update(elRegistro);
				EntityManagerHelper.commit();
				EntityManagerHelper.closeEntityManager();
				logs.info("Clase: BOValidaCodigo - MSG: Registro actualizo su estado indicando que el correo es valido");
			}
		}
		copyRequest.setAttribute("codigo", codigo);
		copyRequest.setAttribute("email", elRegistro.getEmail());
		logs.info("Clase: BOValidaCodigo - MSG: Variables relevantes respaldadas:");
		sgteServicio = null;
	}

	/* (non-Javadoc)
	 * @see servicios.wsapi.FceObjectInterface#getObjectResult()
	 */
	@Override
	public Object getObjectResult() {
		// TODO Auto-generated method stub
		return null;
	}

	/* (non-Javadoc)
	 * @see servicios.wsapi.FceObjectInterface#init(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 */
	@Override
	public void init(HttpServletRequest req, HttpServletResponse res) {
		// TODO Auto-generated method stub

	}

}
