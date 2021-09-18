package com.toy.springboot.character;

import java.util.ArrayList;
import java.util.Iterator;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.toy.springboot.Sort;

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

////	
//	public ArrayList<Character> sort(ArrayList<Character> list) {
//		for (int i = 0; i < list.size(); i++) {
//			Character c = list.get(i);
//			c.setSort_id(i);
//			editCharacter(c);
//		}
//		return list;
//	}

//	캐릭터 레벨을 웹에서 가져오기
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
			return element.text().replace(",", "").split("\\.")[0];
		} catch (NullPointerException e) {
			return "-1";
		}
	}

//	사용자의 캐릭터 레벨 일괄 업데이트
	public void characterLevelUpdate(String member_id) {
		for (Iterator<Character> iterator = getCharacterListByMember_id(member_id).iterator(); iterator.hasNext();) {
			Character c = iterator.next();
			String level = getLevel(c.getCharacter_name());
			if (!level.equals("-1")) {
				c.setCharacter_level(Integer.parseInt(level));
			}
			editCharacter(c);
		}
	}

//	캐릭터 수정
	public void editCharacter(Character c) {
		mapper.update(c);
	}

//	정렬순서 수정
	public void editSortId(Sort s) {
		mapper.updateSortId(s);
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
