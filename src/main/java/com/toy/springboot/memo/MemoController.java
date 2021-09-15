package com.toy.springboot.memo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class MemoController {

	@Autowired
	private MemoService mService;

	@RequestMapping("/memo/save")
	@ResponseBody
	public HttpStatus memoSave(Memo m) {
		mService.editMemo(m);
		return HttpStatus.OK;
	}

}
