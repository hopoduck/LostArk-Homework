package com.toy.springboot.character;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CharacterService {

	@Autowired
	private CharacterMapper mapper;

//	캐릭터 추가
	public void addCharacter(Character c) {
		mapper.insert(c);
	}

//	캐릭터 데이터 가져오기
	public Character getCharacter(String character_id) {
		return mapper.select(character_id);
	}

//	sort_id기준으로 데이터 정렬해서 가져옴
	public ArrayList<Character> getCharacterListByMember_id(String member_id) {
		return mapper.selectListByMember_id(member_id);
	}

//	캐릭터 수정
	public void editCharacter(Character c) {
		mapper.update(c);
	}

//	정렬순서 수정
	public void editSortId(String sort_id1, String sort_id2) {
//		sort_id1을 sort_id2로 수정 (sort_id1 => sort_id2), 반대로 동일 실행
		mapper.updateSortId(sort_id2, "-1");
		mapper.updateSortId(sort_id1, sort_id2);
		mapper.updateSortId("-1", sort_id1);
	}

//	삭제
	public void deleteCharacter(String character_id) {
		mapper.delete(character_id);
	}

//	시퀀스 번호 가져오기(character_id)
	public int getSeqCurrval() {
		return mapper.selectSeqCurrval();
	}

}
