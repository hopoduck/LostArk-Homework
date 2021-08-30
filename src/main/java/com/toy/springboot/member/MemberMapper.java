package com.toy.springboot.member;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MemberMapper {

	void insert(Member m);

	Member selectByMember_id(String member_id);

	void update(Member m);

	void delete(String member_id);

}