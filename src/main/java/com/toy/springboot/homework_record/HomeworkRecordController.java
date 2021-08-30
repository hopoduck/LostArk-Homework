package com.toy.springboot.homework_record;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.toy.springboot.JSON;
import com.toy.springboot.character.CharacterService;
import com.toy.springboot.homework.Homework;
import com.toy.springboot.homework.HomeworkService;
import com.toy.springboot.character.Character;

@Controller
public class HomeworkRecordController {

	@Autowired
	private CharacterService cService;
	@Autowired
	private HomeworkService hService;
	@Autowired
	private HomeworkRecordService hrService;

	@RequestMapping("/homeworkRecord/getList")
	public @ResponseBody String getList(@RequestParam String member_id) {
		ArrayList<HomeworkRecord> list = hrService.getHomeworkRecordByMember_id(member_id);
		return JSON.hrListToJSON(list);
	}

	@RequestMapping("/homeworkRecord/change")
	public @ResponseBody String change(@RequestParam String homework_id, @RequestParam String character_id,
			@RequestParam String record) {
		Homework h = hService.getHomework(homework_id);
		ArrayList<HomeworkRecord> hrList = new ArrayList<HomeworkRecord>();
//		원정대 제한일 경우
		if (h.getHomework_account_value().equals("true")) {
			ArrayList<Character> cList = cService.getCharacterListByMember_id(h.getMember_id());
//			해당 멤버의 캐릭터 목록을 가져와서 기록을 전부 변경한다.
			for (int i = 0; i < cList.size(); i++) {
				String listCharacter_id = cList.get(i).getCharacter_id();
				hrList.add(new HomeworkRecord(homework_id, cList.get(i).getCharacter_id(), h.getMember_id(),
						h.getHomework_type(), record));
				hrService.changeRecord(listCharacter_id, homework_id, record);
			}
		} else {
			hrService.changeRecord(character_id, homework_id, record);
			HomeworkRecord hr = hrService.getHomeworkRecord(character_id, homework_id);
			hrList.add(hr);
		}
		return JSON.hrListToJSON(hrList);
	}

}
