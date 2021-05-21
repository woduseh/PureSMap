package puresmap.app.menu;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.github.dozermapper.core.Mapper;

import lombok.extern.slf4j.Slf4j;
import puresmap.domain.model.publicHospital;
import puresmap.domain.repository.PuresmapRepository;
import puresmap.domain.service.publichospital.PublicHospitalService;


/**
 * geolocation을 이용하여 사용자의 위도 경도값을 알아온 다음 이를 저장하여 새로운 페이지로 넘겨주는 컨트롤러입니다.
 * @author Yeon
 *
 */
@Slf4j
@Controller
public class MenuController {

	@Inject
	PuresmapRepository puresmapRepository;

	@Inject
	PublicHospitalService publicHospitalService;

	@Inject
	Mapper beanMapper;

	/**
	 * forward initial menu view
	 * 
	 * @return menu view
	 */

	@RequestMapping("/")
	public String toMain() {
		return "redirect:menu";
	}

	@RequestMapping(value = "/menu", method = RequestMethod.GET)
	public String FindGeolocation(Model model) {

		log.info("initial view");
		// View를 출력
		return "puresmap/menu";
	}
	
	@RequestMapping(value = "/publichospital/{userY}/{userX}/go", method = RequestMethod.GET)
	public String PublicHospital(Model model,  @PathVariable("userY") String userPositionY, @PathVariable("userX") String userPositionX) {

		log.info("initial view");

		// 데이터베이스로부터 국민안심병원의 리스트를 받아와서 저장함
		List<publicHospital> publicHospitalList = publicHospitalService.findAllPublicHospital();

		// 저장한 리스트를 View에 보내줌
		model.addAttribute("publicHospitalList", publicHospitalList);
		
		System.out.println(userPositionX);
		System.out.println(userPositionY);
		
		// 유저의 접속 위치를 View에 보내줌
		model.addAttribute("userPositionX", userPositionX);
		model.addAttribute("userPositionY", userPositionY);

		// View를 출력
		return "puresmap/publichospital";
	}
	
	@RequestMapping(value = "/center/{Y}/{X}/go", method = RequestMethod.GET)
	public String ScreeningCenter(Model model, @PathVariable("X") String userPositionX, @PathVariable("Y") String userPositionY) {

		log.info("initial view");

		// 데이터베이스로부터 국민안심병원의 리스트를 받아와서 저장함
		List<publicHospital> publicHospitalList = publicHospitalService.findAllScreeningCenter();

		// 저장한 리스트를 View에 보내줌
		model.addAttribute("publicHospitalList", publicHospitalList);
		
		// 유저의 접속 위치를 View에 보내줌
		model.addAttribute("userPositionX", userPositionX);
		model.addAttribute("userPositionY", userPositionY);

		// View를 출력
		return "puresmap/screeningcenter";
	}
}