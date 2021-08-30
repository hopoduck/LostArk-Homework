package com.toy.springboot.homework;

public class Homework {

	private String homework_id, homework_name, homework_type, homework_account_value, member_id;

	public Homework(String homework_id, String homework_name, String homework_type, String homework_account_value,
			String member_id) {
		super();
		this.homework_id = homework_id;
		this.homework_name = homework_name;
		this.homework_type = homework_type;
		this.homework_account_value = homework_account_value;
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

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	@Override
	public String toString() {
		return "Homework [homework_id=" + homework_id + ", homework_name=" + homework_name + ", homework_type="
				+ homework_type + ", homework_account_value=" + homework_account_value + ", member_id=" + member_id
				+ "]";
	}

}
