package events.dao.impl;

import events.dao.TemporaryUserDAO;
import events.model.TemporaryUser;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
@Transactional
public class TemporaryUserDAOImpl implements TemporaryUserDAO {

    @Autowired
    private SessionFactory sessionFactory;

    private Session getCurrentSession() {
        return sessionFactory.getCurrentSession();
    }

    public TemporaryUser findTemporaryUserById(Integer id) {
        String hql = "from TemporaryUser where id= " + id;
        return (TemporaryUser) getCurrentSession().createQuery(hql).uniqueResult();
    }

    public List<TemporaryUser> getAllTemporaryUsers() {
        String hql="from TemporaryUser";
        return getCurrentSession().createQuery(hql).list();
    }

    public void saveTemporaryUser(TemporaryUser user) {
        getCurrentSession().saveOrUpdate(user);
    }

    public void deleteTemporaryUser(TemporaryUser user) {
        getCurrentSession().delete(user);
    }

    public void deleteTemporaryUserById(Integer id) {
        String hql = "delete from TemporaryUser where id= " + id;
        getCurrentSession().createQuery(hql).executeUpdate();
    }



}
