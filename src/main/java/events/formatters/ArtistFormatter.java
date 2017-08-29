package events.formatters;

import java.text.ParseException;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.Formatter;
import org.springframework.stereotype.Component;

import events.model.Artist;
import events.service.FetchService;

@Component
public class ArtistFormatter implements Formatter<Artist> {
	@Autowired
	private FetchService fetchService;

	public String print(Artist artist, Locale locale) {
		return artist.getName();
	}

	public Artist parse(String text, Locale locale) throws ParseException {
		Integer id = Integer.parseInt(text);
		return fetchService.getArtistById(id);
	}
}
