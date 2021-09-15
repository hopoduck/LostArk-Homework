-- DB초기화
drop table LAR_MEMBER cascade constraint;
drop table LAR_CHARACTER cascade constraint;
drop table LAR_HOMEWORK cascade constraint;
drop table LAR_HOMEWORK_RECORD cascade constraint;
drop table LAR_MEMO cascade constraint;
drop sequence LAR_SEQ_CHARACTER;
drop sequence LAR_SEQ_HOMEWORK;
-- DB생성
create table LAR_MEMBER(
  member_id varchar2(100) primary key,
  member_password varchar2(100) not null,
  member_name varchar2(100) not null
);
create table LAR_CHARACTER(
  character_id varchar2(100) primary key,
  character_name varchar2(100) not null,
  character_level number,
  member_id varchar2(100) REFERENCES LAR_MEMBER(member_id) ON DELETE CASCADE,
  sort_id varchar2(100) not null
);
create table LAR_HOMEWORK(
  homework_id varchar2(1000) primary key,
  homework_name varchar2(100) not null,
  homework_type varchar2(4) not null CHECK (homework_type IN ('day', 'week')),
  homework_account_value varchar2(5) CHECK (homework_account_value IN ('true', 'false')),
  member_id varchar2(100) REFERENCES LAR_MEMBER(member_id) ON DELETE CASCADE
);
create table LAR_HOMEWORK_RECORD(
  homework_id varchar2(1000) REFERENCES LAR_HOMEWORK(homework_id) ON DELETE CASCADE,
  character_id varchar2(100) REFERENCES LAR_CHARACTER(character_id) ON DELETE CASCADE,
  member_id varchar2(100) REFERENCES LAR_MEMBER(member_id) ON DELETE CASCADE,
  homework_type varchar2(4) not null CHECK (homework_type IN ('day', 'week')),
  record varchar2(5) CHECK (record IN ('true', 'false')),
  CONSTRAINT homework_record_id PRIMARY KEY(homework_id, character_id, member_id)
);
create table LAR_MEMO(
  member_id varchar2(100) REFERENCES LAR_MEMBER(member_id) ON DELETE CASCADE,
  memo varchar2(3000)
);
create sequence LAR_SEQ_CHARACTER;
create sequence LAR_SEQ_HOMEWORK;

commit;



-- 새 테이블 생성!!! 이전테이블과 호환되지 않음!!
-- 데이터 보전방법 생각해봐야 함
-- DB초기화
drop table LAR_MEMBER cascade constraint;
drop table LAR_CHARACTER cascade constraint;
drop table LAR_HOMEWORK cascade constraint;
drop table LAR_HOMEWORK_RECORD cascade constraint;
drop table LAR_MEMO cascade constraint;
drop sequence LAR_SEQ_CHARACTER;
drop sequence LAR_SEQ_HOMEWORK;
-- DB생성
create table LAR_MEMBER(
  member_id varchar2(100) primary key,
  member_password varchar2(100) not null,
  member_name varchar2(100) not null
);
create table LAR_CHARACTER(
  character_id varchar2(100) primary key,
  character_name varchar2(100) not null,
  character_level number,
  sort_id varchar2(100) not null,
  member_id varchar2(100) REFERENCES LAR_MEMBER(member_id) ON DELETE CASCADE
);
create table LAR_HOMEWORK(
  homework_id varchar2(1000) primary key,
  homework_name varchar2(100) not null,
  homework_level number,
  homework_type varchar2(4) not null CHECK (homework_type IN ('day', 'week')),
  homework_account_value varchar2(5) CHECK (homework_account_value IN ('true', 'false')),
  sort_id varchar2(1000) not null,
  member_id varchar2(100) REFERENCES LAR_MEMBER(member_id) ON DELETE CASCADE
);
create table LAR_HOMEWORK_RECORD(
  homework_id varchar2(1000) REFERENCES LAR_HOMEWORK(homework_id) ON DELETE CASCADE,
  character_id varchar2(100) REFERENCES LAR_CHARACTER(character_id) ON DELETE CASCADE,
  member_id varchar2(100) REFERENCES LAR_MEMBER(member_id) ON DELETE CASCADE,
  homework_type varchar2(4) not null CHECK (homework_type IN ('day', 'week')),
  record varchar2(5) CHECK (record IN ('true', 'false')),
  CONSTRAINT homework_record_id PRIMARY KEY(homework_id, character_id, member_id)
);
create table LAR_MEMO(
  member_id varchar2(100) REFERENCES LAR_MEMBER(member_id) ON DELETE CASCADE,
  memo_content long
);
create sequence LAR_SEQ_CHARACTER;
create sequence LAR_SEQ_HOMEWORK;

commit;