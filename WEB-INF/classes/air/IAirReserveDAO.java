package air;



public interface IAirReserveDAO {
	
	
	// 항공권 예약하기
	public boolean AirReserve(AirReserveDTO dto);
	
	// 항공권 좌석 계산
	public AirTotalInfoDTO seatPrice(AirPlainDTO airinfoListdto, AirProductDTO airpdtdto, String lev, int seatCount); 
}
