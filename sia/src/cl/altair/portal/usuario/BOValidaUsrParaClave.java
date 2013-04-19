package cl.altair.portal.usuario;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Calendar;
import java.util.Properties;
import java.util.Scanner;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import cl.altair.perfilamiento.control.Perfilador;
import cl.altair.portal.registro.SMTPAuthenticator;
import cl.mycompany.perfilamiento.model.Usuario;
import cl.altair.utiles.generales.SendMail;
import cl.altair.utiles.generales.SimpleEncryption;

import servicios.generales.*;
import servicios.wsapi.BusinessObjectClass;
import servicios.wsapi.FceObjectInterface;

public class BOValidaUsrParaClave extends BusinessObjectClass
implements FceObjectInterface
{
	Integer integer;
	String weblogin = "";
	String webclave = "";
	private StringBuilder html = new StringBuilder();

	public BOValidaUsrParaClave()
	{
	}

	public void getContext(HttpServletRequest httpservletrequest)
	{
		copySesion = httpservletrequest.getSession(false); 
		copyRequest = httpservletrequest;
		weblogin = httpservletrequest.getParameter("emailc");
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
	}

	/**
	 * @param outputservicebean
	 * @throws WSException
	 * @throws WSPgrmCallException
	 */
	public void getServiceResult(OutputServiceBean outputservicebean)
	throws WSException, WSPgrmCallException
	{  
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

	
	  private StringBuilder read(String nombreArchivo) throws IOException {
		    logs.debug("Reading from file.");
		    StringBuilder text = new StringBuilder();
		    String NL = System.getProperty("line.separator");
		    Scanner scanner = new Scanner(copySesion.getServletContext().getResourceAsStream(nombreArchivo), "ISO-8859-1");
		    try {
		      while (scanner.hasNextLine()){
		        text.append(scanner.nextLine() + NL);
		      }
		    }
		    finally{
		      scanner.close();
		    }
		    return text;
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
			if(weblogin == null || weblogin.equalsIgnoreCase("")) {
				logs.info("Clase: BOValidaUsrParaClave - Msg: Rut " + weblogin + " No se envio el email");		    	
				//Configura la salida para escribir los mensajes
		    	html.append("Campo email es obligatorio");
		    	copyResponse.addHeader("ERROR","1");
				sgteServicio = null;
				return;
			}
//			String[] temp = weblogin.split("-");
//			weblogin = temp[0].replace(".", "")+temp[1].toUpperCase();
			Usuario usuario = profiler.getUsuario(weblogin);
			if(usuario == null) {
				logs.info("Clase: BOValidaUsrParaClave - Msg: Correo electr&oacute;nico " + weblogin + " sin Usuario registrado");		    	
				//Configura la salida para escribir los mensajes
		    	html.append("Usuario no esta registrado en nuestra empresa");
		    	copyResponse.addHeader("ERROR","1");
				sgteServicio = null;
				return;
			} else if(usuario.getEmail() == null || usuario.getEmail().equalsIgnoreCase("")){
					logs.info("Clase: BOValidaUsrParaClave - Error: Usuario rut "+ weblogin + " no posee correo");					
			    	html.append("Usted no posee un correo electr&oacute;nico registrado con nosotros");				
			    	copyResponse.addHeader("ERROR","1");
					sgteServicio = null;	
					return;
				}  else {
					//Se obtiene el instante de inicio para contar las 2 horas
					long startTime = Calendar.getInstance().getTimeInMillis();
					SimpleEncryption web_cryptpass = new SimpleEncryption();
					//Se encripta el token
					String token = web_cryptpass.encode(web_cryptpass.encrypt(weblogin + "_" + Long.toString(startTime)));
					String link = copyRequest.getScheme() + "://" + copyRequest.getServerName() + ":" + copyRequest.getServerPort() + "/sia/fce?token=" + token + "&reqName=prgvallink";
					logs.debug("Link a enviar por correo = " + link);
					//Se lee el texto desde el template que esta en el disco
					StringBuilder texto = read(copySesion.getServletContext().getInitParameter("correo"));
					//Reemplazo el texto con la URL a enviar
					int ini= texto.indexOf("%link%");
					texto.replace(ini, ini+6, link);
					//Se envia el correo
					SendMail.sendMail(usuario.getEmail().trim(), texto.toString(), "Solicitud de Clave");
					logs.info("Clase: BOValidaUsrParaClave - Msg: Usuario "+ weblogin + " solicito clave y se envio LINK al correo " + usuario.getEmail());
					//Se incorpora esta informacion para discriminar en el JS si se trata solo de un mensaje o de la pagina de respuesta
					copyResponse.addHeader("ERROR","0");
					sgteServicio = null;
					return;
				}
		}
		catch(Exception exception)	{	
			//Se requiere setear esto para que la respuesta del error se devuelva via AJAX y no llamando a una pagina
			exception.printStackTrace();
			if(exception instanceof WSPgrmCallException)
			{
				throw (WSPgrmCallException)exception;
			}
			if(exception instanceof WSException)
			{
				throw (WSException)exception;
			} else
			{
				throw new WSException("Clase: BOValidaUsrParaClave: Msg-Error en el objeto de negocios -  ERROR: " + exception.getMessage());
			}
		}
	}

	@Override
	public Object getObjectResult() {
		if(html.length() == 0)
			return null;
		else {
			copyRequest.setAttribute("fmtSalida", "html");
			return html.toString();
		}
	}

	@Override
	public void init(HttpServletRequest req, HttpServletResponse res) {
		// TODO Auto-generated method stub
		
	}
	
	public void sendMail(String to, String mensaje, String subject) throws UnsupportedEncodingException, MessagingException {
		try {
			//Configuracion de las propiedades para el envio de correos via gmail
			Properties properties = new Properties();
			properties.put("mail.smtp.auth", "true");
			properties.put("mail.smtp.host", "smtp.gmail.com");
			properties.put("mail.smtp.port", "465");
			properties.put("mail.smtp.user", "lenpino");
			properties.put("mail.smtp.password", "m13d2n");
			properties.put("mail.smtp.from", "lenpino@gmail.com");
			properties.put("mail.smtp.socketFactory.port", "465");
			properties.put("mail.smtp.starttls.enable","true");
			properties.put("mail.smtp.debug", "true");
			properties.put("mail.smtp.socketFactory.fallback", "false");
			properties.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");

			SMTPAuthenticator auth = new SMTPAuthenticator();
			Session session = Session.getInstance(properties, auth);
			session.setDebug(true);

			MimeMessage msg = new MimeMessage(session);
			msg.setText(mensaje);
			msg.setSubject(new String(subject.getBytes(), "iso-8859-1"), "iso-8859-1");
			msg.setFrom(new InternetAddress(properties.getProperty("mail.smtp.from")));
			msg.addRecipient(Message.RecipientType.TO, new InternetAddress(to));

			Transport transport = session.getTransport("smtps");
			transport.connect(properties.getProperty("mail.smtp.host"),
					465,
					"lenpino",
					"password");
			transport.sendMessage(msg, msg.getAllRecipients());
			transport.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
}

}
