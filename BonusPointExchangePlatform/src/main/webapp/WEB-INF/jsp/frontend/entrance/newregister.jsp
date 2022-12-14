<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
@import
	url('https://fonts.googleapis.com/css?family=Montserrat:400,800');

* {
	box-sizing: border-box;
}

.loginbody {
	background: #f6f5f7;
	display: flex;
	justify-content: center;
	align-items: center;
	flex-direction: column;
	font-family: 'Montserrat', sans-serif;
	height: 35vh;
	margin: -20px 0 50px;
}

.logingh1 {
	font-weight: bold;
	margin: 0;
}

.logingh2 {
	text-align: center;
}

.loginp {
	font-size: 14px;
	font-weight: 100;
	line-height: 20px;
	letter-spacing: 0.5px;
	margin: 20px 0 30px;
	color: white;
}

.logina {
	color: #333;
	font-size: 14px;
	text-decoration: none;
	margin: 15px 0;
}

.loginbutton {
	border-radius: 20px;
	border: 1px solid #FF4B2B;
	background-color: #FF4B2B;
	color: #FFFFFF;
	font-size: 12px;
	font-weight: bold;
	padding: 12px 45px;
	letter-spacing: 1px;
	text-transform: uppercase;
	transition: transform 80ms ease-in;
}

button:active {
	transform: scale(0.95);
}

button:focus {
	outline: none;
}

.signupbutton {
	border-radius: 20px;
	border: 1px solid #FFFFFF;
	background-color: transparent;
	color: #FFFFFF;
	font-size: 12px;
	font-weight: bold;
	padding: 12px 45px;
	letter-spacing: 1px;
	text-transform: uppercase;
	transition: transform 80ms ease-in;
}

button.ghost {
	background-color: transparent;
	border-color: #FFFFFF;
}

.loginform {
	background-color: #FFFFFF;
	display: flex;
	align-items: center;
	justify-content: center;
	flex-direction: column;
	padding: 0 50px;
	height: 100%;
	text-align: center;
}

input {
	background-color: #eee;
	border: none;
	padding: 12px 15px;
	margin: 8px 0;
	width: 100%;
}

.logincontainer {
	background-color: #fff;
	border-radius: 10px;
	box-shadow: 0 14px 28px rgba(0, 0, 0, 0.25), 0 10px 10px
		rgba(0, 0, 0, 0.22);
	position: relative;
	overflow: hidden;
	width: 1768px;
	max-width: 100%;
	min-height: 880px;
}

.form-logincontainer {
	position: absolute;
	top: 0;
	height: 100%;
	transition: all 0.6s ease-in-out;
}

.sign-in-container {
	left: 0;
	width: 50%;
	z-index: 2;
}

.logincontainer.right-panel-active .sign-in-container {
	transform: translateX(100%);
}

.sign-up-container {
	left: 0;
	width: 50%;
	opacity: 0;
	z-index: 1;
}

.logincontainer.right-panel-active .sign-up-container {
	transform: translateX(100%);
	opacity: 1;
	z-index: 5;
	animation: show 0.6s;
}

@
keyframes show { 0%, 49.99% {
	opacity: 0;
	z-index: 1;
}

50


%
,
100


%
{
opacity


:


1
;


z-index


:


5
;


}
}
.overlay-logincontainer {
	position: absolute;
	top: 0;
	left: 50%;
	width: 50%;
	height: 100%;
	overflow: hidden;
	transition: transform 0.6s ease-in-out;
	z-index: 100;
}

.logincontainer.right-panel-active .loginoverlay-container {
	transform: translateX(-100%);
}

