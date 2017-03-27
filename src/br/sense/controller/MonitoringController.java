package br.sense.controller;

import java.util.Date;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.web.servlet.DispatcherServlet;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.servlet.ModelAndView;
import br.sense.code.MqttPublish;
import br.sense.code.Param;
import br.sense.code.TimeControl;
import br.sense.model.*;

@Controller
public class MonitoringController {

	@RequestMapping("/monitoring")
	public String home(Model model) {
		System.out.println("monitoring");


		model.addAttribute("message", "");
		return "monitoring";
	}

	@RequestMapping("/abort")
	public String abort(Model model) {
		System.out.println("abort!");
		MqttPublish.abort();
		MessageArray.clean();
		return "monitoring";
	}

	@RequestMapping(value = "/ajaxtest", method = RequestMethod.GET)
	public @ResponseBody String getTime() {
		String result = "";
;
		if (TimeControl.isExperimentStarted()) {
			long time = (TimeControl.getTime() / 1000);
			result += "<div class=\"row\"> <div class=\"col-lg-2\"></div><form action=\"abort\" method=\"post\" class=\"form-signin\">";
			result += "<div class=\"col-lg-8 text-center button-show\"><button type=\"submit\" class=\"btn btn-lg btn-danger btn-block\" value=\"teste\">STOP EXPERIMENT</button><br></div></form></div>";
			result += " <h2>Experiment's name: " + Param.name_experiment + "</h2>";
			result += " <h2>Time of Experiment: " + time + "s it ends in "
					+ ((TimeControl.getTimeOfExperiment() / 1000) - time) + "s </h2><br>";
		}
		result += MessageArray.showMessage();
		// System.out.println(">>>>>>RESULT: "+result);
		// //System.out.println("Debug Message from CrunchifySpringAjaxJQuery
		// Controller.." + new Date().toString());
		return result;
	}

	@RequestMapping(value = "/chart", method = RequestMethod.GET)
	public @ResponseBody String getChartData() {
		return MessageArray.callTemporalLine();

	}

}