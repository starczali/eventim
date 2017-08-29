package events.dao.impl;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import events.dao.EventDAO;
import events.model.Event;
import org.springframework.transaction.annotation.Transactional;

@Repository
@Transactional
public class EventDAOImpl implements EventDAO {
	
	@Autowired
	private SessionFactory sessionFactory;
	
	private Session getCurrentSession() {
		  return sessionFactory.getCurrentSession();
	}
	
	public Event findEventById(Integer id) {
		Query query = getCurrentSession().createQuery("from Event where id = :id ");
		query.setParameter("id", id);
		return (Event) query.uniqueResult();
	}

	@SuppressWarnings("unchecked")
	public List<Event> getAllEvents() {
		String query = new String("from Event");
		return getCurrentSession().createQuery(query).list();
	}

	public void saveEvent(Event event) {
		getCurrentSession().saveOrUpdate(event);
	}

	public void deleteEvent(Event event) {
		getCurrentSession().delete(event);
	}

	public void deleteEvent(Integer id) {
		Query query = getCurrentSession().createQuery("delete Event where id = :id ");
		query.setParameter("id", id);
		query.executeUpdate();
	}

	/*
	* Gets All events that are not expired !
	* The Parameters of the function are optional !
	* The values for the parameters to not be taken in consideration are:
	* location "", artistId=-1
	* */
	@SuppressWarnings("unchecked")
	public List<Event> getNextEvents(String location,Integer categoryId) {
		String hql = "from Event where startDate >= :currentdate";

		if(StringUtils.isNotBlank(location)){
			hql+=" and location = :loc";
		}
		if(categoryId!=-1){
			hql+=" and category_id = :catid";
		}

		hql+=" order by startDate desc";
		Query query = getCurrentSession().createQuery(hql);
		query.setParameter("currentdate", new Date());

		if(StringUtils.isNotBlank(location)){
			query.setParameter("loc",location);
		}
		if(categoryId!=-1){
			query.setParameter("catid",categoryId);
		}
		return query.list();
	}

	public List<Event> getNextEventsForArtist(Integer artistId) {
		String hql = "from Event event join fetch event.artists artist where startDate >= :currentdate and artist.id=:artid order by startDate desc";
		Query query = getCurrentSession().createQuery(hql);
		query.setParameter("currentdate", new Date());
		query.setParameter("artid",artistId);
		return query.list();
	}

	@Override
	public List<Event> getLimitedEvents(Integer limit) {
		String hql = "from Event where startDate >= :currentdate";

		hql+=" order by startDate desc";
		Query query = getCurrentSession().createQuery(hql).setMaxResults(limit);
		query.setParameter("currentdate", new Date());

		return query.list();
	}

}
