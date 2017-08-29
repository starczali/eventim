package events.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import events.model.User;
import events.service.FetchService;
import events.service.ManageService;
import events.utils.MailUtil;

@Controller
public class LoginController {
	
	public static final String MAIL_SUBJECT = "Forgot password";

	private String newPassword;

	@Autowired
	private FetchService fetchService;

	@Autowired
	private ManageService manageService;
	
	@RequestMapping("/logout")
	public String doLogOut(HttpServletRequest request, HttpServletResponse response) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		  if (auth != null){    
			  new SecurityContextLogoutHandler().logout(request, response, auth);
			  return "login";
		  }
		  return "home";
	}
	
	@RequestMapping("/loginUri")
	public String goToLogin(){
		return "login";
	}

	@RequestMapping("/changePassword")
	public ModelAndView changePassword(){
		return new ModelAndView("changePassword");
	}
	
	@RequestMapping("/forgotPassword")
	@ResponseBody
	public String forgotPassword(String email) {
		try {
			newPassword = MailUtil.generatePassword();
			if (updatePassword(newPassword, email) == true) {
				MailUtil.sendMail(MAIL_SUBJECT, newPassword, email);
				return "Success";
			}
			else{
				return "Mail not registered. Register for new Account.";
			}
		} catch (Exception ex) {
			System.out.println(ex.getMessage());
			return "Exception error ";

		}
	}

	public boolean updatePassword(String newPassword, String email) {
		boolean found = false;
		BCryptPasswordEncoder bCryptPasswordEncoder = new BCryptPasswordEncoder();
        String encodedPassword = bCryptPasswordEncoder.encode(newPassword);
		List<User> users = fetchService.getAllUsers();
		for (User user : users) {
			if (user.getEmail().equals(email)) {
				user.setPassword(encodedPassword);
				manageService.saveUser(user);
				found = true;
			}
		}
		return found;
	}

}
