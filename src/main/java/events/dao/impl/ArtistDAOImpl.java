package events.dao.impl;

import java.util.Date;
import java.util.List;

import events.model.Event;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import events.dao.ArtistDAO;
import events.model.Artist;

@Repository
@Transactional
public class ArtistDAOImpl implements ArtistDAO {

	@Autowired
	private SessionFactory sessionFactory;

	private Session getCurrentSession() {
		return sessionFactory.getCurrentSession();
	}
	
	public Artist findArtistById(Integer id) {
		String hql = "from Artist where id =" + id;
		return (Artist) getCurrentSession().createQuery(hql).uniqueResult();
	}

	@SuppressWarnings("unchecked")
	public List<Artist> getAllArtists() {
		String hql = "from Artist";
		return getCurrentSession().createQuery(hql).list();
	}

	public void saveArtist(Artist artist) {
		getCurrentSession().saveOrUpdate(artist);
	}

	public void deleteArtist(Artist artist) {
		getCurrentSession().delete(artist);
	}

	public void deleteArtistById(Integer id) {
		String hql = "delete from Artist where id = " + id;
		getCurrentSession().createQuery(hql).executeUpdate();
	}

	public List<Artist> getArtistsByEvent(Integer eventId) {
		String hql = "from Artist artist join fetch artist.events event where event.id=:evid";
		Query query = getCurrentSession().createQuery(hql);
		query.setParameter("evid",eventId);
		return query.list();
	}

}
