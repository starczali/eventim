package events.controller;

import events.model.*;
import events.service.FetchService;
import events.service.ManageService;
import events.utils.MailUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.validation.Valid;
import java.io.UnsupportedEncodingException;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

@Controller
@RequestMapping("/client")
public class ClientController {

    @Autowired
    FetchService fetchService;

    @Autowired
    ManageService manageService;

    //----HOME----
    @RequestMapping("/home")
    public ModelAndView goToHome(Model uiModel){
        uiModel.addAttribute("events",fetchService.getLimitedEvents(6));
        return new ModelAndView("home");
    }

    // -----ARTISTS-----
    //
    @RequestMapping("/viewArtists")
    public ModelAndView viewArtist(Model uiModel) {
        try {
            List<Artist> artists = fetchService.getAllArtists();
            uiModel.addAttribute("artists", artists);
            return new ModelAndView("viewArtists", uiModel.asMap());
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            return new ModelAndView("viewArtists", uiModel.asMap());
        }
    }

    @RequestMapping("/viewArtistsByEvent/{id}")
    public ModelAndView viewArtist(@PathVariable("id") Integer id, Model uiModel) {
        try {
            List<Artist> artists = fetchService.getArtistByEvent(id);
            uiModel.addAttribute("artists", artists);
            return new ModelAndView("viewArtists", uiModel.asMap());
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            return new ModelAndView("viewArtists", uiModel.asMap());
        }
    }

    // ----CATEGORIES----
    //
    @RequestMapping("/viewCategories")
    public ModelAndView viewCategories(Model uiModel) {
        try {
            List<Category> categories = fetchService.getAllCategories();
            uiModel.addAttribute("categories" , categories);
            return new ModelAndView("viewCategories");
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            return new ModelAndView("viewCategories", uiModel.asMap());
        }
    }

    // ----EVENTS----
    //
    @RequestMapping("/viewEvents")
    public ModelAndView viewEvents( Model uiModel) {
        try {
            uiModel.addAttribute("events", fetchService.getNextEvents());
            return new ModelAndView("viewEvents");
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return new ModelAndView("viewEvents", uiModel.asMap());
        }
    }

    @RequestMapping("/viewLimitedEvents/{limit}")
    public ModelAndView viewEvents( @PathVariable("limit") Integer limit, Model uiModel) {
        try {
            uiModel.addAttribute("events", fetchService.getLimitedEvents(limit));
            return new ModelAndView("viewEvents");
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return new ModelAndView("viewEvents", uiModel.asMap());
        }
    }

    @RequestMapping("/viewLocations")
    public ModelAndView listLocations( Model uiModel) {
        try {
            List<Event> events = fetchService.getNextEvents();
            List<String> locations = new ArrayList<>();
            for(Event e : events){
                if(!locations.contains(e.getLocation()))
                    locations.add(e.getLocation());
            }
            uiModel.addAttribute("locations",locations);
            return new ModelAndView("viewLocations");
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return new ModelAndView("viewLocations", uiModel.asMap());
        }
    }

    @RequestMapping("/getEventsByLocation/{location}")
    public ModelAndView listEventsByLocation(@PathVariable("location") String location,Model uiModel) {
        try {
            //List<Event> events = fetchService.getAllEvents().stream().filter(e -> e.getLocation().equals(location)).collect(Collectors.toList());
            List<Event> events = fetchService.getEventsByLocation(location);
            uiModel.addAttribute("events",events);
            return new ModelAndView("viewEvents");
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return new ModelAndView("viewEvents", uiModel.asMap());
        }
    }

    @RequestMapping("/getEventsByArtist/{id}")
    public ModelAndView listEventsByArtist(@PathVariable("id") Integer id,Model uiModel) {
        try {
            List<Event> events = fetchService.getEventsByArtist(id);
            uiModel.addAttribute("events",events);
            return new ModelAndView("viewEvents");
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return new ModelAndView("viewEvents", uiModel.asMap());
        }
    }

