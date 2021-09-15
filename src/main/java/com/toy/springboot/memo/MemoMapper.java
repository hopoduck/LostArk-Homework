package com.toy.springboot.memo;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MemoMapper {

	void insert(String member_id);

	Memo select(String member_id);

	void update(Memo m);

}
