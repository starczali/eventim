package events.dao.impl;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import events.dao.CategoryDAO;
import events.model.Category;
import org.springframework.transaction.annotation.Transactional;

@Repository
@Transactional
public class CategoryDAOImpl implements CategoryDAO{

	@Autowired
	private SessionFactory sessionFactory;
	private Session getCurrentSession() {
		return sessionFactory.getCurrentSession();
	 	}
	
	
	public Category findCategoryById(Integer id) {
		String hql = "from Category where id=" + id;
		return (Category) getCurrentSession().createQuery(hql).uniqueResult();
	}


	public List<Category> getAllCategories() {
		String hql ="from Category";
		return getCurrentSession().createQuery(hql).list();
	}


	public void saveCategory(Category category) {
		getCurrentSession().saveOrUpdate(category);
	}

	public void deleteCategory(Category category) {
		getCurrentSession().delete(category);		
	}

	public void deleteCategoryById(Integer id) {
		String hql = "delete from Category where id=" + id;
		getCurrentSession().createQuery(hql).executeUpdate();		
	}

	
}
