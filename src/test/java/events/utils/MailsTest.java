package events.utils;

import java.io.IOException;

import javax.mail.MessagingException;

//Deprecated
public class MailsTest {

	public void testMail() throws MessagingException, IOException, InterruptedException  {
		
		
		String body = "This is another test";
		String recipientMailAdress = "geraldlionb@gmail.com";
		
		MailUtil.sendMail("Subject", body, recipientMailAdress);
		
		Thread.sleep(60000);

	}
	public static void main(String[] args) {
		
		String body = "Gerri";
		String recipientMailAdress = "geraldlionb@gmail.com";
		
		MailUtil.sendMail("Test",body, recipientMailAdress);
		
	}

}
