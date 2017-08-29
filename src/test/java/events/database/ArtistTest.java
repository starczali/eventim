package events.database;

import static org.junit.Assert.*;

import java.text.ParseException;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import events.model.Artist;
import events.service.FetchService;
import events.service.ManageService;

@ContextConfiguration(locations = "classpath:spring-test-config.xml")
@RunWith(SpringJUnit4ClassRunner.class)
public class ArtistTest {
	
	@Autowired
	private FetchService fetchService;
	
	@Autowired
	private ManageService manageService;
	
	@Test
	public void testAddArtist() throws ParseException {
		Artist artist = new Artist();
		artist.setName("TestArtistNameX2");
		
		artist.addEvent(fetchService.getEventById(1));
		artist.addEvent(fetchService.getEventById(2));
		manageService.saveArtist(artist);
		assertNotNull(artist.getId());
	}
	
	@Test
	public void testDeleteArtist() {
		Artist newArtist = new Artist();
		newArtist.setName("Ion");
		manageService.saveArtist(newArtist);
		Artist artist = fetchService.getArtistById(newArtist.getId());
		manageService.deleteArtist(artist);
		artist = fetchService.getArtistById(newArtist.getId());
		assertNull(artist);
	}
	
	@Test
	public void testDeleteArtistById() {
		Artist newArtist = new Artist();
		newArtist.setName("TestArtistNameX2");
		manageService.saveArtist(newArtist);
		Artist artist = fetchService.getArtistById(newArtist.getId());
		manageService.deleteArtistById(artist.getId());
		artist = fetchService.getArtistById(newArtist.getId());
		assertNull(artist);
	}
	
	@Test
	public void testGetArtists() {
		List<Artist> listOfArtists = fetchService.getAllArtists();
		assertNotNull(listOfArtists);
		assertNotEquals(listOfArtists.size(),0);
	}
	
	@Test
	public void testGetArtistById() {
		Artist artist = fetchService.getArtistById(2);
		assertNotNull(artist);
	}
	
}
