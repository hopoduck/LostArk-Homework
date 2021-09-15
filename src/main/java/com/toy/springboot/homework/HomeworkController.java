package com.toy.springboot.homework;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.toy.springboot.URL;
import com.toy.springboot.character.Character;
import com.toy.springboot.character.CharacterService;
import com.toy.springboot.homework_record.HomeworkRecordService;

@Controller
public class HomeworkController {

	@Autowired
	private CharacterService cService;
	@Autowired
	private HomeworkService hService;
	@Autowired
	private HomeworkRecordService hrService;

	@GetMapping("/homework/add")
	public void addForm() {
	}

	@PostMapping("/homework/add")
	public String add(Homework h) {
//		숙제를 추가
//		원정대 제한 값이 true가 아닐경우
		if (h.getHomework_account_value() == null) {
//			체크를 하지 않았으므로 false로 지정
			h.setHomework_account_value("false");
		}
		hService.addHomework(h);
		String homework_id = Integer.toString(hService.getSeqCurrval());
		ArrayList<Character> characterList = cService.getCharacterListByMember_id(h.getMember_id());
//		기존에 있는 캐릭터들에 숙제 기록을 추가
		hrService.addHomeworkRecordByHomework_id(characterList, homework_id, h);
//		완료후 다시 메뉴로
		return URL.redir + URL.menu;
	}

	@PostMapping("/homework/get-data")
	@ResponseBody
	public String getData(@RequestParam String homework_id) {
		Homework h = hService.getHomework(homework_id);
		if (h != null) {
			return h.toJSON();
		} else {
			return HttpStatus.NOT_FOUND.getReasonPhrase();
		}
	}

	@PostMapping("/homework/edit")
	public String editHomework(Homework h) {
		if (h.getHomework_account_value() == null) {
			h.setHomework_account_value("false");
		}
		hService.editHomework(h);
		return URL.redir + URL.menu;
	}

	@RequestMapping("/homework/changesortid")
	public String chageSortId(String sort_id1, String sort_id2) {
		hService.editSortId(sort_id1, sort_id2);
		return URL.redir + URL.menu;
	}

	@RequestMapping("/homework/delete")
	public String delete(@RequestParam String homework_id) {
		hService.deleteHomework(homework_id);
		hrService.deleteHomeworkRecordByHomework_id(homework_id);
		return URL.redir + URL.menu;
	}

}
