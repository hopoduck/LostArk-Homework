package com.toy.springboot.memo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MemoService {

	@Autowired
	private MemoMapper mapper;

	public void createMemo(String member_id) {
		mapper.insert(member_id);
	}

	public Memo getMemo(String member_id) {
		return mapper.select(member_id);
	}

	public void editMemo(Memo m) {
		mapper.update(m);
	}

}
