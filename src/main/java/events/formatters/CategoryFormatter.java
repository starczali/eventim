package events.formatters;

import java.text.ParseException;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.Formatter;
import org.springframework.stereotype.Component;

import events.model.Category;
import events.service.FetchService;

@Component
public class CategoryFormatter implements Formatter<Category>{
	@Autowired
	private FetchService fetchService;
	
	public String print(Category category, Locale locale) {
		return category.getType();
	}

	public Category parse(String text, Locale locale) throws ParseException {
		Integer id = Integer.parseInt(text);
		return fetchService.getCategoryById(id);
	}
}
