package com.toy.springboot.homework_record;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.toy.springboot.character.Character;
import com.toy.springboot.homework.Homework;

@Service
public class HomeworkRecordService {

	@Autowired
	private HomeworkRecordMapper mapper;

	public void addHomeworkRecord(HomeworkRecord hr) {
		mapper.insert(hr);
	}

	public HomeworkRecord getHomeworkRecord(String character_id, String homework_id) {
		return mapper.select(character_id, homework_id);
	}

	public ArrayList<HomeworkRecord> getHomeworkRecordByCharacter_id(String character_id) {
		return mapper.selectByCharacter_id(character_id);
	}

	public ArrayList<HomeworkRecord> getHomeworkRecordByHomework_id(String homework_id) {
		return mapper.selectByHomework_id(homework_id);
	}

	public ArrayList<HomeworkRecord> getHomeworkRecordByMember_id(String member_id) {
		return mapper.selectByMember_id(member_id);
	}

	public void changeRecord(String character_id, String homework_id, String record) {
		mapper.updateRecord(character_id, homework_id, record);
	}

	public void deleteHomeworkRecordByCharacter_id(String Character_id) {
		mapper.deleteByCharacter_id(Character_id);
	}

	public void deleteHomeworkRecordByHomework_id(String homework_id) {
		mapper.deleteByHomework_id(homework_id);
	}

	public void addHomeworkRecordByCharacter_id(ArrayList<Homework> homeworkList, String character_id) {
//		기존에 생성된 숙제가 있을 경우
		if (!homeworkList.isEmpty()) {
			for (int i = 0; i < homeworkList.size(); i++) {
				Homework h = homeworkList.get(i);
//				캐릭터 ID를 어떻게 가져올지...?
				HomeworkRecord hr = new HomeworkRecord(h.getHomework_id(), character_id, h.getMember_id(),
						h.getHomework_type(), "false");
//				새로 생성된 캐릭터와 기존 숙제 목록을 결합한 숙제 기록들을 테이블에 추가한다.
				mapper.insert(hr);
			}
		}
	}

	public void addHomeworkRecordByHomework_id(ArrayList<Character> characterList, String homework_id, Homework h) {
//		기존에 생성된 숙제가 있을 경우
		if (!characterList.isEmpty()) {
			for (int i = 0; i < characterList.size(); i++) {
				Character c = characterList.get(i);
//				캐릭터 ID를 어떻게 가져올지...?
				HomeworkRecord hr = new HomeworkRecord(homework_id, c.getCharacter_id(), c.getMember_id(),
						h.getHomework_type(), "false");
//				새로 생성된 캐릭터와 기존 숙제 목록을 결합한 숙제 기록들을 테이블에 추가한다.
//				System.out.println(hr);
				mapper.insert(hr);
			}
		}
	}

	public void homeworkRecordResetByType(String homework_type) {
		mapper.homeworkRecordResetByType(homework_type);
	}

}
