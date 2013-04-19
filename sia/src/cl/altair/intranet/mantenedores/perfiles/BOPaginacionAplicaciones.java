package cl.altair.intranet.mantenedores.perfiles;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cl.altair.perfilamiento.model.dao.AplicacionDAO;
import cl.mycompany.perfilamiento.model.Aplicacion;

/*
import net.sf.json.JSON;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;
import net.sf.json.JsonConfig;
import net.sf.json.util.PropertyFilter;
*/

import servicios.generales.OutputServiceBean;
import servicios.generales.WSException;
import servicios.generales.WSPgrmCallException;
import servicios.wsapi.BusinessObjectClass;
import servicios.wsapi.FceObjectInterface;

public class BOPaginacionAplicaciones extends BusinessObjectClass
    implements FceObjectInterface
{

    private String sgteServicio;
    public String otherPage;
    public HttpSession copySesion;
    public HttpServletRequest copyRequest;
    //Verdadero carga desde la base de datos (esta sucio)
    private Boolean flag = Boolean.FALSE;
    int numeroPagina = 0;
    int totalFilas = 0;
    private StringBuilder json = new StringBuilder();
    
    private List<Aplicacion> listaAplicaciones;
    
    public BOPaginacionAplicaciones()
    {
        sgteServicio = "";
        otherPage = "";
    }

    @SuppressWarnings("unchecked")
	public void getContext(HttpServletRequest httpservletrequest)
    {
        copySesion = httpservletrequest.getSession(false);
        copyRequest = httpservletrequest;
        listaAplicaciones = (List<Aplicacion>) copySesion.getAttribute("aplicaciones");
        if(copySesion.getAttribute("flagAplicaciones") == null)
        	copySesion.setAttribute("flagAplicaciones", Boolean.TRUE);
        else
        	flag = (Boolean)copySesion.getAttribute("flagAplicaciones");
        if(listaAplicaciones == null || flag.booleanValue()){        	
        	AplicacionDAO adao= new AplicacionDAO();
        	listaAplicaciones= adao.findAll();
        	logs.debug("Clase: BOPaginacionAplicacion - MSG: Cargando la lista de aplicaciones desde la BD");
        	copySesion.setAttribute("aplicaciones", listaAplicaciones);
        	copySesion.setAttribute("flagAplicaciones", Boolean.FALSE);
        }
    	totalFilas = listaAplicaciones.size();
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
        try {
			getServiceResult(outputservicebean);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }

    /**
     * @param outputservicebean
     * @throws WSException
     * @throws WSPgrmCallException
     * @throws IOException 
     */
    public void getServiceResult(OutputServiceBean outputservicebean) throws WSException, WSPgrmCallException, IOException {
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
    private List<Aplicacion> getPagina(List<Aplicacion> aplicaciones, int offset, int totalFilasPorPagina, int totalFilas){
    	int j=offset + totalFilasPorPagina;    	
    	List<Aplicacion> paginaAplicaciones = new ArrayList<Aplicacion>();
    	if(totalFilas > 0){
	    	for(int i=offset;i <j;i++){
	    		if ((i + 1) == totalFilas ){
	    			paginaAplicaciones.add(aplicaciones.get(i));
	    			break;
	    		}
	    		paginaAplicaciones.add(aplicaciones.get(i));
	    	}
    	}
    	return paginaAplicaciones;
    }

	/* (non-Javadoc)
	 * @see servicios.wsapi.FceObjectInterface#execute()
	 */
	@Override
	public void execute() throws WSException, WSPgrmCallException {
 //   	StringBuffer json = new StringBuffer();
		//Si se eligio hacer una busqueda
    	if (copyRequest.getParameter("_search") != null && copyRequest.getParameter("_search").toString().equals("true")){
    		//Se extrae la palabra buscada
    		String searchString = copyRequest.getParameter("searchString").trim().toLowerCase();
    		//Se crea una nueva lista para contener las palabras que coincidan
    		List<Aplicacion> aux = new ArrayList<Aplicacion> ();
    		//Se busca en el listado actual las coincidencias
    		for (int i = 0; i < listaAplicaciones.size();i++){
    			if(listaAplicaciones.get(i).getNombre().toLowerCase().contains(searchString)){
    				//Se agregan las coincidencias a la nueva lista
    				aux.add(listaAplicaciones.get(i));
    			}
    		}
    		//Se actualiza la lista
    		listaAplicaciones = aux;
    		//Se lee el nuevo total de lineas
    		totalFilas = listaAplicaciones.size();
    		//Se respalda el listado en la sesion
    		copySesion.setAttribute("aplicaciones", aux);
    		//Se marca el listado para que se lea desde la BD la proxima vez, dado que no corresponde al listado completo
    		copySesion.setAttribute("flagAplicaciones", Boolean.TRUE);
    	}
    	
    	//Se calcula el total y se almacena en una variable de session
    	if (copySesion.getAttribute("totalAplicaciones") == null){
    		copySesion.setAttribute("totalAplicaciones", listaAplicaciones.size());
    	}
    	numeroPagina = copyRequest.getParameter("page")==null?1:Integer.parseInt(copyRequest.getParameter("page"));
    	int totalFilasPorPagina = Integer.parseInt(copyRequest.getParameter("rows"));	    	
    	int totalPaginas = 0;
    	int offset = 0;	    	
    	totalPaginas = totalFilas / totalFilasPorPagina;
    	//Si existe resto en la disvion agregare uno	    	
    	if (totalFilas % totalFilasPorPagina > 0)
    		totalPaginas ++;
    	offset = totalFilasPorPagina * (numeroPagina - 1);
    	List<Aplicacion>listaPaginaAplicaciones = getPagina(listaAplicaciones, offset, totalFilasPorPagina, totalFilas);	    	
    	String webroot = null;
    	String inicio = null;
    	
    	//Pruebas JSON- EL RESULTADO INDICA QUE ESTAS CLASES SON MAS LENTAS!!!!
/*    	long ini1 = System.currentTimeMillis();
	     JsonConfig config = new JsonConfig();
	     config.setJsonPropertyFilter(new PropertyFilter() {
	        public boolean apply(Object source, String name, Object value) {
	              if ("nombre".equals(name) || "id".equals(name) || "webroot".equals(name)) {
	                  return false;
	              }
	              return true;
	           }
	       });
	       List<JSON> jsonObjects = new ArrayList<JSON>();
	       for (Object object : listaPaginaAplicaciones) {
	           jsonObjects.add(JSONSerializer.toJSON(object, config));
	       }
    	JSONObject jsonObj = new JSONObject();
		jsonObj.accumulate("total",totalPaginas );
		jsonObj.accumulate("page", numeroPagina);
		jsonObj.accumulate("records",totalFilas);
		jsonObj.accumulate("rows", jsonObjects);
		long end1 = System.currentTimeMillis();
		logs.info("objson--"+ jsonObj + " tiempo = " + Long.toString(end1-ini1));
    	*/
//		long ini2 = System.currentTimeMillis();
    	json.append("{\"total\":"+totalPaginas+",\"page\":"+numeroPagina+",\"records\": "+totalFilas+",\"rows\":[");
    	for (int i = 0; i < listaPaginaAplicaciones.size(); i++){
    		//Si el json es el ultimo no debe llevar la coma
    		webroot = listaPaginaAplicaciones.get(i).getWebroot()==null?" ":listaPaginaAplicaciones.get(i).getWebroot();	    		
    		inicio = listaPaginaAplicaciones.get(i).getInicio()==null?" ":listaPaginaAplicaciones.get(i).getInicio();
    		if ((i+1) == listaPaginaAplicaciones.size()){
    			json.append("{\"id\":"+listaPaginaAplicaciones.get(i).getId()+",\"webroot\":\"" + webroot +"\",\"descripcion\":\""+listaPaginaAplicaciones.get(i).getNombre() + "\",\"inicio\":\""+ inicio + "\"}");	    				
    		}	
    		else
    			json.append("{\"id\":"+listaPaginaAplicaciones.get(i).getId()+",\"webroot\":\"" + webroot +"\",\"descripcion\":\""+listaPaginaAplicaciones.get(i).getNombre()+"\",\"inicio\":\""+ inicio + "\"},");	    		
    	}	    	
    	json.append("]}");
//    	long end2 = System.currentTimeMillis(); 
//    	logs.info("json--"+ json.toString() + " tiempo = " + Long.toString(end2-ini2));
    	sgteServicio = null;		
	}

	/* (non-Javadoc)
	 * @see servicios.wsapi.FceObjectInterface#getObjectResult()
	 */
	@Override
	public Object getObjectResult() {
		if(json.length() == 0)
			return null;
		else{
			copyRequest.setAttribute("fmtSalida", "json");
			return json.toString();
		}
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
}
