package events.database;
import static org.junit.Assert.*;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import events.model.Event;
import events.model.Ticket;
import events.model.User;
import events.service.FetchService;
import events.service.ManageService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:spring-test-config.xml")

public class TicketTest {

	@Autowired
	private FetchService fetchService;
	
	@Autowired
	private ManageService manageService;
	
	
	@Test
	public void testAddTicket(){
		Ticket ticket = new Ticket();
		Event event = fetchService.getEventById(2);
		User user = fetchService.getUserById(2);
		ticket.setBarcode(1436251312L);
		ticket.setUser(user);
		ticket.setEvent(event);
		manageService.saveTicket(ticket);
		assertNotNull(ticket.getId());
		int size = fetchService.getAllTickets().size();
		manageService.deleteTicket(ticket);
		assert fetchService.getAllTickets().size() == size-1;
		
		
	}
	
	@Test
	public void testFindTicketById(){
		Ticket ticket = fetchService.getTicketById(2);
		assertNotNull(ticket);
	}
	
	@Test
	public void testDeleteTicket(){
		
		Ticket ticket = new Ticket();
		Event event = fetchService.getEventById(2);
		User user = fetchService.getUserById(2);
		ticket.setBarcode(1234567L);
		ticket.setUser(user);
		ticket.setEvent(event);
		manageService.saveTicket(ticket);
		
		int id = ticket.getId();
		
		int size = fetchService.getAllTickets().size();
		Ticket ticket2 = fetchService.getTicketById(id);
		manageService.deleteTicket(ticket2);
		ticket = fetchService.getTicketById(id);
		assertNull(ticket);
		assert fetchService.getAllTickets().size()== size-1;
	}
	
	@Test
	public void testDeleteTicketById(){
		
		Ticket ticket = new Ticket();
		Event event = fetchService.getEventById(2);
		User user = fetchService.getUserById(2);
		ticket.setBarcode(1234567L);
		ticket.setUser(user);
		ticket.setEvent(event);
		manageService.saveTicket(ticket);
		int id = ticket.getId();
		
		int size = fetchService.getAllTickets().size();
		manageService.deleteTicketById(id);
		Ticket ticket2 = fetchService.getTicketById(id);
		assertNull(ticket2);
		assert fetchService.getAllTickets().size()==size-1;
		
	}
	
	@Test
	public void testGetAllTickets(){
		List<Ticket> ticketList = fetchService.getAllTickets();
		assertNotNull(ticketList);
		
	}
	
}
