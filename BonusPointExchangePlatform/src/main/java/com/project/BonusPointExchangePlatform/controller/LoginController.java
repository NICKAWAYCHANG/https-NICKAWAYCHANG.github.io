package com.project.BonusPointExchangePlatform.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import com.project.BonusPointExchangePlatform.model.Account;
import com.project.BonusPointExchangePlatform.model.Orders;
import com.project.BonusPointExchangePlatform.service.LoginService;
import com.project.BonusPointExchangePlatform.service.OrdersService;

@Controller
public class LoginController {

	/* 測試登入狀態 */
	@GetMapping("/test")
	public String loginTest() {
		return "/frontend/entrance/newlogin";
	}

	@GetMapping("/uptest")
	public String updateTest() {
		return "/frontend/entrance/updatesuccess";
	}

	@GetMapping("/uptestemp")
	public String empupdateTest() {
		return "/backend/entrance/updatesuccessemp";
	}

}
