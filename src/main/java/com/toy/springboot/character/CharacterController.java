package com.toy.springboot.character;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.toy.springboot.URL;
import com.toy.springboot.homework.Homework;
import com.toy.springboot.homework.HomeworkService;
import com.toy.springboot.homework_record.HomeworkRecordService;

@Controller
public class CharacterController {

	@Autowired
	private CharacterService cService;
	@Autowired
	private HomeworkService hService;
	@Autowired
	private HomeworkRecordService hrService;

	@GetMapping("/character/add")
	public void addForm() {
	}

	@PostMapping("/character/getlevel")
	@ResponseBody
	public String getLevel(String character_name) {
		String url = "https://m-lostark.game.onstove.com/Profile/Character/" + character_name;
		Document doc = null;
		try {
			doc = Jsoup.connect(url).get();
		} catch (Exception e) {
			e.printStackTrace();
		}
		Element element = doc.selectFirst("dl.item2 dd.level");
		try {
			return element.text().replace(",", "");
		} catch (NullPointerException e) {
			return "-1";
		}
	}

	@PostMapping("/character/add")
	public String add(HttpServletRequest request, Character c,
			@RequestParam(required = false, defaultValue = "false") String find) {
//		보유한 캐릭터 목록 검색
//		if (find.equals("true")) {
//			String url = "https://m-lostark.game.onstove.com/Profile/Character/" + c.getCharacter_name();
//			Document doc = null;
//			try {
//				doc = Jsoup.connect(url).get();
//			} catch (Exception e) {
//				e.printStackTrace();
//			}
//			Elements elements = doc.select("div.myinfo__character--wrapper2");
//			if (elements.size() != 0) {
//				String charText = elements.get(0).getElementsByTag("a").text();
//				String[] charTexts = charText.split(" ");
//				ArrayList<Character> clist = new ArrayList<Character>();
//				for (int i = 0; i < charTexts.length; i++) {
//					if (i % 2 == 1) {
//						clist.add(new Character(null, charTexts[i], c.getMember_id(), null));
//					}
//				}
//				Collections.reverse(clist);
//				for (Iterator<Character> iterator = clist.iterator(); iterator.hasNext();) {
//					Character character = iterator.next();
////				목록 일괄 추가 및 숙제 기록 추가
//					cService.addCharacter(character);
//					String character_id = Integer.toString(cService.getSeqCurrval());
//					ArrayList<Homework> homeworkList = hService.getHomeworkListByMember_id(c.getMember_id());
//					hrService.addHomeworkRecordByCharacter_id(homeworkList, character_id);
//				}
//			} else {
////				목록 없을경우
//				cService.addCharacter(c);
//				String character_id = Integer.toString(cService.getSeqCurrval());
//				ArrayList<Homework> homeworkList = hService.getHomeworkListByMember_id(c.getMember_id());
//				hrService.addHomeworkRecordByCharacter_id(homeworkList, character_id);
//			}
//		} else {
////			검색 비지정
//			cService.addCharacter(c);
//			String character_id = Integer.toString(cService.getSeqCurrval());
//			ArrayList<Homework> homeworkList = hService.getHomeworkListByMember_id(c.getMember_id());
//			hrService.addHomeworkRecordByCharacter_id(homeworkList, character_id);
//		}
		cService.addCharacter(c);
		String character_id = Integer.toString(cService.getSeqCurrval());
		ArrayList<Homework> homeworkList = hService.getHomeworkListByMember_id(c.getMember_id());
		hrService.addHomeworkRecordByCharacter_id(homeworkList, character_id);
		return URL.redir + URL.menu;
	}

	@RequestMapping("/character/delete")
	public String delete(@RequestParam String character_id) {
		cService.deleteCharacter(character_id);
		hrService.deleteHomeworkRecordByCharacter_id(character_id);
		return URL.redir + URL.menu;
	}

	@RequestMapping("/character/changesortid")
	public String chageSortId(String sort_id1, String sort_id2) {
		cService.editSortId(sort_id1, sort_id2);
		return URL.redir + URL.menu;
	}

}
