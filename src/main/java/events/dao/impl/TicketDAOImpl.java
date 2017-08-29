package events.dao.impl;

import events.dao.TicketDAO;
import events.model.Ticket;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigInteger;
import java.util.List;

@Repository
@Transactional
public class TicketDAOImpl implements TicketDAO{

    @Autowired
    private SessionFactory sessionFactory;

    private Session getCurrentSession() {
        return sessionFactory.getCurrentSession();
    }

    public Ticket findByTicketId(Integer id) {
        return (Ticket) getCurrentSession().createQuery("from Ticket t where t.id= :tid")
                .setParameter("tid",id).uniqueResult();
    }

    @SuppressWarnings("unchecked")
	public List<Ticket> getAllTickets() {
        String hql = "from Ticket";
        return getCurrentSession().createQuery(hql).list();
    }

    public void saveTicket(Ticket ticket) {
        getCurrentSession().saveOrUpdate(ticket);
    }

    public void deleteTicket(Ticket ticket) {
        getCurrentSession().delete(ticket);
    }

    public void deleteTicketById(Integer id) {
        getCurrentSession().createQuery("delete from Ticket t where t.id="+id).executeUpdate();
    }

    
    
	@SuppressWarnings("unchecked")
	public List<Ticket> getUserTickets(Integer userId) {
		 return getCurrentSession().createQuery("from Ticket t where t.user.id= :tid").setParameter("tid",userId).list();
	}
	
	public Long getNextBarcode() {
		String sql = "SELECT nextval('barcode_seq')";
		return ((BigInteger) getCurrentSession().createSQLQuery(sql).uniqueResult()).longValue();
	}
}
