
<img
	src="https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fk.kakaocdn.net%2Fdn%2FbbSIwY%2FbtqED1fGrxa%2F779ZIQ2n3vcxAk59KMxAKk%2Fimg.png"
	width=300 height=120 alt="W3Schools.com" />
<p>Software Engeering Class.</p>
<form>
	<input type='button' value='My Location' onclick="mylocation()" />

</form>

<div id="map" style="width: 100%; height: 500px;"></div>

<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=de744b3abffa6304986dc94f9619a321&libraries=services"></script>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	mapOption = { 
	    center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
	    level: 3 // 지도의 확대 레벨
	};

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

//아래와 같이 옵션을 입력하지 않아도 된다
var zoomControl = new kakao.maps.ZoomControl();

// 지도 오른쪽에 줌 컨트롤이 표시되도록 지도에 컨트롤을 추가한다.
map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

// 주소-좌표 변환 객체를 생성합니다
var geocoder = new kakao.maps.services.Geocoder();

// 배열의 크기를 병원의 전체 숫자로 받음
var size = "${publicHospitalList.size()}";

// 접속한 유저의 위치를 저장할 객체
var userPosition;

// 위치간의 직선을 저장할 linepath 객체
var linePath = new Array();

// 위치간의 거리를 저장할 객체
var userHospitalDistence = [];

var userPositionY = "${userPositionY}";
var userPositionX = "${userPositionX}";

// 거리 비교용 객체
var tempDistence = [];

// 마커 배열
var publicHospitalName = [];
var publicHospitalLat = [];
var publicHospitalLon = [];

<c:forEach var="hospital" items="${publicHospitalList}">
	publicHospitalName.push("${hospital.getName()}");
	publicHospitalLat.push("${hospital.getLat()}");
	publicHospitalLon.push("${hospital.getLon()}");
</c:forEach>

document.body.style.background="#5c5c5c";

makeResult(size);

//모든 것을 실행하는 함수
function makeResult(size){
	// 현재 유저 위치로 마커를 만들고 출력
	makeUserMarker();
	// 현재 유저 위치와 전달받은 병원 위치간의 거리를 측정 후 배열에 저장
	findDistence (size);
	// 배열에 저장된 값을 임시배열에 옮겨서 소팅
	tempDistence = bubbleSort(userHospitalDistence);
	// 임시배열과 배열값을 비교하여 가장 가까운 거리에 있는 병원 마커를 출력
	displayHospital(size);
}


//사용자의 위치와 병원간의 위치를 잇는 폴리라인을 그려서 사용자의 위치와 병원과의 거리를 측정하고 반환하는 함수
function findDistence (size) {
    for (var i=0; i<size; i++) {
    	_findDistence(i);
    }
}

// findDistence의 헬퍼 함수입니다.
function _findDistence (i) {
	polyline = new kakao.maps.Polyline({
	    map: map,
	    path: [
	        new kakao.maps.LatLng(publicHospitalLat[i],  publicHospitalLon[i]),
	        new kakao.maps.LatLng(userPositionY, userPositionX)
	    ],
	    strokeOpacity: 0
	});
    var length = Math.round(polyline.getLength());
	userHospitalDistence.push(length);
}

//버블소트
function bubbleSort(arr) {
	let result = [...arr]; // 원본 데이터 복사
  
    for (let i = 0; i < result.length - 1; i++) {
        for (let j = 0; j < result.length - i; j++) {
            if (result[j] > result[j + 1]) {
                let temp = result[j];
                result[j] = result[j+1];
                result[j+1] = temp;
            }
        }
    }
    
    return result;
}

//컨트롤러로부터 받아온 사용자의 위치를 기반으로 현재 위치 마커를 생성
function makeUserMarker() {
	userPosition = new kakao.maps.LatLng(userPositionY, userPositionX), // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
	    message = '<div style="padding:5px;">현재 위치</div>'; // 인포윈도우에 표시될 내용입니다
	// 마커와 인포윈도우를 표시합니다
	displayMarker(userPosition, message);
}

//가장 가까운 거리에 있는 병원을 표시하는 함수
function displayHospital(size) {
	for (var i = 0; i<size; i++) {
		if (tempDistence[0] == userHospitalDistence[i]) {
			_displayHospital(i);
			var centerPosition =  new kakao.maps.LatLng(userPositionY, userPositionX); 
			map.setCenter(centerPosition);      
		}
	}
}

//헬퍼함수
function _displayHospital(index) {
	
	var markerPosition  = new kakao.maps.LatLng(publicHospitalLat[index], publicHospitalLon[index]); 
	
	// 마커를 생성합니다
	var marker = new kakao.maps.Marker({
		map: map,
	    position: markerPosition
	});
	
    var infowindow = new kakao.maps.InfoWindow({
        content: (publicHospitalName[index])
    });
    infowindow.open(map, marker);
}

// 지도에 사용자 마커와 인포윈도우를 표시하는 함수
function displayMarker(locPosition, message) {

    // 마커를 생성합니다
    var marker = new kakao.maps.Marker({  
        map: map, 
        position: locPosition
    }); 
    
    var iwContent = message, // 인포윈도우에 표시할 내용
        iwRemoveable = true;

    // 인포윈도우를 생성합니다
    var infowindow = new kakao.maps.InfoWindow({
        content : iwContent,
        removable : iwRemoveable
    });
    
    // 인포윈도우를 마커위에 표시합니다 
    infowindow.open(map, marker); 
}    

// 지도의 중심을 다시 내 위치로 돌리는 함수
function mylocation(){
	var centerPosition =  new kakao.maps.LatLng(userPositionY, userPositionX); 
	map.setCenter(centerPosition);    
}
</script>