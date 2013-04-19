/**
 * 
 */
package cl.altair.portal.usuario;

import java.util.Calendar;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cl.altair.perfilamiento.control.Perfilador;
import cl.mycompany.perfilamiento.model.Usuario;
import cl.altair.utiles.generales.SimpleEncryption;

import servicios.generales.WSException;
import servicios.generales.WSPgrmCallException;
import servicios.wsapi.BusinessObjectClass;
import servicios.wsapi.FceObjectInterface;

/**
 * @author lpino
 *
 */
public class BOValidaLink extends BusinessObjectClass implements
		FceObjectInterface {

	/* (non-Javadoc)
	 * @see servicios.wsapi.BusinessObjectInterface#getContext(javax.servlet.http.HttpServletRequest)
	 */
	@Override
	public void getContext(HttpServletRequest httpservletrequest) {
		copyRequest = httpservletrequest;
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
	public void getServiceResult(Object arg0) throws WSException,
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
	 * @see servicios.wsapi.FceObjectInterface#execute()
	 */
	@Override
	public void execute() throws WSException, WSPgrmCallException {
		try {
			SimpleEncryption simpleEncryption = new SimpleEncryption();
			String token = simpleEncryption.decrypt(simpleEncryption.decode(copyRequest.getParameter("token")));
			logs.info("Clase: BOValidaLink - Msg: Token recibido fue = " + token);
			StringTokenizer linea = new StringTokenizer(token, "_",false);
			String login = linea.nextToken();
			String time = linea.nextToken();
			long endTime = Calendar.getInstance().getTimeInMillis();
			long msec = endTime - Long.parseLong(time);
			long timeHours = msec / 1000 / 60 / 60;
			logs.info("Clase: BOValidaLink - Msg: Lapso transcurrido = " + timeHours + " horas");
			if(timeHours >= 1){
				copyRequest.setAttribute("mensaje","Su tiempo habilitado para solicitar su clave, expiro. Debe volver a hacer su solicitud para que le enviemos un nuevo correo");
				otherPage = "linkmalo";
			} else {
				Perfilador profiler = new Perfilador();
				Usuario usuario = profiler.getUsuario(login);
				if(usuario == null) {
					copyRequest.setAttribute("mensaje","Su correo no esta registrado. Por favor solicite su certificado con Acepta.com");					
					otherPage = "linkmalo";
				} else {
					copyRequest.setAttribute("mensaje",login);
					sgteServicio = null;
					return;						
				}
			}
		} catch (Exception exception) {
			exception.printStackTrace();
			if(exception instanceof WSPgrmCallException){
				throw (WSPgrmCallException)exception;
			}
			if(exception instanceof WSException)	{
				throw (WSException)exception;
			} else{
				throw new WSException("Clase: BOValidaLink: Msg-Error en el objeto de negocios -  ERROR: " + exception.getMessage());
			}		
		}
		sgteServicio = null;
		return;		
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
	public void init(HttpServletRequest arg0, HttpServletResponse arg1) {
		// TODO Auto-generated method stub

	}

	/* (non-Javadoc)
	 * @see servicios.wsapi.FceObjectInterface#setParameters(java.lang.Object)
	 */
	@Override
	public void setParameters(Object arg0) {
		// TODO Auto-generated method stub

	}

	private String daVueltaRut(String rut){
		String nuevoRut = "";
		for (int i= rut.length() -1 ; i >= 0; i--)
			nuevoRut +=rut.charAt(i);			
			return nuevoRut;
		} 
}
