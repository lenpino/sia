package cl.altair.portal.usuario;

import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import cl.altair.perfilamiento.control.PasswordHash;
import cl.altair.perfilamiento.control.Perfilador;
import cl.altair.perfilamiento.model.dao.EntityManagerHelper;
import cl.mycompany.perfilamiento.model.Usuario;
import cl.altair.perfilamiento.model.dao.UsuarioDAO;
import cl.altair.utiles.generales.SimpleEncryption;

import servicios.generales.*;
import servicios.wsapi.BusinessObjectClass;
import servicios.wsapi.BusinessObjectInterface;

public class BOSetClave extends BusinessObjectClass
    implements BusinessObjectInterface
{

    private String sgteServicio;
    public String otherPage;
    public HttpSession copySesion;
    public HttpServletRequest copyRequest;
    public static int MAX_INTENTOS = 3;

    public BOSetClave()
    {
        sgteServicio = "";
        otherPage = "";
    }

    public void getContext(HttpServletRequest httpservletrequest)
    {
        copySesion = httpservletrequest.getSession(false);
        copyRequest = httpservletrequest;
    }

    public String getJspAkaPage()
    {
        return otherPage;
    }

    public void getServiceResult()
    {
    }

    public void getServiceResult(Object obj)
        throws WSException, WSPgrmCallException
    {
        OutputServiceBean outputservicebean = (OutputServiceBean)obj;
        getServiceResult(outputservicebean);
    }

    /**
     * @param outputservicebean
     * @throws WSException
     * @throws WSPgrmCallException
     */
    public void getServiceResult(OutputServiceBean outputservicebean) throws WSException, WSPgrmCallException
    {
        String msg = "";
		SimpleEncryption simpleEncryption = new SimpleEncryption();
		String token = simpleEncryption.decrypt(simpleEncryption.decode(copyRequest.getParameter("token")));
		StringTokenizer linea = new StringTokenizer(token, "_",false);
		String email = linea.nextToken();
    	Perfilador profiler = new Perfilador();
        UsuarioDAO userDAO = new UsuarioDAO();
    	Integer integer = (Integer)copySesion.getAttribute("tries");
        if(integer == null)
        	integer = new Integer(0);
        String weblogin = copyRequest.getParameter("weblogin");

		if(!weblogin.equalsIgnoreCase(email)){
			msg = "Existe inconsistencia en los emails";
			copyResponse.addHeader("ERROR","1");
		}
        //Extrae el usuario desde la BD
        Usuario elUsuario = profiler.getUsuario(weblogin);
        if(elUsuario == null){
        	msg = "El usuario no existe";
        	copyResponse.addHeader("ERROR","1");
        }
        try {
        	// El usuario ingresado no existe
            if(elUsuario == null) {
            	msg = "El usuario no existe";
            	copyResponse.addHeader("ERROR","1");
            } else {
            	String clave1 = copyRequest.getParameter("webclave1");
            	String clave2 = copyRequest.getParameter("webclave2");
            	if(!clave1.equalsIgnoreCase(clave2)){
                	msg = "Sus claves ingresadas no coinciden";
                	copyResponse.addHeader("ERROR","1");
                  //Si la clave es la correcta creo al usuario que va a la sesion
            	} else {
        			try {
        				if (PasswordHash.validatePassword(clave1, elUsuario.getClave())){
        					logs.info("Clase: BOSetClave - Msg: La clave coincide con la anterior");
        					msg = "Su nueva clave ingresada coincide con la anterior. Por favor ingrese una clave diferente";
        					copyResponse.addHeader("ERROR","1");
        				} else {
        					logs.info("Clase: BOSetClave - Msg: Actualizando la clave del usuario en la base de datos");
                            copySesion.setAttribute("estado", new Integer(0));
                            //Actualizo el atributo del usuario
                    	 	EntityManagerHelper.beginTransaction();
                    	 	elUsuario.setClave(PasswordHash.createHash(clave1));
                    	 	elUsuario = userDAO.update(elUsuario);
                    	 	EntityManagerHelper.commit();
                    	 	EntityManagerHelper.closeEntityManager();
                    	 	otherPage = "seteook";
                    		//Se incorpora esta informacion para discriminar en el JS si se trata solo de un mensaje o de la pagina de respuesta
                    		copyResponse.addHeader("ERROR","0");
                            sgteServicio = null;
                            return;
        				}
        			} catch (NoSuchAlgorithmException e) {
        				e.printStackTrace();
        			} catch (InvalidKeySpecException e) {
        				e.printStackTrace();
        			}

                }
            }
            copyResponse.setContentType("text/html");
            copyResponse.setCharacterEncoding("UTF-8");
            copyResponse.getWriter().write(msg);
            copyResponse.getWriter().flush();
            sgteServicio = null;
            return;
        }
        
        
        
        catch(Exception exception)
        {
            if(exception instanceof WSPgrmCallException)
            {
                throw (WSPgrmCallException)exception;
            }
            if(exception instanceof WSException)
            {
                throw (WSException)exception;
            } else {
            	logs.error(exception.getStackTrace().toString());
                throw new WSException("Clase: BOCambioClave - MSG: Error en el objeto de negocios - ERROR " + exception.getMessage());
            }
        }
    }

    public void init()
    {
    }

    public String nextService()
    {
        return sgteServicio;
    }

    public void setParameter()
    {
    }

}
