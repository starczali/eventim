package events.dao;

import java.util.List;

import events.model.Category;

public interface CategoryDAO {

	public Category findCategoryById(Integer id);
	
	public List<Category> getAllCategories();
	
	public void saveCategory(Category category);
	
	public void deleteCategory(Category category);
	
	public void deleteCategoryById(Integer id);
	
}
