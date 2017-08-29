package events.formatters;

import java.text.ParseException;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.Formatter;
import org.springframework.stereotype.Component;

import events.model.User;
import events.service.FetchService;

@Component
public class UserFormatter implements Formatter<User> {

	@Autowired
	private FetchService fetchService;
	
	public String print(User user, Locale locale) {
	return user.getName();
	}

	public User parse(String text, Locale locale) throws ParseException {
		Integer id = Integer.parseInt(text);
		return fetchService.getUserById(id);
	}

}
