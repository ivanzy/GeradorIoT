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
import br.sense.model.*;

@Controller
public class IndexController {
	@RequestMapping("/")
	public String home() {
		System.out.println("/");
		return "index";
	}
	@RequestMapping("/index")
	public String index() {
		System.out.println("/index");
		return "index";
	}
	@RequestMapping("teste")
	public String teste(){
		System.out.println("teste!");
		TDSensor air = new TDSensor("air", "topic", 5000);
		TDSensor waste = new TDSensor("waste", "topic", 5000);
		TDSensor traffic = new TDSensor("traffic", "topic", 5000);
		TDSensor noise = new TDSensor("noise", "topic", 5000);
		TDSensor structural = new TDSensor("structural", "topic", 5000);
		EDSensor light = new EDSensor("lightController", "topic", 10,2000);
		EDSensor[] edsensor= new EDSensor[1];
		TDSensor[] tdsensor = new TDSensor[5];
		tdsensor[0]=air;
		tdsensor[1]=waste;
		tdsensor[2]=traffic;
		tdsensor[3]=structural;
		tdsensor[4]=noise;
		edsensor[0]=light;
		MqttPublish mqttPublish = new MqttPublish(tdsensor,edsensor);
		mqttPublish.publish();
		return "monitoring";

	}

}
