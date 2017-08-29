package events.controller;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import events.model.Category;
import events.service.FetchService;
import events.service.ManageService;

@Controller
@RequestMapping("/categories")
public class CategoryController {

	@Autowired
	private ManageService manageService;
	
	@Autowired
	private FetchService fetchService;
	
	@RequestMapping("/createCategory")
	public ModelAndView createCategory(Model uiModel) {
		Category category = new Category();
		try {
			uiModel.addAttribute("categories" , fetchService.getAllCategories());
			uiModel.addAttribute("category", category);
			return new ModelAndView("createCategory");
		} catch (Exception ex) {
			System.out.println(ex.getMessage());
			return new ModelAndView("createCategory", uiModel.asMap());
		}
	}

	@RequestMapping("/processCategory")
	@ResponseBody
	public String processCategory(@Valid Category category, BindingResult result, Model uiModel) {
		try {
			if(result.hasErrors()) {
				uiModel.addAttribute("errorMessage","NOOOOOOOO");
				return "failed";
			}
			manageService.saveCategory(category);
			return "success";
		} catch (Exception ex) {
			System.out.println(ex.getMessage());
			return "failed";
		}
	}

	@RequestMapping("/updateCategory")
	public ModelAndView updateCategory(@RequestParam(value = "idValue", required = true) Integer id, Model uiModel) {
		try {
			Category category = fetchService.getCategoryById(id);
			uiModel.addAttribute("category", category);
			return new ModelAndView("updateCategory");
		} catch (Exception ex) {
			System.out.println(ex.getMessage());
			return new ModelAndView("updateCategory", uiModel.asMap());
		}
	}

	@RequestMapping("/listCategories")
	public ModelAndView listCategories(Model uiModel) {
		try {
			List<Category> categories = fetchService.getAllCategories();
			uiModel.addAttribute("categories" , categories);
			return new ModelAndView("listCategories");
		} catch (Exception ex) {
			System.out.println(ex.getMessage());
			return new ModelAndView("listCategories", uiModel.asMap());
		}
	}
	
	@RequestMapping("/removeCategory")
	@ResponseBody
	public String removeCategory(@RequestParam(value = "idValue", required = true) Integer id, Model uiModel) {
		try {
			manageService.deleteCategoryById(id);
			return "success";
		} catch (Exception ex) {
			System.out.println(ex.getMessage());
			return "failed";
		}
	}
	
	@RequestMapping("/processUpdateCategory")
	@ResponseBody
	public String processUpdateCategory(@Valid Category category, BindingResult result, Model uiModel) {
		try {
			if(result.hasErrors()) {
				uiModel.addAttribute("category", category);
				uiModel.addAttribute("errorMessage", "Invalid input!");
				
				return "failed";
			}
			manageService.saveCategory(category);
			return "success";
		} catch (Exception ex) {
			System.out.println(ex.getMessage());
			return "failed";
		}
	}
}