    @RequestMapping("/getEventsByCategory/{id}")
    public ModelAndView listEventsByCategory(@PathVariable("id") Integer id, Model uiModel) {
        try {
            List<Event> events = fetchService.getEventByCategory(id);
            uiModel.addAttribute("events",events);
            return new ModelAndView("viewEvents");
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return new ModelAndView("viewEvents", uiModel.asMap());
        }
    }


    // ----USER----
    //
    @RequestMapping("/createUser")
    public ModelAndView createUser(@Valid TemporaryUser temporaryUser, BindingResult result, Model uiModel){

        //check compatibility errors
        if (result.hasErrors()) {
            return new ModelAndView("createUser", uiModel.asMap());
        }
        try {
            BCryptPasswordEncoder bCryptPasswordEncoder = new BCryptPasswordEncoder();
            String encodedPassword = bCryptPasswordEncoder.encode(temporaryUser.getPassword());
            //temporary user default values
            temporaryUser.setPassword(encodedPassword);
            temporaryUser.setType("NORMAL");
            temporaryUser.setRegistered(Boolean.FALSE);

            //Check for duplicates
            List<User> users = fetchService.getAllUsers();
            User u = null;
            for (int i = 0; i < users.size(); i++) {
                u = users.get(i);
                if (u.getName().equals(temporaryUser.getName())) {
                    uiModel.addAttribute("message", "User with that Name already exists!");
                    System.out.println("Duplicate user tried to register");
                    return new ModelAndView("createUser", uiModel.asMap());
                }
            }

            //save user until validation
            manageService.saveTemporaryUser(temporaryUser);

            //Send mail
            String subject = "Eventim 2.0 Acount validation !\n";
            String message = "Hello " + temporaryUser.getName() + "!\n Please click on the link below to activate your acount:\n";
            message += "http://localhost:8080/Eventim2.0/client/validate?token=" + encrypt(temporaryUser.getId());
            message += "\n\n Have a Great day,\nEventim 2.0 Team.";
            MailUtil.sendMail(subject, message, temporaryUser.getEmail());

            return new ModelAndView("confirmMail");

        } catch  (Exception ex) {
            //send back to createUser link with error
            return new ModelAndView("createUser", uiModel.asMap());
        }
    }

    @RequestMapping("/updateUser")
    public ModelAndView updateUser(@Valid User user, BindingResult result, Model uiModel){
        User oldUser = fetchService.getUserById(user.getId());
        if (result.hasErrors()) {
            uiModel.addAttribute("user",oldUser);
            return new ModelAndView("updateUser", uiModel.asMap());
        }
        try {
            BCryptPasswordEncoder bCryptPasswordEncoder;
            if(oldUser!=null)
                if(user.getPassword().equals(""))
                    user.setPassword(oldUser.getPassword());
                else{
                    bCryptPasswordEncoder= new BCryptPasswordEncoder();
                    String encodedPassword = bCryptPasswordEncoder.encode(user.getPassword());
                    user.setPassword(encodedPassword);}
            manageService.saveUser(user);
            uiModel.addAttribute("user",user);
            uiModel.addAttribute("message", "Changes saved");
            return new ModelAndView("updateUser");
        } catch  (Exception ex) {
            uiModel.addAttribute("user",oldUser);
            System.out.println(ex.getMessage());
            return new ModelAndView("updateUser", uiModel.asMap());
        }
    }

    @RequestMapping("/validate")
    public ModelAndView validateUser(@RequestParam String token, Model uiModel){
        try{
            TemporaryUser temporaryUsers = fetchService.getTemporaryUserById(Integer.parseInt(decrypt(token)));
            User user = temporaryUsers.toUser();
            manageService.saveUser(user);
            temporaryUsers.setRegistered(Boolean.TRUE);
            manageService.saveTemporaryUser(temporaryUsers);
            return new ModelAndView("confirmUser",uiModel.asMap());
        }catch (Exception ex){
            System.out.println(ex.getMessage());
            return new ModelAndView("error", uiModel.asMap());
        }
    }

    private String encrypt(Integer number) throws UnsupportedEncodingException {
        return Base64.getUrlEncoder().encodeToString(number.toString().getBytes("utf-8"));
    }

    private String decrypt(String token){
        return new String(Base64.getUrlDecoder().decode(token), StandardCharsets.UTF_8);
    }
}
