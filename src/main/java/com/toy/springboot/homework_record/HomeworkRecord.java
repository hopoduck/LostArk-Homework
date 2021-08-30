package com.toy.springboot.homework_record;

public class HomeworkRecord {

	private String homework_id, character_id, member_id, homework_type, record;

	public HomeworkRecord() {
	}

	public HomeworkRecord(String homework_id, String character_id, String member_id, String homework_type,
			String record) {
		super();
		this.homework_id = homework_id;
		this.character_id = character_id;
		this.member_id = member_id;
		this.homework_type = homework_type;
		this.record = record;
	}

	public String getHomework_id() {
		return homework_id;
	}

	public void setHomework_id(String homework_id) {
		this.homework_id = homework_id;
	}

	public String getCharacter_id() {
		return character_id;
	}

	public void setCharacter_id(String character_id) {
		this.character_id = character_id;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public String getHomework_type() {
		return homework_type;
	}

	public void setHomework_type(String homework_type) {
		this.homework_type = homework_type;
	}

	public String getRecord() {
		return record;
	}

	public void setRecord(String record) {
		this.record = record;
	}

	@Override
	public String toString() {
		return "HomeworkRecord [homework_id=" + homework_id + ", character_id=" + character_id + ", member_id="
				+ member_id + ", homework_type=" + homework_type + ", record=" + record + "]";
	}

	public String toJSON() {
		return "{\"homework_id\": \"" + homework_id + "\", \"character_id\": \"" + character_id
				+ "\", \"member_id\": \"" + member_id + "\", \"homework_type\": \"" + homework_type + "\", \"record\": "
				+ record + "}";
	}
}
