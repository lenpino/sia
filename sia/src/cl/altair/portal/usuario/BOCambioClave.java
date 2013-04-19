package cl.altair.portal.usuario;

import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import cl.altair.perfilamiento.control.Perfilador;
import cl.altair.perfilamiento.model.dao.EntityManagerHelper;
import cl.mycompany.perfilamiento.model.Usuario;
import cl.altair.perfilamiento.model.dao.UsuarioDAO;

import servicios.generales.*;
import servicios.wsapi.BusinessObjectClass;
import servicios.wsapi.BusinessObjectInterface;

public class BOCambioClave extends BusinessObjectClass
    implements BusinessObjectInterface
{

    private String sgteServicio;
    public String otherPage;
    public HttpSession copySesion;
    public HttpServletRequest copyRequest;
    public static int MAX_INTENTOS = 3;
    private ServletContext contexto = null;

    public BOCambioClave()
    {
        sgteServicio = "";
        otherPage = "";
    }

    public void getContext(HttpServletRequest httpservletrequest)
    {
        copySesion = httpservletrequest.getSession(false);
        copyRequest = httpservletrequest;
        contexto = copySesion.getServletContext();
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
//    	Perfilador profiler = new Perfilador();
        UsuarioDAO userDAO = new UsuarioDAO();
    	Integer integer = (Integer)copySesion.getAttribute("tries");
        if(integer == null)
        	integer = new Integer(0);
        String weblogin = copyRequest.getParameter("weblogin");
		String[] temp = weblogin.split("-");
		weblogin = temp[0].replace(".", "")+temp[1];
        //Extrae el usuario desde la BD
//        Usuario elUsuario = profiler.getUsuario(weblogin);
        List<Usuario> users = userDAO.findByLogin(weblogin);
        String msg = "";
        Usuario elUsuario = null;
        if(users.isEmpty()){
        	msg = "El usuario no existe";
        } else
        	elUsuario = users.get(0);
        try {
        	// El usuario ingresado no existe
            if(elUsuario == null) {
            	msg = "El usuario no existe";
            } else {
            	// La idea es utilizar un usuario general que se instancie aca y que en runtime decida de que negocio se trata          	
                String clave = (copyRequest.getParameter("webclave")).trim();
                String hashedClave = Perfilador.hashPassword(clave);  
                // Si la clave no es correcta vuelve a la pagina de ingreso con el mensaje de error
                if(!hashedClave.equalsIgnoreCase(elUsuario.getClave())) {
	                msg = "Clave actual ingresada, no es correcta. Intente nuevamente";
	                integer = new Integer(integer.intValue() + 1);
	                copySesion.setAttribute("tries", integer);	                
	                if(integer.intValue() >= MAX_INTENTOS)
	                {
		                //Invalida el estado de la sesion
		                copySesion.setAttribute("estado", new Integer(1));
	                }
                } else {
                	String clave1 = copyRequest.getParameter("webclave1");
                	String clave2 = copyRequest.getParameter("webclave2");
                	if(!clave1.equalsIgnoreCase(clave2)){
                    	msg = "Sus claves ingresadas no coinciden";
                      //Si la clave es la correcta creo al usuario que va a la sesion
                	} else {
                    	//Reset del numero de intentos
                        if(integer.intValue() > 0)
                        {
                            integer = new Integer(0);
                            copySesion.setAttribute("tries", integer);
                        }      
                        //comprueba que sea sólo clave del usuario loggeado
                    	HttpSession sesion =copyRequest.getSession(true);
                    	Usuario usuario = (Usuario) sesion.getAttribute("usuario");
                         logs.info("usuario logeado"+usuario.getDni());
                         logs.info("usuario registro clave "+elUsuario.getDni());
                         if(!usuario.getDni().equals(elUsuario.getDni())){
		                     logs.info("usuarios no son iguales");
		                     msg = "No puede editar claves de otros clientes";
                         } else {
                           	 logs.info("usuarios son iguales");
                             copySesion.setAttribute("estado", new Integer(0));
                             //Actualizo el atributo del usuario
                    	 	EntityManagerHelper.beginTransaction();
                    	 	elUsuario.setClave(Perfilador.hashPassword(clave1));
                    	 	elUsuario = userDAO.update(elUsuario);
                    	 	EntityManagerHelper.commit();
                    	 	EntityManagerHelper.closeEntityManager();
                    	   otherPage = "cambiook";
                    		//Se incorpora esta informacion para discriminar en el JS si se trata solo de un mensaje o de la pagina de respuesta
                    		copyResponse.addHeader("REQUIRES_AUTH","1");
                            sgteServicio = null;
                            return;
                       	}
                		
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
