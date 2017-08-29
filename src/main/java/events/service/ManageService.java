package events.service;

import events.model.*;

public interface ManageService {

	void saveArtist(Artist artist);

	void deleteArtist(Artist artist);

	void deleteArtistById(Integer id);

	void saveCategory(Category category);

	void deleteCategory(Category category);

	void deleteCategoryById(Integer id);

	void saveTemporaryUser(TemporaryUser temporaryUser);

	void deleteTemporaryUser(TemporaryUser temporaryUser);

	void deleteTemporaryUserById(Integer id);

	void saveEvent(Event event);

	void deleteEvent(Event event);

	void deleteEvent(Integer id);

	void saveTicket(Ticket ticket);

	void deleteTicket(Ticket ticket);

	void deleteTicketById(Integer id);

	void saveUser(User user);

	void deleteUser(User user);

	void deleteUserById(Integer id);
}
