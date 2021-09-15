package com.toy.springboot.homework;

public class Homework {

	private String homework_id, homework_name;
	private int homework_level;
	private String homework_type, homework_account_value, sort_id, member_id;

	public Homework() {
	}

	public Homework(String homework_id, String homework_name, int homework_level, String homework_type,
			String homework_account_value, String sort_id, String member_id) {
		super();
		this.homework_id = homework_id;
		this.homework_name = homework_name;
		this.homework_level = homework_level;
		this.homework_type = homework_type;
		this.homework_account_value = homework_account_value;
		this.sort_id = sort_id;
		this.member_id = member_id;
	}

	public String getHomework_id() {
		return homework_id;
	}

	public void setHomework_id(String homework_id) {
		this.homework_id = homework_id;
	}

	public String getHomework_name() {
		return homework_name;
	}

	public void setHomework_name(String homework_name) {
		this.homework_name = homework_name;
	}

	public int getHomework_level() {
		return homework_level;
	}

	public void setHomework_level(int homework_level) {
		this.homework_level = homework_level;
	}

	public String getHomework_type() {
		return homework_type;
	}

	public void setHomework_type(String homework_type) {
		this.homework_type = homework_type;
	}

	public String getHomework_account_value() {
		return homework_account_value;
	}

	public void setHomework_account_value(String homework_account_value) {
		this.homework_account_value = homework_account_value;
	}

	public String getSort_id() {
		return sort_id;
	}

	public void setSort_id(String sort_id) {
		this.sort_id = sort_id;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	@Override
	public String toString() {
		return "Homework [homework_id=" + homework_id + ", homework_name=" + homework_name + ", homework_level="
				+ homework_level + ", homework_type=" + homework_type + ", homework_account_value="
				+ homework_account_value + ", sort_id=" + sort_id + ", member_id=" + member_id + "]";
	}

}
