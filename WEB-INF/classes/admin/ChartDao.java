package admin;

import java.util.List;

public class ChartDao {

	public ChartDto getGradeChart() {
		
		// memberlist가져오기
		IMemberDao_AD dao = MemberDao_AD.getInstance();
		List<MemberDto_AD> memlist = dao.getMemberList();
		
		int bronze = 0;
		int silver = 0;
		int gold = 0;
		int platinum = 0;
		int diamond = 0;
		
		ChartDto Cdto = null;
		
		for (int i = 0; i < memlist.size(); i++) {
			MemberDto_AD dto = memlist.get(i);
			
			if(dto.getGrade() > 0 && dto.getGrade() <= 10){
				bronze++;
			}else if(dto.getGrade() > 10 && dto.getGrade() <= 20){
				silver++;
			}else if(dto.getGrade() > 20 && dto.getGrade() <= 30){
				gold++;
			}else if(dto.getGrade() > 30 && dto.getGrade() <= 40){
				platinum++;
			}else if(dto.getGrade() > 40){
				diamond++;
			}			
		}
		
		Cdto = new ChartDto(bronze, silver, gold, platinum, diamond);
		
		return Cdto;
	}
	
}
