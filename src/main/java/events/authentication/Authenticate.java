package events.authentication;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Component;

import events.model.User;
import events.service.FetchService;

@Component
public class Authenticate implements AuthenticationProvider {

	@Autowired
	private FetchService fetchService;

	public static final String SUPER_ADMIN_USER = "admin";
	public static final String SUPER_ADMIN_PASSWORD = "admin1234";

	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		String username = authentication.getName();
		String password = (String) authentication.getCredentials();

		if (username.equals(SUPER_ADMIN_USER) && password.equals(SUPER_ADMIN_PASSWORD)) {
			User user = new User(SUPER_ADMIN_USER, SUPER_ADMIN_PASSWORD);
			return new UsernamePasswordAuthenticationToken(user, null, user.getAuthorities());
		} else {
			User foundUser = fetchService.findUserAtLogin(username);
			if (foundUser != null) {
				String dbPassword = foundUser.getPassword();
				BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
				
				if (passwordEncoder.matches(password, dbPassword)){
					return new UsernamePasswordAuthenticationToken(foundUser, null, foundUser.getAuthorities());
				} else {
					throw new BadCredentialsException("Wrong username or password");
				}
			} else {
				throw new BadCredentialsException("Wrong username or password");
			}
		}
	}

	public boolean supports(Class<?> arg0) {
		return true;
	}

}
