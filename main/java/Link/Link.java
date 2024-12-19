package Link;

public class Link {

	public static String getPageLink(String str) {
		String Link = "";
			switch(str) {
				case "교육기획": {
					Link = "./Education.jsp";
					break;
				}
				case "조직관리": {
					Link = "./Human_Resource.jsp";
					break;
				}
				case "회계": {
					Link = "./Main.jsp";
					break;
				}
				case "자재현황분석": {
					Link = "./Main.jsp";
					break;
				}
				case "생산현황분석": {
					Link = "./Main.jsp";
					break;
				}
				case "재고관리": {
					Link = "./Main.jsp";
					break;
				}
				case "CEO": {
					Link = "./Main.jsp";
					break;
				}
				case "불량품관리": {
					Link = "./Main.jsp";
					break;
				}
				case "생산기획": {
					Link = "./Main.jsp";
					break;
				}
				case "품질관리": {
					Link = "./Main.jsp";
					break;
				}
				case "매장관리": {
					Link = "./Main.jsp";
					break;
				}
				case "CS": {
					Link = "./Main.jsp";
					break;
				}
				
			}
		return Link;
	}
}
