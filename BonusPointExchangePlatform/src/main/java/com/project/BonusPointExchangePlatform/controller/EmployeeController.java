package com.project.BonusPointExchangePlatform.controller;

import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Base64;
import java.util.Date;
import java.util.List;
import java.util.Optional;
import java.util.Set;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import com.project.BonusPointExchangePlatform.dao.AccountDao;
import com.project.BonusPointExchangePlatform.dao.EmployeeDao;
import com.project.BonusPointExchangePlatform.dao.OrdersDao;
import com.project.BonusPointExchangePlatform.dto.EmployeeDto;
import com.project.BonusPointExchangePlatform.dto.MemberDto;
import com.project.BonusPointExchangePlatform.dto.WalletDto;
import com.project.BonusPointExchangePlatform.model.Account;
import com.project.BonusPointExchangePlatform.model.Campaign;
import com.project.BonusPointExchangePlatform.model.Employee;
import com.project.BonusPointExchangePlatform.model.Member;
import com.project.BonusPointExchangePlatform.model.Order_Detail;
import com.project.BonusPointExchangePlatform.model.Orders;
import com.project.BonusPointExchangePlatform.model.Payment;
import com.project.BonusPointExchangePlatform.model.Wallet;
import com.project.BonusPointExchangePlatform.service.EmployeeService;
import com.project.BonusPointExchangePlatform.service.LoginService;
import com.project.BonusPointExchangePlatform.service.MailService;

@Controller
@SessionAttributes(names = {"employee","account"} )

public class EmployeeController {
	
	@Autowired
	private EmployeeService eService;
	
	@Autowired
	private LoginService loginService;

	@Autowired
	private MailService mailService;
	
	SimpleDateFormat DateFormat = new SimpleDateFormat("yyyy/MM/dd");
	SimpleDateFormat DateTimeFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	
	
	//*******?????????????????????????????????**********
	@GetMapping("/EditByRoot")
	public String RootPage1(HttpSession session) {
		
		Employee employee = (Employee)session.getAttribute("employee");
		

		if( employee == null) {
			return "/backend/entrance/newloginemp";

		}
		return "/backend/personManage/EditMemberByRoot";
	}	
	
	
	//*******???????????????????????????????????????**********
	@GetMapping("/EditByRoot1")
	
	public String RootPage2(HttpSession session) {
		
	Employee employee = (Employee)session.getAttribute("employee");
		

		if( employee == null) {
			return "/backend/entrance/newloginemp";

		}
		return "/backend/personManage/EditEmployeeByRoot";
	}	
	
	//*******??????????????????????????????**********
	@GetMapping("/EditByEmployee")
	public String EmployeePage(HttpSession session) {
		
		Employee employee = (Employee)session.getAttribute("employee");

		if( employee == null) {
			return "/backend/entrance/newloginemp";
		}
		return "/backend/personManage/EditMemberByEmployee";
	}		
	
	//*******??????????????????????????????**********
	
	@GetMapping("/backend/EditEmployeeByEmployee")
	public String newEmployeePage(HttpSession session) {
		
		Employee employee = (Employee)session.getAttribute("employee");

		if( employee == null) {
			return "/backend/entrance/newloginemp";
		}
		return "frontend/member/EditEmployeeByEmployee";
	}
	
	
	//**********????????????????????????????????????***********
	@ResponseBody
	@PostMapping(value="/backned/allEmployee", produces = {"application/json;charset=UTF-8"})
	public List<EmployeeDto> showAllEmployee(@RequestBody EmployeeDto employee) {

		String orderby = employee.getOrderby();
		System.out.println(orderby);
		System.out.println(employee.getEmployee().getId());
		List<EmployeeDto> m1 = eService.getAllEmployee(orderby);
	

			if(m1!=null) {	

				return m1;
			}else {
				return null;
			}
		
		
	}
	
	
	//**********??????????????????????????????????????????***********
	@ResponseBody
	@PostMapping(value="/backned/allEmployeeSearch", produces = {"application/json;charset=UTF-8"})
	public List<EmployeeDto> showAllbysearch(@RequestBody EmployeeDto Employee ) {
		
		System.out.println(Employee.getName());
		
		String orderby = Employee.getOrderby();
	
		List<EmployeeDto> m1 =eService.getAllEmployeeSearch(Employee.getName(),orderby);
		
		
		

			if(m1!=null) {	

				return m1;
			}else {
				return null;
			}
		
	}
	
