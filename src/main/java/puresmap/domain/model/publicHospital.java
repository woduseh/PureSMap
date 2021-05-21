package puresmap.domain.model;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
// 국민안심병원
public class publicHospital {
	public int seq;
	public String date;
	public String city;
	public String town;
	public String name;
	public String address;
	public String type;
	public String phoneNumber;
	public String lat;
	public String lon;
}
