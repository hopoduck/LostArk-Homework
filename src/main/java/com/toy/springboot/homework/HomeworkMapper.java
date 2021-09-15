package com.toy.springboot.homework;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface HomeworkMapper {

	void insert(Homework h);

	Homework select(String homework_id);

	ArrayList<Homework> selectListByMember_id(String member_id);

	void update(Homework h);

	void updateSortId(String sort_id1, String sort_id2);

	void delete(String homework_id);

	int selectSeqCurrval();

}
