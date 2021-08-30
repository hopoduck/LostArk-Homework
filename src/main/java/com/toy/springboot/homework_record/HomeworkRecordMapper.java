package com.toy.springboot.homework_record;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface HomeworkRecordMapper {

	void insert(HomeworkRecord hr);

	HomeworkRecord select(String character_id, String homework_id);

	ArrayList<HomeworkRecord> selectByCharacter_id(String character_id);

	ArrayList<HomeworkRecord> selectByHomework_id(String homework_id);

	ArrayList<HomeworkRecord> selectByMember_id(String member_id);

	void updateRecord(String character_id, String homework_id, String record);

	void deleteByCharacter_id(String Character_id);

	void deleteByHomework_id(String homework_id);

	void homeworkRecordResetByType(String homework_type);

}
