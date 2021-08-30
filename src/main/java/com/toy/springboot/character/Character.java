package com.toy.springboot.character;

public class Character {

	private String character_id, character_name, member_id, sort_id;

	public Character() {
	}

	public Character(String character_id, String character_name, String member_id, String sort_id) {
		super();
		this.character_id = character_id;
		this.character_name = character_name;
		this.member_id = member_id;
		this.sort_id = sort_id;
	}

	public String getCharacter_id() {
		return character_id;
	}

	public void setCharacter_id(String character_id) {
		this.character_id = character_id;
	}

	public String getCharacter_name() {
		return character_name;
	}

	public void setCharacter_name(String character_name) {
		this.character_name = character_name;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public String getSort_id() {
		return sort_id;
	}

	public void setSort_id(String sort_id) {
		this.sort_id = sort_id;
	}

	@Override
	public String toString() {
		return "Character [character_id=" + character_id + ", character_name=" + character_name + ", member_id="
				+ member_id + ", sort_id=" + sort_id + "]";
	}

}