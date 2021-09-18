package com.toy.springboot;

public class Sort {

	private String character_id;
	private int sort_id;

	public Sort() {
	}

	public Sort(String character_id, int sort_id) {
		super();
		this.character_id = character_id;
		this.sort_id = sort_id;
	}

	public String getCharacter_id() {
		return character_id;
	}

	public void setCharacter_id(String character_id) {
		this.character_id = character_id;
	}

	public int getSort_id() {
		return sort_id;
	}

	public void setSort_id(int sort_id) {
		this.sort_id = sort_id;
	}

	@Override
	public String toString() {
		return "Sort [character_id=" + character_id + ", sort_id=" + sort_id + "]";
	}

//	int sort_id1, sort_id2, temp, temp2;
//
//	public Sort() {
//	}
//
//	public Sort(int sort_id1, int sort_id2) {
//		super();
//		this.sort_id1 = sort_id1;
//		this.sort_id2 = sort_id2;
//	}
//
//	public int getSort_id1() {
//		return sort_id1;
//	}
//
//	public void setSort_id1(int sort_id1) {
//		this.sort_id1 = sort_id1;
//	}
//
//	public int getSort_id2() {
//		return sort_id2;
//	}
//
//	public void setSort_id2(int sort_id2) {
//		this.sort_id2 = sort_id2;
//	}
//
//	public int getTemp() {
//		return temp;
//	}
//
//	public void setTemp(int temp) {
//		this.temp = temp;
//	}
//
//	public int getTemp2() {
//		return temp2;
//	}
//
//	public void setTemp2(int temp2) {
//		this.temp2 = temp2;
//	}
//
//	public Sort changeFirst() {
//		temp = sort_id1;
//		temp2 = sort_id2;
//		sort_id1 = sort_id2;
//		sort_id2 = -1;
//		return this;
//	}
//
//	public Sort changeSecond() {
//		sort_id1 = temp;
//		sort_id2 = temp2;
//		return this;
//	}
//
//	public Sort changeThird() {
//		sort_id1 = -1;
//		sort_id2 = temp;
//		return this;
//	}
//
//	public Sort changeFinal() {
//		sort_id1 = temp;
//		sort_id2 = temp2;
//		return this;
//	}
//
//	@Override
//	public String toString() {
//		return "Sort [sort_id1=" + sort_id1 + ", sort_id2=" + sort_id2 + ", temp=" + temp + ", temp2=" + temp2 + "]";
//	}
//
//	public String toJSON() {
//		return "{\"sort_id1\": " + sort_id1 + ", \"sort_id2\": " + sort_id2 + "}";
//	}

}
