package com.toy.springboot.member;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.toy.springboot.URL;
import com.toy.springboot.character.CharacterService;
import com.toy.springboot.homework.Homework;
import com.toy.springboot.homework.HomeworkService;

@Controller
public class MemberController {

	@Autowired
	private MemberService mService;
	@Autowired
	private CharacterService cService;
	@Autowired
	private HomeworkService hService;

	@Autowired
	private HttpSession session;

	@RequestMapping("/")
	public String root() {
		return URL.redir + URL.login;
	}

	@GetMapping("/member/join")
	public void joinForm() {

	}

	@PostMapping("/member/join")
	public String join(Member m) {
		mService.addMember(m);
		return URL.redir + URL.login;
	}

	@GetMapping("/member/login")
	public void loginForm() {
	}

	@PostMapping("/member/login")
	public String login(HttpServletRequest request, @RequestParam String member_id,
			@RequestParam String member_password, Model model) {
		Member m = mService.getMemberByMember_id(member_id);
		if (m == null) {
			return URL.redir + URL.login;
		}
		if (m.getMember_password().equals(member_password)) {
			HttpSession session = request.getSession();
			session.setAttribute("user", m);
			return URL.redir + URL.menu;
		} else {
			return URL.redir + URL.login;
		}
	}

	@RequestMapping("/member/menu")
	public String menu(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("user") == null) {
			return URL.redir + URL.login;
		} else {
			Member m = (Member) session.getAttribute("user");
			model.addAttribute("characterList", cService.getCharacterListByMember_id(m.getMember_id()));
			ArrayList<Homework> list = hService.getHomeworkListByMember_id(m.getMember_id());
			model.addAttribute("dayHomework", hService.getDayHomework(list));
			model.addAttribute("weekHomework", hService.getWeekHomework(list));
			return URL.menu;
		}

	}

	@RequestMapping("/member/logout")
	public String logout(HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		session.removeAttribute("user");
		session.invalidate();
		return URL.redir + URL.login;
	}

	@RequestMapping("/member/find_member_id")
	@ResponseBody
	public String findMemberId(@RequestParam String member_id) {
		Member m = mService.getMemberByMember_id(member_id);
		if (m == null) {
			return "{\"result\": true}";
		} else {
			return "{\"result\": false}";
		}
	}

	@RequestMapping("/member/out")
	public String out() {
		Member m= (Member) session.getAttribute("user");
		mService.deleteMember(m.getMember_id());
		return URL.redir + URL.login;
	}

}
