package puresmap.domain.service.publichospital;

import java.util.List;

import puresmap.domain.model.publicHospital;

public interface PublicHospitalService {
	List<publicHospital> findAllPublicHospital();
	
	List<publicHospital> findAllScreeningCenter();
}
