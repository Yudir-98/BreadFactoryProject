package Link;

public class Link {

	public static String getPageLink(String str) {
		String Link = "";
			switch(str) {
				case "교육기획": {
					Link = "./Bannerpage.jsp";
					break;
				}
				case "인사관리": {
					Link = "./Human_Resource.jsp";
					break;
				}
				case "회계": {
					Link = "./Accounting.jsp";
					break;
				}
				case "자재현황분석": {
					Link = "./Material_Status_Analyze.jsp";
					break;
				}
				case "생산현황분석": {
					Link = "./Production_Profile.jsp";
					break;
				}
				case "재고관리": {
					Link = "./Inventory.jsp";
					break;
				}
				case "CEO": {
					Link = "./Main.jsp";
					break;
				}
				case "생산기획": {
					Link = "./Production_Status.jsp";
					break;
				}
				case "품질관리": {
					Link = "./Quality_Control.jsp";
					break;
				}
				case "매장관리": {
					Link = "./Correspondent_Product.jsp";
					break;
				}
				case "자재 거래처 관리": {
					Link = "./Correspondent_Material.jsp";
					break;
				}
				
			}
		return Link;
	}
}
