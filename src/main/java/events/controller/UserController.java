package events.controller;

import events.authentication.Authenticate;
import events.model.TemporaryUser;
import events.model.User;
import events.service.FetchService;
import events.service.ManageService;
import events.utils.Encrypter;
import events.utils.MailUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.validation.Valid;
import java.io.UnsupportedEncodingException;
import java.nio.charset.StandardCharsets;
import java.util.Base64;
import java.util.List;

@Controller
@RequestMapping("/users")
public class UserController {

    @Autowired
    private FetchService fetchService;

    @Autowired
    private ManageService manageService;



    @RequestMapping(value = "/deleteUser")
    public ModelAndView deleteUser(@RequestParam(value = "id", required = false) Integer id, Model uiModel){
        List<User> users;
        try {
            manageService.deleteUserById(id);
            users = fetchService.getAllUsers();
            uiModel.addAttribute("users",users);
            return new ModelAndView("deleteUser",uiModel.asMap());
        } catch  (Exception ex) {
            System.out.println(ex.getMessage());
            users = fetchService.getAllUsers();
            uiModel.addAttribute("message", "Something unexpected occurred");
            uiModel.addAttribute("users",users);
            return new ModelAndView("deleteUser", uiModel.asMap());
        }
    }

    @RequestMapping("/updateUsers")
    public ModelAndView updateUsers(@Valid User user, BindingResult result, Model uiModel){
        List<User> users;
        if (result.hasErrors()) {
            users = fetchService.getAllUsers();
            uiModel.addAttribute("users",users);
            uiModel.addAttribute("message", "Something unexpected occurred");
            return new ModelAndView("updateUsers", uiModel.asMap());
        }
        try {
            BCryptPasswordEncoder bCryptPasswordEncoder = new BCryptPasswordEncoder();
            String encodedPassword = bCryptPasswordEncoder.encode(user.getPassword());
            user.setPassword(encodedPassword);
            manageService.saveUser(user);
            users = fetchService.getAllUsers();
            uiModel.addAttribute("users",users);
            uiModel.addAttribute("message", "User updated !");
            return new ModelAndView("updateUsers");
        } catch  (Exception ex) {
            users = fetchService.getAllUsers();
            uiModel.addAttribute("users",users);
            uiModel.addAttribute("message", "Users:");
            return new ModelAndView("updateUsers", uiModel.asMap());
        }
    }

}
