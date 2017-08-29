package events.model;

import org.hibernate.validator.constraints.Email;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import javax.validation.constraints.NotNull;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

public class User implements UserDetails {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private Integer id;

	@NotNull
	private String name;

	@NotNull
	private String password;

	@NotNull @Email
	private String email;

	private String type;

	private List<Ticket> tickets;
	
	public User() {
		
	}

	public User(String name, String password){
		this.name = name;
		this.password = password;
		this.type = "ADMIN";
	}

	public List<Ticket> getTickets() {
		return this.tickets;
	}

	public void setTickets(List<Ticket> list) {
		tickets = list;
	}

	public Integer getId() {
		return id;
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

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public void addTicket(Ticket ticket) {
		if (tickets == null) {
			tickets = new ArrayList<Ticket>();
		}
		tickets.add(ticket);
	}
	
	public Collection<? extends GrantedAuthority> getAuthorities() {
		GrantedAuthority auth = new GrantedAuthority() {
			
			/**
			 * 
			 */
			private static final long serialVersionUID = 1L;

			public String getAuthority() {
				return type;
			}
		};
		List<GrantedAuthority> authList = new ArrayList<GrantedAuthority>();
		authList.add(auth);
		return authList;
	}

	public String getUsername() {
		return name;
	}

	public boolean isAccountNonExpired() {		
		return true;
	}

	public boolean isAccountNonLocked() {
		return true;
	}

	public boolean isCredentialsNonExpired() {
		return true;
	}

	public boolean isEnabled() {
		return true;
	}

}