	//**********????????????????????????????????????***********
	@ResponseBody
	@PostMapping(path = "/backned/employee/edit/restorepermission", produces = {"application/json;charset=UTF-8"})
	public List<EmployeeDto> restorepermission(@RequestBody  EmployeeDto dto ) {
		
		int id  = dto.getEmployee().getId();
		String orderby = dto.getOrderby();
		int type = dto.getAccount_type();
		int newtype;
		System.out.println(id);
		System.out.println(type);
		if(type==2) {
			newtype=0;
		}else {
			newtype=2;
		}
		System.out.println(newtype);
		List<EmployeeDto> dto1= eService.employeerestorepermission(id,newtype,orderby);
		System.out.println(dto1);
		
		return dto1;
			
	}
	
	
	//**********?????????????????????????????????***********
	@ResponseBody
	@PostMapping(path="/backned/edit/employee", produces = {"application/json;charset=UTF-8"})
	public List<EmployeeDto> editBacknedEmployeeById(@RequestBody EmployeeDto dto ) {
		Integer id = dto.getEmployee().getId();
		String name = dto.getEmployee().getName();
		Integer number = dto.getEmployee().getEmployee_no();
		String phone = dto.getEmployee().getPhone();
		String email = dto.getEmployee().getEmail();
		LocalDate arrived = LocalDate.parse(dto.getArrived_date());
		String orderby = dto.getOrderby();
		byte[] image2=null;
		if(dto.getImage()==null) {
			EmployeeDto m1 = eService.findoneEmployeebyId(id);
			image2 = m1.getEmployee().getImage();
			eService.editBacknedEmployeeDetail(name, number , arrived ,phone, email ,image2, id);
		}else
			eService.editBacknedEmployeeDetail(name, number , arrived ,phone, email ,dto.convertImage(), id);
		 
		List<EmployeeDto> all = eService.getAllEmployee(orderby);

		return all;
	
	}
	
	
	//**********??????????????????????????????????????????????????????***********
	@ResponseBody
	@PostMapping(path = "/backned/edit/employeebyid", produces = {"application/json;charset=UTF-8"})
	public EmployeeDto findoneEmployeeById(@RequestBody EmployeeDto dto ) {
		String orderby = dto.getOrderby();
		int id  = dto.getEmployee().getId();
		EmployeeDto dto1 = eService.findoneEmployeebyId(id);
		
		return dto1;	
	}
	
	
	//***********???????????????????????????????????????*********
	@ResponseBody
	@PostMapping(path = "/frontned/edit/EmployeeByEmployee", produces = {"application/json;charset=UTF-8"})
	public EmployeeDto editEmployeeById(@RequestBody EmployeeDto dto,HttpSession session) {
		Employee employee = (Employee)session.getAttribute("employee");
		Integer id = employee.getId();
		System.out.println(id);
//		int id  = dto.getAccount().getId();
		EmployeeDto dto1=eService.showEmployeeById(id);
		
		
		return dto1;	
	}
	
	
	//**********??????????????????????????????*********
	@ResponseBody
	@PostMapping(path="/edit/employeeDetail", produces = {"application/json;charset=UTF-8"})
	public EmployeeDto editEmployee(@RequestBody EmployeeDto dto,HttpSession session) {
		Employee employee = (Employee)session.getAttribute("employee");
		Integer id = employee.getId();
		String password = dto.getAccount().getPassword();
		String name = dto.getEmployee().getName();
		String arrived = DateFormat.format(dto.getEmployee().getArrived_at());
		Integer employee_no = dto.getEmployee().getEmployee_no();
		String email = dto.getEmployee().getEmail();
		String phone = dto.getEmployee().getPhone();
		System.out.println(password);
		System.out.println(name);
		System.out.println(arrived);
		System.out.println(employee_no);
		System.out.println(email);
		System.out.println(phone);
		if(dto.getImage()==null) {
		EmployeeDto e1 = eService.findoneEmployeebyId(id);
		byte[] image2 = e1.getEmployee().getImage();
		eService.editEmployeeDetail(name, arrived,employee_no, email, phone, password,image2, id);
		}else {
		String base64 = dto.getImage().substring(dto.getImage().indexOf(",")+1);
		byte[] a = Base64.getMimeDecoder().decode(base64);
		eService.editEmployeeDetail(name, arrived,employee_no, email, phone, password,a, id);
		}
		EmployeeDto dto1 =eService.showEmployeeById(id);
		
		return dto1;
		
	}
	
