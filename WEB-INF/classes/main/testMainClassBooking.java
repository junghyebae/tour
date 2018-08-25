package main;

import java.util.List;
import java.util.IllegalFormatConversionException;

import admin.IPackageDao;
import admin.PackageDao;
import admin.PackageDto;

public class testMainClassBooking {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
			
		IBookingDao dao = BookingDao.getInstance();
		
		//List<BookingDto> dto = dao.airList("20170822", "20170901");		
		//System.out.println(dto.toString());
		
		//BookingDto dto = dao.reserveAnumList("서울(인천/김포)", "세부", "201709241120", "201710031120");
		//System.out.println("dto: " + dto.toString());
		
		//dao.mainBooking("admin", 12, "test", "201708240101", "201708240101", 1, 2, 3, "일등석", 50000);
				
		/*
			// 인원에 따른 분류 변수 
				int adt_num = 1;
				int chi_num = 1;
				int inf_num = 1;
				
				// 인원의 나이에 따른 할인 적용 부분 (adt = 성인은 할인X)
				int adt_price = (1300000 + 500000) * adt_num;
				
				int chi_price = (1300000 + 500000) * chi_num;
					// chi_price = Integer.parseInt(String.valueOf(chi_price * 0.8)); / 이 방법은 NumberFormatException 발생
					chi_price = (int)(chi_price * 0.8);
					
				int inf_price = (1300000 + 500000) * inf_num;
					//inf_price = Integer.parseInt(String.valueOf(inf_price * 0.5)); / 이 방법은 NumberFormatException 발생
					inf_price = (int)(inf_price * 0.5);
				
				// 총가격 변수
				int total_price = adt_price + chi_price + inf_price;
				
				// login한 user의 등급을 가져오는 부분 
				int user_grade = 6;
				
				// % 계산을 위한 변수
				double temp_calc = 0;
				
				// 등급에 따른 total_price 조정 부분
				if(user_grade > 5 && user_grade < 10){
					temp_calc = total_price * 0.1;
					
					//total_price = total_price - Integer.parseInt(String.valueOf(temp_calc)); / 이 방법은 NumberFormatException 발생
					total_price = total_price - (int)(temp_calc);
					
				} else if(user_grade > 9999){
					temp_calc = total_price * 0.5;
					
					total_price = total_price - (int)(temp_calc);
				}
				
				System.out.println("total_price: " + total_price);
		 */
		
		/*String air_select = "서울(인천/김포)->싱가포르(11:00/11:00)";
		
		String select_location = "";
		int idx = air_select.indexOf(">");
		
		String temp_select = air_select.substring(idx+1);
		// ex) temp_select: 방콕(10:00/10:00)
		
		// 시간을 구하기 위해서 temp_select를 복제
		String temp_select2 = temp_select;
		
		idx = temp_select.indexOf("(");
		select_location = temp_select.substring(0, idx);
		// ex) select_location: 방콕
		
		// 출발지 구하기
		int sLoIdx = air_select.indexOf("-");
		air_select = air_select.substring(0, sLoIdx);
		
		System.out.println("s_location: " + air_select);
		System.out.println("e_location: " + select_location);*/
		
		/*
		BookingDto dto = dao.getAirPrice("20170924", "20171003", "서울(인천/김포)", "싱가포르");
		System.out.println("dto: " + dto.toString());
		*/
		
		/*
		IPackageDao pdao = PackageDao.getInstance();
		PackageDto pdto = pdao.reservePackList("싱가포르[9일] 패키지");
		
		System.out.println("pdto: " + pdto.toString());
		*/
		
		/*int price = 111222333;
		
		String price_com = String.valueOf(price);
		String temp_price_com = price_com;
			
			price_com = price_com.substring(0, 3);
			System.out.println(price_com);
			String str = String.format("$%,d", price_com);
			System.out.println(str);
		 */
		
		/*
		List<BookingDto> list = dao.getAirList();
		
		for (int i = 0; i < list.size(); i++) {
			System.out.println("list["+i+"]: " + list.get(i).toString());
		}		
		*/
		String g = "201708091600";
		String q = "2017-08-09T16:00:00";		
		
		// 형식 맞추는 부분
		String t = g.substring(0, 4) + "-" + g.substring(4,6) + "-" + g.substring(6,8) + "T" + g.substring(8,10) + ":" + g.substring(10,12) + ":00";

		
		System.out.println("t: " + t);
		System.out.println("q: " + q);
	}

}
