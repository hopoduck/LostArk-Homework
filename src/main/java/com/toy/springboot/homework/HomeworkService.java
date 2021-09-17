package com.toy.springboot.homework;

import java.util.ArrayList;
import java.util.Iterator;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class HomeworkService {

	@Autowired
	private HomeworkMapper mapper;

	public void addHomework(Homework h) {
		mapper.insert(h);
	}

	public Homework getHomework(String id) {
		return mapper.select(id);
	}

	public ArrayList<Homework> getHomeworkListByMember_id(String member_id) {
		return mapper.selectListByMember_id(member_id);
	}

	public ArrayList<Homework> getDayHomework(ArrayList<Homework> al) {
		ArrayList<Homework> newal = new ArrayList<Homework>();
		for (Iterator<Homework> iterator = al.iterator(); iterator.hasNext();) {
			Homework h = iterator.next();
			if (h.getHomework_type().equals("day")) {
				newal.add(h);
			}
		}
		return newal;
	}

	public ArrayList<Homework> getWeekHomework(ArrayList<Homework> al) {
		ArrayList<Homework> newal = new ArrayList<Homework>();
		for (Iterator<Homework> iterator = al.iterator(); iterator.hasNext();) {
			Homework h = iterator.next();
			if (h.getHomework_type().equals("week")) {
				newal.add(h);
			}
		}
		return newal;
	}

	public void editHomework(Homework h) {
		mapper.update(h);
	}

	public void deleteHomework(String id) {
		mapper.delete(id);
	}

	public int getSeqCurrval() {
		return mapper.selectSeqCurrval();
	}

	public void editSortId(int sort_id1, int sort_id2) {
//		sort_id1을 sort_id2로 수정 (sort_id1 => sort_id2), 반대로 동일 실행
		mapper.updateSortId(sort_id2, -1);
		mapper.updateSortId(sort_id1, sort_id2);
		mapper.updateSortId(-1, sort_id1);
	}

}
