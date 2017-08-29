package events.dao;

import events.model.Ticket;

import java.util.List;

public interface TicketDAO {

    Ticket findByTicketId(Integer id);
    List<Ticket> getAllTickets();
    void saveTicket(Ticket ticket);
    void deleteTicket(Ticket ticket);
    void deleteTicketById(Integer id);
    List<Ticket> getUserTickets(Integer userId);
    Long getNextBarcode();
}
