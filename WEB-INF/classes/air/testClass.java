package air;

public class testClass {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		IAirPlainDAO dao = AirPlainDAO.getInstance();
		
		AirPlainDTO dto = dao.getAdto(3);
		
		System.out.println("dto: " + dto.toString());

	}

}
