<script>
	// 접속한 유저의 위치를 저장할 객체
	var userPositionX;
	var userPositionY;

	// HTML5의 geolocation으로 사용할 수 있는지 확인합니다 
	if (navigator.geolocation) {
		// GeoLocation을 이용해서 사용자의 접속 위치를 얻어옵니다
		navigator.geolocation.getCurrentPosition(function(position) {
			userPositionY = position.coords.latitude, // 위도
			userPositionX = position.coords.longitude; // 경도
		});
	} else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다
		console.log("GeoLocation을 사용할 수 없습니다.");
	}
	
	function findhospital(){
		  location.href="http://localhost:8080/PureSMap/publichospital/" + userPositionY + "/" + userPositionX + "/go";

		  console.log(userPositionX);
		}
	
	function findcenter(){
		  location.href="http://localhost:8080/PureSMap/center/" + userPositionY + "/" + userPositionX + "/go";
		}
</script>

<div>
	<input type="button" value="Find nearest public relief hospitals"
		id="btn1" class="btn btn-primary btn-sm"
		style="margin: 0 auto; position: relative; left: 30%; padding: 3px 6px" onclick="findhospital()"/>
	<input type="button" value="Find nearest COVID-19 screening center"
		id="btn2" class="btn btn-primary btn-sm"
		style="margin: 0 auto; position: relative; left: 30%; padding: 3px 6px" onclick="findcenter()"/>
</div>