.loginoverlay {
	background: #FFA600;
	background: -webkit-linear-gradient(to right, #FF4B2B, #FFA600);
	background: linear-gradient(to right, #FF4B2B, #FFA600);
	background-repeat: no-repeat;
	background-size: cover;
	background-position: 0 0;
	color: #FFFFFF;
	position: relative;
	left: -100%;
	height: 100%;
	width: 200%;
	transform: translateX(0);
	transition: transform 0.6s ease-in-out;
}

.logincontainer.right-panel-active .loginoverlay {
	transform: translateX(50%);
}

.overlay-panel {
	position: absolute;
	display: flex;
	align-items: center;
	justify-content: center;
	flex-direction: column;
	padding: 0 40px;
	text-align: center;
	top: 0;
	height: 100%;
	width: 50%;
	transform: translateX(0);
	transition: transform 0.6s ease-in-out;
}

.overlay-left {
	transform: translateX(-20%);
}

.logincontainer.right-panel-active .overlay-left {
	transform: translateX(0);
}

.overlay-right {
	right: 0;
	transform: translateX(0);
}

.logincontainer.right-panel-active .overlay-right {
	transform: translateX(20%);
}

.social-container {
	margin: 20px 0;
}

.social-container a {
	border: 1px solid #DDDDDD;
	border-radius: 50%;
	display: inline-flex;
	justify-content: center;
	align-items: center;
	margin: 0 5px;
	height: 40px;
	width: 40px;
}

.NameSb {
	border-bottom: solid gray 3px;
	padding-bottom: 15px;
	margin: 15px 30px 15px 30px;
	width: 100%;
	height: 125px;
}

.NameSb2 {
	border-bottom: solid white 3px;
	padding-bottom: 15px;
	margin: 15px 30px 15px 30px;
	width: 100%;
	height: 130px;
}
</style>


<script>

let accheckrepeat,emaillcheckrepeat,bankcheckrepeat=false;

function checkacrepeat() {
		var div = document.getElementById('resultAcc');

	  var accValue = document.getElementById("account").value;
	  if (accValue=="") {
		accheckrepeat=false;
		div.innerHTML = "<font color='blue' size='-1'>???????????????...</font>";
		return;
	  }
	  var xhr = new XMLHttpRequest();
	  xhr.open("POST", "<c:url value='/CheckAccountRepeat'/>", true);
	  xhr.setRequestHeader("Content-Type",
				"application/x-www-form-urlencoded");
	  xhr.send("account=" + accValue);
	  var message = "";
	  xhr.onreadystatechange = function() {
	    // ?????????????????????
	    if (xhr.readyState == 4 && xhr.status == 200) {
		   var result = JSON.parse(xhr.responseText);
		   if (result.account.length == 0) {
			accheckrepeat=true;
			  message = "<font color='green' size='-2'>????????????</font>";
		   }else {
				accheckrepeat=false;
			  message = "<font color='red' size='-2'>????????????????????????????????????</font>"; 
		   }
		   div.innerHTML = message;
	    }
   }
 }

function checkmailrepeat() {
	var maildiv = document.getElementById('resultEmail');

	  var mailValue = document.getElementById("email").value;
	  if (!mailValue) {
		 emaillcheckrepeat=false;
		maildiv.innerHTML = "<font color='blue' size='-1'>???????????????...</font>";
		return;
	  }
	  var xhr = new XMLHttpRequest();
	  xhr.open("POST", "<c:url value='/CheckMailRepeat'/>", true);
	  xhr.setRequestHeader("Content-Type",
				"application/x-www-form-urlencoded");
	  xhr.send("email=" + mailValue);
	  var message = "";
	  xhr.onreadystatechange = function() {
	    // ?????????????????????
	    if (xhr.readyState == 4 && xhr.status == 200) {
		   var result = JSON.parse(xhr.responseText);
		   if (result.email.length == 0) {
			  emaillcheckrepeat=true;
			  message = "<font color='green' size='-2'>??????????????????????????????</font>";
		   }else {
			   emaillcheckrepeat=false;
			  message = "<font color='red' size='-2'>????????????????????????????????????</font>"; 
		   }
		   maildiv.innerHTML = message;
	    }
   }
 }
 
 
function checkbankrepeat() {
	var bankdiv = document.getElementById('resultbank');

	  var bankValue = document.getElementById("account_no").value;
	  if (!bankValue) {
		  bankcheckrepeat=false
		 bankdiv.innerHTML = "<font color='blue' size='-1'>?????????????????????...</font>";
		return;
	  }
	  var xhr = new XMLHttpRequest();
	  xhr.open("POST", "<c:url value='/CheckBankRepeat'/>", true);
	  xhr.setRequestHeader("Content-Type",
				"application/x-www-form-urlencoded");
	  xhr.send("account_no=" + bankValue);
	  var message = "";
	  xhr.onreadystatechange = function() {
	    // ?????????????????????
	    if (xhr.readyState == 4 && xhr.status == 200) {
		   var result = JSON.parse(xhr.responseText);
		   if (result== true) {
			  bankcheckrepeat=true;
			  finalcheck();
			  message = "<font color='green' size='-2'>?????????????????????</font>";
		   }else {
			  bankcheckrepeat=false
			  message = "<font color='red' size='-2'>????????????????????????</font>"; 
		   }
		   bankdiv.innerHTML = message;
	    }
   }
 }


window.onload = function() {


	document.getElementById("accountCheckBtn").addEventListener("click", checkacrepeat);
	document.getElementById("emailCheckBtn").addEventListener("click", checkmailrepeat);
	document.getElementById("bankCheckBtn").addEventListener("click", checkbankrepeat);
	
	
	
	
}




</script>


</head>
<body>
	<jsp:include page="../../layout/Navbar.jsp"></jsp:include>
	<div class="loginbody">
		<h2 class="logingh2">????????????</h2>
		<form action="registerAccount" method="post"
			enctype="multipart/form-data">

			<div class="logincontainer" id="logincontainer">

				<div class="form-logincontainer sign-in-container loginform">

					<h1 class="logingh1">Sign up</h1>
					<br>
					<div class="NameSb" >
						<span id="acHelp"></span> <input type="text" name="account"
							placeholder="??????:" id="account" /> <label
							style="color: gray; font-size: 10px; text-align: left;">(??????6??????????????????????????????)
						</label><a href='#' id='accountCheckBtn' style='font-size: 10pt;color:orange;'>????????????</a>
						<div id='resultAcc' style="height: 10px;"></div>
						<br>
					</div><br>
					

					<div class="NameSb">
						<span id="pwHelp"></span> <input type="password" name="password"
							placeholder="??????:" id="password" /> <label
							style="color: gray; font-size: 10px; text-align: left;">(??????6?????????????????????????????????????????????[!@#$%^&*])
						</label><br>
					</div>



					<div class="NameSb">
						<span id="nameHelp"></span> <input type="text" name="name"
							placeholder="??????:" id="name" /> <label
							style="color: gray; font-size: 10px; text-align: left;">(????????????????????????????????????????????????)
						</label><br>
					</div>

					<div class="NameSb">
						<span id="mailHelp"></span> <input type="text" name="email"
							placeholder="??????:" id="email" /> <a href='#' id='emailCheckBtn' style='font-size: 10pt;color:orange;'>????????????</a><br>
					<div id='resultEmail' style="height: 10px;"></div>
					</div>

					<div class="NameSb">
					<span id="phoneHelp"></span> 
						<input type="text" name="phone" placeholder="??????:" id="phone" /><br>
					</div>





				</div>
				<div class="overlay-logincontainer">
					<div class="loginoverlay">

						<div class="overlay-panel overlay-right">
							<div class="NameSb2">
								<label style="text-align: left; color: white; width: 98%;">??????:
									<input type="date" name="birth" placeholder="??????:" id="birth" />
									<span id="birthHelp"></span> 
								</label><br>
							</div>


							<div class="NameSb2">
								<label style="text-align: left; color: white;">????????????:<br>
									<input value="808" readonly="readonly" style="width: 20%">
									<input type="text" name="account_no" style="width: 79%"
									placeholder="????????????:" id="account_no" />
									<span id="bankHelp"></span> 
								</label><a href='#' id='bankCheckBtn' style='font-size: 10pt;color:white;'>??????????????????</a><br>
							<div id='resultbank' style="height: 10px;"></div>
							</div>


							<div class="NameSb2">
								<label style="text-align: left; color: white;">????????????: <input
									type="file" style="background-color: transparent;" id="file"
									accept="image/*" name="image" id="image" />
									<span id="imageHelp"></span> 
								</label> <br>
							</div>
			
							<input type="Submit" class="signupbutton" value="??????"
								id="idsubmit">	
								<br>		
									<a  onclick="inputValue()" class="signupbutton" id="preset">????????????????????????</a>				
						</div>
					</div>
				</div>
			</div>
		</form>
		
	</div>
<jsp:include page="../../layout/footer.jsp"></jsp:include>
	<script>
		let nameflag, acflag, pwdflag, mailflag ,phoneflag ,birthflag ,bankflag= false;

		document.getElementById("account").addEventListener("blur", function() {

			let acId = document.getElementById("account");
			let acVal = acId.value;
			let acLen = acVal.length;
			let acsp = document.getElementById("acHelp");
			let acCh, flag1 = false, flag2 = false;

			if (acVal == "") {
				acsp.innerHTML = "???????????????";
				document.getElementById("acHelp").style.color = "red";
				acflag = false;

			} else if (acLen >= 6) {
				for (let k = 0; k < acLen; k++) {
					let acCh = acVal.charAt(k).toUpperCase();
					if (acCh >= "A" && acCh <= "Z")
						flag1 = true;
					else if (acCh >= "0" && acCh <= "9")
						flag2 = true;
					if (flag1 && flag2)
						break;

				}
				if (flag1 && flag2) {
					acsp.innerHTML = "  ??????";
					document.getElementById("acHelp").style.color = "green";
					acflag = true;

				} else if (flag1) {
					acsp.innerHTML = " ???????????????";
					document.getElementById("acHelp").style.color = "red";
					acflag = false;

				} else if (flag2) {
					acsp.innerHTML = "  ?????????????????????";
					document.getElementById("acHelp").style.color = "red";
					acflag = false;

				} else {
					acsp.innerHTML = "  ??????????????????????????????";
					document.getElementById("acHelp").style.color = "red";
					acflag = false;

				}
			} else {
				acsp.innerHTML = "  ?????????6??????";
				document.getElementById("acHelp").style.color = "red";
				acflag = false;

			}
		})
		document.getElementById("account").addEventListener("blur", finalcheck);
		document.getElementById("account").addEventListener("blur", checkacrepeat);
		document.getElementById("account").addEventListener("blur", checkmailrepeat);
		document.getElementById("account").addEventListener("blur", checkbankrepeat);


		
		
		

		document.getElementById("password").addEventListener("blur",function() {

							let pwId = document.getElementById("password");
							let pwVal = pwId.value;
							let pwLen = pwVal.length;
							let pwsp = document.getElementById("pwHelp");
							let pwCh, flag1 = false, flag2 = false, flag3 = false;
							let pwre = new RegExp(/[!@#$%^&*]/);

							if (pwVal == "") {
								pwsp.innerHTML = "???????????????";
								document.getElementById("pwHelp").style.color = "red";
								pwdflag = false;

							} else if (pwLen >= 6) {
								for (let k = 0; k < pwLen; k++) {
									let pwCh = pwVal.charAt(k).toUpperCase();
									if (pwCh >= "A" && pwCh <= "Z")
										flag1 = true;
									else if (pwCh >= "0" && pwCh <= "9")
										flag2 = true;
									else if (pwre.test(pwVal))
										flag3 = true;
									if (flag1 && flag2 && flag3)
										break;

								}
								if (flag1 && flag2 && flag3) {
									pwsp.innerHTML = "  ??????";
									document.getElementById("pwHelp").style.color = "green";
									console.log("success!!!!!!")
									pwdflag = true;
								} else if (flag1 && flag2) {
									pwsp.innerHTML = "?????????????????????";
									document.getElementById("pwHelp").style.color = "red"
									pwdflag = false;

								} else if (flag2 && flag3) {
									pwsp.innerHTML = "  ?????????????????????";
									document.getElementById("pwHelp").style.color = "red"
									pwdflag = false;

								} else if (flag1 && flag3) {
									pwsp.innerHTML = "  ???????????????";
									document.getElementById("pwHelp").style.color = "red"
									pwdflag = false;

								} else if (flag1) {
									pwsp.innerHTML = "  ??????????????????????????????";
									document.getElementById("pwHelp").style.color = "red";
									pwdflag = false;

								} else if (flag2) {
									pwsp.innerHTML = "  ????????????????????????????????????";
									document.getElementById("pwHelp").style.color = "red";
									pwdflag = false;

								} else {
									pwsp.innerHTML = "??????????????????????????????";
									document.getElementById("pwHelp").style.color = "red";
									pwdflag = false;

								}
							} else {
								pwsp.innerHTML = "  ?????????6??????";
								document.getElementById("pwHelp").style.color = "red";
								pwdflag = false;

							}
						})
		document.getElementById("password").addEventListener("blur", finalcheck);
			document.getElementById("password").addEventListener("blur", checkacrepeat);
		document.getElementById("password").addEventListener("blur", checkmailrepeat);
		document.getElementById("password").addEventListener("blur", checkbankrepeat);
		
		
		

		document.getElementById("name").addEventListener("blur",function() {
							let name = document.getElementById("name");
							let nameVal = name.value;
							let nameLen = nameVal.length;
							let namespn = document.getElementById("nameHelp");
							let namere = new RegExp(/^[\u4e00-\u9fa5]+$/);
							if (nameVal == "") {
								namespn.innerHTML = "  ???????????????";
								document.getElementById("nameHelp").style.color = "red";
								nameflag = false;

							} else {
								if (nameLen < 2) {
									namespn.innerHTML = "  ???????????????";
									document.getElementById("nameHelp").style.color = "red"
									nameflag = false;

								} else {
									if (namere.test(nameVal)) {
										namespn.innerHTML = "  ??????";
										document.getElementById("nameHelp").style.color = "green";
										nameflag = true;

									} else {
										namespn.innerHTML = "  ???????????????";
										document.getElementById("nameHelp").style.color = "red"
										nameflag = false;
									}
								}
							}
						})

		document.getElementById("name").addEventListener("blur", finalcheck);
		document.getElementById("name").addEventListener("blur", checkacrepeat);
		document.getElementById("name").addEventListener("blur", checkmailrepeat);
		document.getElementById("name").addEventListener("blur", checkbankrepeat);
		
		
		

		document.getElementById("email").addEventListener("blur",function() {
							let mailId = document.getElementById("email");
							let mailVal = mailId.value;
							let mailLen = mailVal.length;
							let mailsp = document.getElementById("mailHelp");
							let mailre = new RegExp(/^([a-zA-Z0-9_\.\-\+])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/);

							if (mailVal == "") {
								mailsp.innerHTML = "???????????????";
								document.getElementById("mailHelp").style.color = "red";
								mailflag = false;
							} else {
								for (let k = 0; k < mailLen; k++) {
									let mailCh = mailVal.charAt(k).toUpperCase();
									if (mailre.test(mailVal)) {
										mailsp.innerHTML = " ??????";
										document.getElementById("mailHelp").style.color = "green";
										mailflag = true;
									}

									else {
										mailsp.innerHTML = "??????????????????????????????";
										document.getElementById("mailHelp").style.color = "red";
										mailflag = false;
									}
								}

							}

						})
		document.getElementById("email").addEventListener("blur", finalcheck);
		document.getElementById("email").addEventListener("blur", checkacrepeat);
		document.getElementById("email").addEventListener("blur", checkmailrepeat);
		document.getElementById("email").addEventListener("blur", checkbankrepeat);

		
		
		
		document.getElementById("phone").addEventListener("blur",function() {
							let phone = document.getElementById("phone");
							let phoneVal = phone.value;
							let phoneLen = phoneVal.length;
							let phonespn = document.getElementById("phoneHelp");
							let phonere = new RegExp("^09\\d{8}$");
							if (phoneVal == "") {
								phonespn.innerHTML = "?????????????????????";
								document.getElementById("phoneHelp").style.color = "red";
								phoneflag = false;

							} else {
								console.log(phoneVal);
								if (phonere.test(phoneVal)) {
									phonespn.innerHTML = "??????";
									document.getElementById("phoneHelp").style.color = "green"
									phoneflag = true;

								} else {
									phonespn.innerHTML = "??????????????????????????????";
									document.getElementById("phoneHelp").style.color = "red"
									phoneflag = false;
								}
							}
						})

		document.getElementById("phone").addEventListener("blur", finalcheck);
		document.getElementById("phone").addEventListener("blur", checkacrepeat);
		document.getElementById("phone").addEventListener("blur", checkmailrepeat);
		document.getElementById("phone").addEventListener("blur", checkbankrepeat);
		
		
		
		document.getElementById("birth").addEventListener("blur",function() {
							let birth = document.getElementById("birth");
							let birthVal = birth.value;
							let birthLen = birthVal.length;
							let birthspn = document.getElementById("birthHelp");
							let birthre = new RegExp(/^[\u4e00-\u9fa5]+$/);
							if (birthVal == "") {
								birthspn.innerHTML = "  ???????????????";
								document.getElementById("birthHelp").style.color = "red";
								birthflag = false;

							} else {
								console.log(birthVal);
								birthspn.innerHTML = "??????";
								document.getElementById("birthHelp").style.color = "green";
								birthflag = true;
							}
						})

		document.getElementById("birth").addEventListener("blur", finalcheck);
		document.getElementById("birth").addEventListener("blur", checkacrepeat);
		document.getElementById("birth").addEventListener("blur", checkmailrepeat);
		document.getElementById("birth").addEventListener("blur", checkbankrepeat);
		
		
		
			document.getElementById("account_no").addEventListener("blur",function() {
							let bank = document.getElementById("account_no");
							let bankVal = bank.value;
							let bankLen = bankVal.length;
							let bankspn = document.getElementById("bankHelp");
							let bankre = new RegExp(/^[\u4e00-\u9fa5]+$/);
							
							if (bankVal == "") {
								bankspn.innerHTML = "?????????????????????????????????";
								document.getElementById("bankHelp").style.color = "red";
								bankflag = false;

							} else {
									bankspn.innerHTML = "??????";
									document.getElementById("bankHelp").style.color = "green"
									bankflag = true;

								} 
							
						})

		document.getElementById("account_no").addEventListener("blur", finalcheck);
		document.getElementById("account_no").addEventListener("blur", checkacrepeat);
		document.getElementById("account_no").addEventListener("blur", checkmailrepeat);
		document.getElementById("account_no").addEventListener("blur", checkbankrepeat);
		
		
		
		
		
		
		
		
		

		

		function inputValue(){
			document.getElementById("account").value="EEIT151";
			document.getElementById("password").value="EEIT151!";
			document.getElementById("name").value="?????????";
			document.getElementById("email").value="eeit15119@outlook.com";			
			document.getElementById("phone").value="0972324316";
			document.getElementById("birth").value="1979-07-24";
			document.getElementById("account_no").value="1511314520";
		}
		
		
		
		
		
		
		function finalcheck() {
			if (nameflag && acflag && pwdflag && mailflag && phoneflag && birthflag && bankflag && accheckrepeat && emaillcheckrepeat && bankcheckrepeat) {
				console.log(nameflag+','+acflag+','+pwdflag+','+mailflag+','+phoneflag+','+birthflag+','+bankflag+','+accheckrepeat+','+emaillcheckrepeat+','+bankcheckrepeat)
				document.getElementById("idsubmit").removeAttribute("disabled")
			} else {
				console.log(nameflag+','+acflag+','+pwdflag+','+mailflag+','+phoneflag+','+birthflag+','+bankflag+','+accheckrepeat+','+emaillcheckrepeat+','+bankcheckrepeat)
				document.getElementById("idsubmit").setAttribute("disabled","true");
			}
		}
		
		
	</script>


</body>
</html>