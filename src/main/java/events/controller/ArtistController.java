package events.controller;

import events.model.Artist;
import events.model.Event;
import events.service.FetchService;
import events.service.ManageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.validation.Valid;

import java.util.List;

@Controller
@RequestMapping("/artists")
public class ArtistController {

    @Autowired
    private ManageService manageService;
    
    @Autowired
    private FetchService fetchService;

    @RequestMapping("/createArtist")
    public ModelAndView createArtist(Model uiModel){
	   uiModel.addAttribute("artist", new Artist());
       return new ModelAndView("createArtist", uiModel.asMap());
    }
    
    @RequestMapping("/processArtist")
    @ResponseBody
    public String processArtist(@Valid Artist artist, BindingResult result, Model uiModel){
        if (result.hasErrors()) {
            return "Failed";
        }
       try {
           manageService.saveArtist(artist);
           return "Success";
       } catch  (Exception ex) {
           System.out.println(ex.getMessage());
           return "Failed";
       }
    }
    
	@RequestMapping("/listArtists")
	public ModelAndView deleteArtist(Model uiModel) {
		try {
			
			 List<Artist> artists = fetchService.getAllArtists();
			 uiModel.addAttribute("artists", artists);
			 
			 
			return new ModelAndView("listArtists", uiModel.asMap());
		} catch (Exception ex) {
			System.out.println(ex.getMessage());
			return new ModelAndView("listArtists", uiModel.asMap());
		}
	}
    
	
	@RequestMapping("/removeArtist")
	@ResponseBody
	public String removeArtist(@RequestParam(value="idValue",required=true) Integer id,Model uiModel){
		try{
			manageService.deleteArtistById(id);
			return "success";
		} catch (Exception ex) {
			 System.out.println(ex.getMessage());
			   return "failed";
		}
	}

	@RequestMapping("/updateArtist")
	public ModelAndView updateArtist(@RequestParam(value = "idValue", required = true) Integer id, Model uiModel) {
		
		try {
			 Artist artist = fetchService.getArtistById(id);
			 uiModel.addAttribute("artist", artist);
			 uiModel.addAttribute("image", artist.getImageBase64());
			 
			 return new ModelAndView("updateArtist");
		} catch (Exception ex) {
			System.out.println(ex.getMessage());
			return new ModelAndView("updateArtist", uiModel.asMap());
		}
	}
	
	 @RequestMapping("/processUpdateArtist")
	 @ResponseBody
	 public String processUpdateArtist(@Valid Artist artist, BindingResult result, Model uiModel){
		 if (result.hasErrors()) {
			return "Failed";
		 }
		 try {
			 manageService.saveArtist(artist);
			 return  "Success";
		 } catch  (Exception ex) {
			 System.out.println(ex.getMessage());
			 return "Failed";
		 }
	 }
   
}