	@ResponseBody
	@PostMapping(path="/frontend/employee/iconphoto", produces = {"application/json;charset=UTF-8"})
	public Employee geticonphoto(@RequestBody EmployeeDto dto,HttpSession session ) {
//		Employee employee = (Employee)session.getAttribute("employee");
//		Integer id = employee.getId();
		Integer id1 = dto.getAccount().getId();
		System.out.println(id1);
		if(id1!=null) {
		Employee employee1 = eService.geticonphoto(id1);
		return employee1;
		}else
		return null;
		
	}

/*	@ResponseBody
	@GetMapping(path = "/query/findCampaignByEmployee")
	public void findCampaignByEmployee() {
		List<Employee> employee = employeeDao.findCampaignByEmployee();
		
		for(int i = 0; i < employee.size(); i++) {
			Set<Campaign> campaign = employee.get(i).getCampaign();
			
			for(Campaign camp : campaign) {
				System.out.println(camp.getTitle()); 
			}
		}
	}
	
	@ResponseBody
	@GetMapping(path = "/query/findAllOrders")
	public void findAllOrders() {
		List<Orders> orders = ordersDao.findAll();
		
		for(Orders o : orders) {
			System.out.println(o.getOrder_token());
			
			Set<Order_Detail> detail = o.getOrder_detail();			
			for(Order_Detail d : detail) {
				System.out.println(d.getProduct_name());				
			}
			
			Set<Payment> payment = o.getPayment();
			for(Payment p : payment) {
				System.out.println(p.getPayment());	
				
				Wallet wallet = p.getWallet();
				System.out.println(wallet.getId() + " , " + wallet.getSource_type() + " , " + wallet.getWallet_amount() + " , " + wallet.getBonus_point() + " , " + wallet.getCredit_card_amount() + " , " + wallet.getCreate_at());
				
			}
		}
	}
*/	
		
	/*????????????*/
/*	@ResponseBody
	@GetMapping(path = "/query/findEmployeeByAccountId")
	public void findEmployeeByAccountId(Integer id) {
		Optional<Account> optional = accountDao.findById(id);
		Employee employee = optional.get().getEmployee();
		
		String arrived_at = DateFormat.format(employee.getArrived_at());
		String create_date = DateTimeFormat.format(employee.getCreate_at());
        String update_date = DateTimeFormat.format(employee.getUpdate_at());
        
        System.out.println(employee.getId() + " , " + employee.getName() + " , " + arrived_at + " , " + employee.getEmployee_no() + " , " + employee.getPhone() + " , " + employee.getEmail() + " , " + employee.getImage() + " , " + create_date + " , " + update_date);
	}
*/	

	
	//??????
	/* ?????????????????? */
	@GetMapping("/loginEmp")
	public String loginEmpAction() {
		return "/backend/entrance/newloginemp";
	}

	/* ?????????????????? */
	@PostMapping(path = "/emphome")
	public String checkAccountEmp(@RequestParam("account") String account, @RequestParam("password") String password,
			Model m) {
		boolean result = loginService.checkAccountEmp(account, password);

		if (!result) {
			return "/backend/entrance/newloginempfail";
		} else {

			Account user = loginService.getBeanByAccPwd(account, password);
			System.out.println(user.getEmployee().getName());
			m.addAttribute("employee", user.getEmployee());
			m.addAttribute("account", user);


			return "redirect:/mainsearch";
		}
	}

	@GetMapping(path = "/logoutEmp")
	public String logoutEmp(SessionStatus status) {
		status.setComplete();
		return "redirect:/backnavbar";
	}

	/* ???????????????????????? */
	@GetMapping("/updatepasswordemp")
	public String mailActionemp() {
		return "/backend/entrance/updatepasswordemp";
	}

	/* ???????????? */
	@PostMapping("/sendemailemp")
	public String sendMailToUserEmp(@RequestParam("account") String account, @RequestParam("email") String email) {
		Account user = loginService.checkEmailUpdateCheckCodeEmp(account, email);
		System.out.println(user);
		if (user != null) {
			String checkcode = loginService.getRandomPassword();
			user.setCheck_code(checkcode);
			loginService.insertAccount(user);
			mailService.prepareAndSend(email, "??????????????????: " + checkcode);
			return "/backend/entrance/updatenewpasswordemp";

		} else {
			return "/backend/entrance/updatepasswordempfail";
		}
	}

	/* ???????????????????????????????????? */
	@PostMapping("/updatenewpasswordemp")
	public String updatePasswordByCheckcodeEmp(@RequestParam("checkcode") String checkcode,
			@RequestParam("password") String password) throws InvalidKeyException, NoSuchAlgorithmException, NoSuchPaddingException, IllegalBlockSizeException, BadPaddingException, InvalidAlgorithmParameterException {
		loginService.updatePwdByCheckcodeEmp(checkcode, password);
		return "/backend/entrance/updatesuccessemp";
	}
}
