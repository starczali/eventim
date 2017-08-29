package events.dao;

import java.util.List;

import events.model.Artist;
import events.model.Event;


public interface ArtistDAO {

	Artist findArtistById(Integer id);
	List<Artist> getAllArtists();
	void saveArtist(Artist artist);
	void deleteArtist(Artist artist);
	void deleteArtistById(Integer id);
	List<Artist> getArtistsByEvent(Integer eventId);
}
