package puresmap.domain.repository;

import java.util.List;

import puresmap.domain.model.publicHospital;

public interface PuresmapRepository {
	
	// 모든 국민안심병원을 불러와서 publicHospital의 리스트의 형태로 저장
	List<publicHospital> selectEveryHospital();
	
	List<publicHospital> selectEveryCenter();

}
