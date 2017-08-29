package events.model;

import java.util.ArrayList;
import java.util.List;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Length;

public class Artist {
	private Integer id;
	
	@NotNull
	@Length(min=1)
	private String name;
	
	private String imageBase64;
	private byte[] image;
	
	private List<Event> events;

	public Artist() {

	}

	public Artist(Integer id, String name, List<Event> events,byte[] image) {
		this.id = id;
		this.name = name;
		this.events = events;
		this.image = image;
	}

	public List<Event> getEvents() {
		return events;
	}

	public void setEvents(List<Event> events) {
		this.events = events;
	}

	public Integer getId() {
		return id;
	}
	
	public byte[] getImage() {
		return image;
	}
	
	public void setImage(byte[] image) {
		if (image != null) {
			this.image = image;
			byte[] imageHelp = new byte[image.length];
			for (int i = 0; i < image.length; i++) {
				imageHelp[i] = image[i];
			}
			imageBase64 = new String(imageHelp);
		}
	}

	public String getImageBase64() {
		return imageBase64;
	}

	public void setImageBase64(String imageBase64) {
		this.imageBase64 = imageBase64;
		byte[] bytes = imageBase64.getBytes();
		byte[] theBytes = new byte[bytes.length];
		for (int i = 0; i< bytes.length; i++){
			theBytes[i] =bytes[i];
		}
		this.image = theBytes;
	}
	
	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void addEvent(Event event) {
		if (events == null) {
			events = new ArrayList<Event>();
		}
		events.add(event);
	}

}
