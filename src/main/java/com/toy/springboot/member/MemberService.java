package com.toy.springboot.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MemberService {

	@Autowired
	private MemberMapper mapper;

	public void addMember(Member m) {
		mapper.insert(m);
	}

	public Member getMemberByMember_id(String member_id) {
		return mapper.selectByMember_id(member_id);
	}

	public void editMember(Member m) {
		mapper.update(m);
	}

	public void deleteMember(String member_id) {
		mapper.delete(member_id);
	}

}
