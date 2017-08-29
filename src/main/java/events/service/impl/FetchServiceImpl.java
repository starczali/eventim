package events.service.impl;

import java.util.List;

import events.dao.*;
import events.model.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import events.service.FetchService;

@Service
@Transactional
public class FetchServiceImpl implements FetchService {

	@Autowired
	private ArtistDAO artistDao;
	
	@Autowired
	private CategoryDAO categoryDao;
	
	@Autowired
	private EventDAO eventDao;
	
	@Autowired
	private TicketDAO ticketDao;
	
	@Autowired
	private UserDAO userDao;

	@Autowired
	private TemporaryUserDAO temporaryUserDAO;

	public List<Artist> getAllArtists() {
		return artistDao.getAllArtists();
	}

	public List<Category> getAllCategories() {
		return categoryDao.getAllCategories();
	}

	public List<Event> getAllEvents() {
		return eventDao.getAllEvents();
	}

	public List<Ticket> getAllTickets() {
		return ticketDao.getAllTickets();
	}

	public List<User> getAllUsers() {
		return userDao.getAllUsers();
	}

	public List<TemporaryUser> getAllTemporaryUsers() {
		return temporaryUserDAO.getAllTemporaryUsers();
	}

	public Artist getArtistById(Integer id) {
		return artistDao.findArtistById(id);
	}

	public Category getCategoryById(Integer id) {
		return categoryDao.findCategoryById(id);
	}

	public Event getEventById(Integer id) {
		return eventDao.findEventById(id);
	}

	public Ticket getTicketById(Integer id) {
		return ticketDao.findByTicketId(id);
	}

	public User getUserById(Integer id) {
		return userDao.findUserById(id);
	}

	public List<Ticket> getUserTickets(Integer userId) {
		return ticketDao.getUserTickets(userId);
	}

	@Override
	public List<Event> getEventsByLocation(String location) {
		return eventDao.getNextEvents(location,-1);
	}

	@Override
	public List<Event> getEventByCategory(Integer categoryId) {
		return eventDao.getNextEvents("",categoryId);
	}

	public User findUserAtLogin(String username) {
		return userDao.findUserAtLogin(username);
	}
	
	public TemporaryUser getTemporaryUserById(Integer id) {
		return temporaryUserDAO.findTemporaryUserById(id);
	}

	public Long getNextBarcode() {
		return ticketDao.getNextBarcode();
	}

	public List<Event> getNextEvents() {
		return eventDao.getNextEvents("",-1);
		
	}

	@Override
	public List<Event> getLimitedEvents(Integer limit) {
		return eventDao.getLimitedEvents(limit);
	}

	public List<Event> getEventsByArtist(Integer artistId) {
		return eventDao.getNextEventsForArtist(artistId);
	}

	@Override
	public List<Artist> getArtistByEvent(Integer eventId) {
		return artistDao.getArtistsByEvent(eventId);
	}

}
