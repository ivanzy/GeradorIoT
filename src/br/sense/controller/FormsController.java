package br.sense.controller;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.web.servlet.DispatcherServlet;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.servlet.ModelAndView;
import br.sense.code.MqttPublish;

@Controller
public class FormsController {
	@RequestMapping("/forms")
	public String home() {
		System.out.println("forms");
		return "forms";
	}


}
