package events.controller;

import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import events.model.Ticket;
import events.model.User;
import events.service.FetchService;
import events.service.ManageService;

/**
 * tickets/{id}/things
 * id is eventId from the previous page
 */

@Controller
@RequestMapping("/tickets") 
public class TicketController {

	@Autowired
	private ManageService manageService;

	@Autowired
	private FetchService fetchService;

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView getTickets(Model uiModel) {
		User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		uiModel.addAttribute("tickets", fetchService.getUserTickets(user.getId()));	//userId from session
		return new ModelAndView("listTicket", uiModel.asMap());
	}
	
	@RequestMapping(value = "", method = RequestMethod.GET)
	public ModelAndView getTickets2(Model uiModel) {
		User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		uiModel.addAttribute("tickets", fetchService.getUserTickets(user.getId()));	//userId from session
		return new ModelAndView("listTicket", uiModel.asMap());
	}
	
	@RequestMapping(value = "/{eventId}/createTicket", method = RequestMethod.GET)
	public ModelAndView getBuyTicketSite( @PathVariable("eventId") Integer eventId, Model uiModel) {
		Ticket ticket = new Ticket();
		User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		ticket.setUser(fetchService.getUserById(user.getId()));	
		ticket.setEvent(fetchService.getEventById(eventId));
		uiModel.addAttribute("ticket", ticket);
		return new ModelAndView("createTicket", uiModel.asMap());
	}
	
	@RequestMapping(value = "/createTicketWithEvent", method = RequestMethod.GET)
	public ModelAndView getBuyTicketSite( Model uiModel ) {
		Ticket ticket = new Ticket();
		User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		ticket.setUser(fetchService.getUserById(user.getId()));	
		uiModel.addAttribute("event", fetchService.getAllEvents());
		uiModel.addAttribute("ticket", ticket);
		return new ModelAndView("createTicketWithEvent", uiModel.asMap());
	}

	@RequestMapping(value="/{eventId}/createTicket", method = RequestMethod.POST)
	public ModelAndView createTicket(@Valid Ticket ticket, BindingResult result, Model uiModel,
									 @RequestParam(value="quantity", required=true) Integer quantity,
									 @PathVariable("eventId") Integer eventId) {
		if (result.hasErrors()) {
			System.out.println(ticket);
			uiModel.addAttribute("ticket", ticket);
			uiModel.addAttribute("errorMessage", "Not valid inputs!");
			return new ModelAndView("createTicket", uiModel.asMap());
		}
		try {
			if(quantity > 0) {
				for (int i = 0; i < quantity; i++) {
					Ticket ticketHelp = new Ticket();
					ticketHelp.setBarcode(fetchService.getNextBarcode());
					ticketHelp.setEvent(ticket.getEvent());
					ticketHelp.setUser(ticket.getUser());
					manageService.saveTicket(ticketHelp);
				}
			}
			uiModel.addAttribute("response", "OK");
			return getBuyTicketSite(eventId, uiModel);
			
		} catch (Exception ex) {
			System.out.println(ex.getMessage());
			uiModel.addAttribute("response", "NO");
			return getBuyTicketSite(eventId, uiModel);
		}
	}

	@RequestMapping(value = "/{eventId}/deleteTicket", method = RequestMethod.POST)
	@ResponseBody
	public String deleteTicket(@RequestParam("id") Integer id, HttpServletResponse response) {
		try {
			manageService.deleteTicketById(id);
			response.setStatus(200);
			return "Succes";
		} catch (Exception ex) {
			System.out.println(ex.getMessage());
			response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
			return "Fail";
		}
	}
	
	@RequestMapping(value = "/{eventId}/getPrice", method = RequestMethod.GET)
	@ResponseBody
	public String getPrice(@RequestParam("id") Integer id, HttpServletResponse response) {
		try {
			response.setStatus(200);
			return fetchService.getEventById(id).getPrice().toString();
		} catch (Exception ex) {
			System.out.println(ex.getMessage());
			response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
			return fetchService.getEventById(id).getPrice().toString();
		}
	}
}
