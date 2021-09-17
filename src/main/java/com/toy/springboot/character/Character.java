package com.toy.springboot.character;

public class Character {

	private String character_id, character_name;
	private int character_level, sort_id;
	private String member_id;

	public Character() {
	}

	public Character(String character_id, String character_name, int character_level, int sort_id, String member_id) {
		super();
		this.character_id = character_id;
		this.character_name = character_name;
		this.character_level = character_level;
		this.sort_id = sort_id;
		this.member_id = member_id;
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

	public int getCharacter_level() {
		return character_level;
	}

	public void setCharacter_level(int character_level) {
		this.character_level = character_level;
	}

	public int getSort_id() {
		return sort_id;
	}

	public void setSort_id(int sort_id) {
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
		return "Character [character_id=" + character_id + ", character_name=" + character_name + ", character_level="
				+ character_level + ", sort_id=" + sort_id + ", member_id=" + member_id + "]";
	}

}
