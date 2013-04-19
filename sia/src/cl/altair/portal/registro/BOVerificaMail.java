/**
 * 
 */
package cl.altair.portal.registro;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.security.SecureRandom;
import java.util.Date;
import java.util.Properties;
import java.util.Scanner;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.naming.InitialContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cl.altair.modelo.portal.Registro;
import cl.altair.modelo.portal.RegistroDAO;
import cl.altair.perfilamiento.control.Perfilador;
import cl.altair.perfilamiento.model.dao.EntityManagerHelper;
import cl.altair.portal.registro.SMTPAuthenticator;

import servicios.generales.WSException;
import servicios.generales.WSPgrmCallException;
import servicios.wsapi.BusinessObjectClass;
import servicios.wsapi.FceObjectInterface;

/**
 * @author lpino
 *
 */
public class BOVerificaMail extends BusinessObjectClass implements
		FceObjectInterface {

	private StringBuilder html = new StringBuilder();
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
		try {
			SecureRandom random = new SecureRandom();
			java.util.Date utilDate = new java.util.Date();
			//fecha actual
			long lnMilisegundos = utilDate.getTime();
			java.sql.Timestamp fechaActual = new java.sql.Timestamp(lnMilisegundos);
			RegistroDAO rdao = new RegistroDAO();
			Registro elRegistro = new Registro();
			logs.info("Clase: BOVerificaMail - MSG: Asignando valores del formulario al registro:");
			
			elRegistro.setFechaRegistro(fechaActual);
			elRegistro.setFechaUltimaActualizacion(fechaActual);
			Long codigo = Math.abs(new BigInteger(130, random).longValue());
			elRegistro.setCodigoAuditoria(codigo);
			elRegistro.setEstado("validacioncorreo");
			String email = copyRequest.getParameter("emailUsuario");	
			//Valida que el email sea unico
			// El usuario ingresado no existe o si su clave es incorrecta
			Perfilador profiler = new Perfilador();
			if(profiler.getUsuario(email) != null) {
				logs.info("BOVerificaMail - MSG: El correo " + email + " ya esta registrado");
				html.append("El correo " + email + " ya esta registrado");
				copyResponse.addHeader("ERROR","1");
				this.sgteServicio = null;
				return;				
			}
			elRegistro.setEmail(email);
			logs.info("Clase: BOVerificaMail - MSG: Valores del formulario asignados al registro");
			
			EntityManagerHelper.beginTransaction();
			rdao.save(elRegistro);
			EntityManagerHelper.commit();
			EntityManagerHelper.closeEntityManager();
			logs.info("Clase: BOVerificaMail - MSG: Registro grabado en base de datos:");
			
			//Prepracion y envio de correo al cliente
			String link = copyRequest.getScheme() + "://" + copyRequest.getServerName() + ":" + copyRequest.getServerPort() + "/sia/fce?codigo=" + codigo + "&reqName=prgvalmail";
			logs.info("Clase: BOVerificaMail - MSG: Link a enviar por correo = " + link);			
			//Se lee el texto desde el template que esta en el disco
			StringBuilder texto = read(copyRequest.getSession().getServletContext().getInitParameter("validaMail"));
			//Reemplazo el texto con la URL a enviar
			int ini= texto.indexOf("%link%");
			texto.replace(ini, ini+6, link);
			//Se envia el correo
			sendMail(email, texto.toString(), "Solicitud de Registro en XXXX.cl");
//			sendMail(email, texto.toString(), "Solicitud de Certificado – Portal de Acepta.com", null);
			logs.info("Clase: BOVerificaMail - Msg: Usuario solicito certificado y se envio LINK al correo " + email);
			//Se escribe el mensaje de salida para la pagina de respuesta
			html.append("CORREO ENVIADO CON EXITO A " + email);
		} catch (Exception e) {
			e.printStackTrace();
		}
		//Se incorpora esta informacion para discriminar en el JS si se trata solo de un mensaje o de la pagina de respuesta
		copyResponse.addHeader("ERROR","0");
		sgteServicio = null;
		return;
	}

	/* (non-Javadoc)
	 * @see servicios.wsapi.FceObjectInterface#getObjectResult()
	 */
	@Override
	public Object getObjectResult() {
		if(html.length() == 0)
			return null;
		else{
			copyRequest.setAttribute("fmtSalida", "html");
			return html.toString();
		}
	}

	/* (non-Javadoc)
	 * @see servicios.wsapi.FceObjectInterface#init(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 */
	@Override
	public void init(HttpServletRequest req, HttpServletResponse res) {
		// TODO Auto-generated method stub

	}

	public void sendMail(String to, String mensaje, String subject, String[][] files) throws UnsupportedEncodingException, MessagingException {
		// create some properties and get the default Session
		try {
			InitialContext initCtx = new InitialContext();
			Session session = (Session) initCtx.lookup("java:comp/env/mail/webapp");
			//create a message
			MimeMessage msg = new MimeMessage(session);
			msg.setFrom(new InternetAddress("mail.smtp.from"));
			InternetAddress[] address = {new InternetAddress(to)};
			msg.setRecipients(Message.RecipientType.TO, address);
			msg.setSubject(new String(subject.getBytes(), "UTF-8"), "UTF-8");
			//msg.setSubject(this.subject);
			
			//create and fill the first message part
			MimeBodyPart mbp1 = new MimeBodyPart();
			
			//mbp1.setContent(this.mesaje, "text/html");
			//mbp1.setContent(mensaje, "text/html; charset=\"iso-8859-1\"");
			mbp1.setText(mensaje);
			
			//create the Multipart and add its parts to it
			Multipart mp = new MimeMultipart();
			mp.addBodyPart(mbp1);	    
			
			if (files != null) { 
				BodyPart messageBodyPart = new MimeBodyPart();
				for (int i=0, n=files.length; i<n; i++) {
				  File f = new File(files[i][0]);
				  if (f.isFile()) {
					messageBodyPart = new MimeBodyPart();
					DataSource source = new FileDataSource(files[i][0]);
					messageBodyPart.setDataHandler(new DataHandler(source));
					messageBodyPart.setFileName(files[i][1]);
					mp.addBodyPart(messageBodyPart);
				 }
				}
			}
			
			//add the Multipart to the message
			msg.setContent(mp);
			
			//set the Date: header
			msg.setSentDate(new Date());
			
			//send the message
			Transport.send(msg);
		} catch (Exception e) {
			e.printStackTrace();
		}

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

	  private StringBuilder read(String nombreArchivo) throws IOException {
		    StringBuilder text = new StringBuilder();
		    String NL = System.getProperty("line.separator");
		    Scanner scanner = new Scanner(copyRequest.getSession().getServletContext().getResourceAsStream(nombreArchivo), "ISO-8859-1");
		    try {
		      while (scanner.hasNextLine()){
		        text.append(scanner.nextLine() + NL);
		      }
		    }
		    finally{
		      scanner.close();
		    }
		    logs.info("Clase: BOVerificaMail - MSG: Template de correo leido:");
		    return text;
		  }
}
