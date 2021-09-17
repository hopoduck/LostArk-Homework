package com.toy.springboot.character;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.toy.springboot.Sort;

@Mapper
public interface CharacterMapper {

	void insert(Character c);

	Character select(String id);

	ArrayList<Character> selectListByMember_id(String member_id);

	void update(Character c);

	void updateSortId(Sort s);

	void delete(String id);

	int selectSeqCurrval();

}