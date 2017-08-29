package events.database;

import events.model.Category;
import events.service.FetchService;
import events.service.ManageService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

import static org.junit.Assert.*;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:spring-test-config.xml")
public class CategoryTest {

    @Autowired
    private FetchService fetchService;

    @Autowired
    private ManageService manageService;

    @Test
    public void testGetAll(){
        List<Category> categoryList = fetchService.getAllCategories();
        assertNotNull(categoryList);
        assertFalse(categoryList.isEmpty());
    }

    @Test
    public void testGetById(){
        assertEquals(fetchService.getCategoryById(1).getType(),"THEATRE");
        assertEquals(fetchService.getCategoryById(2).getType(),"MUSIC");
        assertEquals(fetchService.getCategoryById(3).getType(),"DANCE");
    }



    @Test
    public void testAddCategory(){
        Category category1 = new Category();
        category1.setType("Folk");
        Category category2 = new Category();
        category2.setType("lala");
        Category category3 = new Category();
        category3.setType("painting");
        assert fetchService.getAllCategories().size()==3;
        manageService.saveCategory(category1);
        assert fetchService.getAllCategories().size()==4;
        assert fetchService.getAllCategories().get(3).getType().equals("Folk");

        manageService.saveCategory(category2);
        assertEquals(fetchService.getAllCategories().size(),5);
        assertEquals(fetchService.getAllCategories().get(4).getType(),"lala");
        category2.setType("new");
        manageService.saveCategory(category2);
        assertEquals(fetchService.getAllCategories().size(),5);
        assertEquals(fetchService.getAllCategories().get(4).getType(),category2.getType());

        manageService.saveCategory(category3);
        assertEquals(fetchService.getAllCategories().size(),6);
        manageService.deleteCategory(category1);
        manageService.deleteCategory(category2);
        manageService.deleteCategory(category3);
    }

    @Test
    public void testDeleteCategory(){
        Category category1 = new Category();
        category1.setType("Folk");
        Category category2 = new Category();
        category2.setType("funk");
        Category category3 = new Category();
        category3.setType("lust");
        assertEquals(fetchService.getAllCategories().size(),3);
        manageService.saveCategory(category1);
        manageService.saveCategory(category2);
        manageService.saveCategory(category3);
        assertEquals(fetchService.getAllCategories().size(),6);
        manageService.deleteCategory(category1);
        assertEquals(fetchService.getAllCategories().size(),5);
        manageService.deleteCategory(category2);
        assertEquals(fetchService.getAllCategories().size(),4);
        manageService.deleteCategory(category3);
        assertEquals(fetchService.getAllCategories().size(),3);
    }

    @Test
    public void testDeleteCategoryById(){
        Category category1 = new Category();
        category1.setType("Folk");
        Category category2 = new Category();
        category2.setType("funk");
        Category category3 = new Category();
        category3.setType("lust");
        assertEquals(fetchService.getAllCategories().size(),3);
        manageService.saveCategory(category1);
        manageService.saveCategory(category2);
        manageService.saveCategory(category3);
        assertEquals(fetchService.getAllCategories().size(),6);
        manageService.deleteCategoryById(category1.getId());
        assertEquals(fetchService.getAllCategories().size(),5);
        manageService.deleteCategoryById(category2.getId());
        assertEquals(fetchService.getAllCategories().size(),4);
        manageService.deleteCategoryById(category3.getId());
        assertEquals(fetchService.getAllCategories().size(),3);
    }
}
