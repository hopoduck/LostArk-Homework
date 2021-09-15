package com.toy.springboot.memo;

public class Memo {

	String member_id, memo_content;

	public Memo() {
	}

	public Memo(String member_id, String memo_content) {
		super();
		this.member_id = member_id;
		this.memo_content = memo_content;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public String getMemo_content() {
		return memo_content;
	}

	public void setMemo_content(String memo_content) {
		this.memo_content = memo_content;
	}

	@Override
	public String toString() {
		return "Memo [member_id=" + member_id + ", memo_content=" + memo_content + "]";
	}

}
