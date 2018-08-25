package admin;

public class ChartDto {

	private int bronze;
	private int silver;
	private int gold;
	private int platinum;
	private int diamond;
	
	
	public ChartDto(int bronze, int silver, int gold, int platinum, int diamond) {
		super();
		this.bronze = bronze;
		this.silver = silver;
		this.gold = gold;
		this.platinum = platinum;
		this.diamond = diamond;
	}
	
	
	public int getBronze() {
		return bronze;
	}
	public void setBronze(int bronze) {
		this.bronze = bronze;
	}
	public int getSilver() {
		return silver;
	}
	public void setSilver(int silver) {
		this.silver = silver;
	}
	public int getGold() {
		return gold;
	}
	public void setGold(int gold) {
		this.gold = gold;
	}
	public int getPlatinum() {
		return platinum;
	}
	public void setPlatinum(int platinum) {
		this.platinum = platinum;
	}
	public int getDiamond() {
		return diamond;
	}
	public void setDiamond(int diamond) {
		this.diamond = diamond;
	}
	
	
	@Override
	public String toString() {
		return "ChartDto [bronze=" + bronze + ", silver=" + silver + ", gold=" + gold + ", platinum=" + platinum
				+ ", diamond=" + diamond + "]";
	}
	
	
	
	
}

