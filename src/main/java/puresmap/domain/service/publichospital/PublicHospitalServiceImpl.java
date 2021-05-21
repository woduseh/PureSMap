package puresmap.domain.service.publichospital;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import puresmap.domain.model.publicHospital;
import puresmap.domain.repository.PuresmapRepository;

@Transactional
@Service
public class PublicHospitalServiceImpl implements PublicHospitalService  {
	@Inject
	PuresmapRepository puresmapRepository;

	@Override
	public List<publicHospital> findAllPublicHospital() {
		List<publicHospital> hospital = puresmapRepository.selectEveryHospital();
		return hospital;
	}

	@Override
	public List<publicHospital> findAllScreeningCenter() {
		List<publicHospital> hospital = puresmapRepository.selectEveryCenter();
		return hospital;
	}
	
}
