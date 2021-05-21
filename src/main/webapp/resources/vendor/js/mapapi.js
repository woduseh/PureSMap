<div id="map" style="width: 100%; height: 800px;"></div>

<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=de744b3abffa6304986dc94f9619a321&libraries=services"></script>
<script>


// 사용자의 위치와 병원간의 위치를 잇는 폴리라인을 그려서 사용자의 위치와 병원과의 거리를 측정하고 반환하는 함수
function makePolyline (index) {
    var distence;
    navigator.geolocation.getCurrentPosition(function(position) {
        
        var lat = position.coords.latitude, // 위도
            lon = position.coords.longitude; // 경도
            
    	polyline = new kakao.maps.Polyline({
    	    map: map,
    	    path: [
    	        new kakao.maps.LatLng(publicHospitalLat[index],  publicHospitalLon[index]),
    	        new kakao.maps.LatLng(lat, lon)
    	    ],
    	    strokeOpacity: 0
    	});
            var length = Math.round(polyline.getLength());
    	userHospitalDistence.push(length);
      });
}

//가장 가까운 거리에 있는 병원을 표시
for (var i = 0; i<size; i++) {
	if (tempDistence[0] == userHospitalDistence[i]) {
		displayHospital(i);
	}
}


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

//지도에 병원 마커를 추가하는 함수입니다
function displayHospital(index) {
	
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

// 지도에 사용자 마커와 인포윈도우를 표시하는 함수입니다
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
    
    // 지도 중심좌표를 접속위치로 변경합니다
    map.setCenter(locPosition);      
}
</script>