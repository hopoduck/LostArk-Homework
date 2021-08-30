package com.toy.springboot;

import java.util.ArrayList;
import java.util.Iterator;

import com.toy.springboot.homework_record.HomeworkRecord;

public class JSON {

	public static String hrListToJSON(ArrayList<HomeworkRecord> al) {
		String res = "[";
		for (Iterator<HomeworkRecord> iterator = al.iterator(); iterator.hasNext();) {
			HomeworkRecord hr = iterator.next();
			res += hr.toJSON();
			if (iterator.hasNext()) {
				res += ", ";
			}
		}
		res += "]";
		return res;
	}

}