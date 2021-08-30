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

}
