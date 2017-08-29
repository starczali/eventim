package events.formatters;

import java.text.ParseException;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.Formatter;
import org.springframework.stereotype.Component;

import events.model.Event;
import events.service.FetchService;

@Component
public class EventFormatter implements Formatter<Event>{

	@Autowired
	private FetchService fetchService;
	
	public String print(Event event, Locale locale) {
		return event.getName();
	}

	public Event parse(String text, Locale locale) throws ParseException {
		Integer id = Integer.parseInt(text);
		return fetchService.getEventById(id);
	}
	
}
