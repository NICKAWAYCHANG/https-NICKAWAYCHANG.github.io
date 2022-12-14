<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
		<c:set var="contextRoot" value="${pageContext.request.contextPath}" />

		<!DOCTYPE html>
		<html>

		<head>
			<script src="https://code.jquery.com/jquery-3.6.1.js"
				integrity="sha256-3zlB5s2uwoUzrXK3BT7AX3FyvojsraNFxCc2vC/7pNI=" crossorigin="anonymous"></script>
			<meta charset="UTF-8">
			<title>Check and Edit Member</title>
			<style>
				/* ul { */
				/* 	list-style: none; */
				/* 	height: 25px; */
				/* 	overflow: hidden; */
				/* } */
			</style>
		</head>

		<body>
			<jsp:include page="../../layout/BackNavbar.jsp"></jsp:include>
			<script type="text/javaScript">
		var fileDataURL = null;
		var inputFileToLoad = null;
		var submit = null
		var div1 = null

		window.onload = function() {

			// 			submit.addEventListener('click', click);
			div1 = document.getElementById("div1");
			inputFileToLoad = document.getElementById("inputFileToLoad");
			inputFileToLoad.addEventListener('change', loadImageFileAsURL);

			document.getElementById("password").addEventListener("blur",
					checkPassword);

			document.getElementById("EmployeeName").addEventListener("blur",
					checkName);

			document.getElementById("EmployeeNo").addEventListener("blur",
					checkNo);

			document.getElementById("Arrived").addEventListener("blur",
					checkArrived);

			document.getElementById("Email").addEventListener("blur",
					checkEmail);

			document.getElementById("Phone").addEventListener("blur",
					checkPhone);

			getindex()

			// 			setInterval(function() {
			// 				$("#news li:first-child").slideUp(function() {
			// 					$(this).appendTo($('#news')).slideDown()
			// 				})
			// 			}, 3000)

			$("#edit").click(function() {
				if ($("#password").val() == "") {
					alert("您尚未填寫密碼");
					var password = document.getElementById("password");
					password.focus();
				} else if ($("#EmployeeName").val() == "") {
					alert("您尚未填寫員工姓名");
					var EmployeeName = document.getElementById("EmployeeName");
					EmployeeName.focus();
				} else if ($("#EmployeeNo").val() == "") {
					alert("您尚未填寫員工編號");
					var EmployeeNo = document.getElementById("EmployeeNo");
					EmployeeNo.focus();
				} else if ($("#Arrived").val() == "") {
					alert("您尚未填寫員工到職日");
					var Arrived = document.getElementById("Arrived");
					Arrived.focus();
				} else if ($("#Email").val() == "") {
					alert("您尚未填寫員工信箱");
					var Email = document.getElementById("Email");
					Email.focus();
				} else if ($("#Phone").val() == "") {
					alert("您尚未填寫員工電話");
					var Phone = document.getElementById("Phone");
					Phone.focus();
				} 

			})

		}

		function getindex() {
			var url = "<c:url value='/frontned/edit/EmployeeByEmployee'/>"
			var obj = {
				'account' : {

					'id' : 1

				}
			}
			var json = JSON.stringify(obj);
			var imageurl = "data:image/jpeg;base64,"

			$
					.ajax({
						url : url,
						method : 'post',
						data : json,
						contentType : 'application/json;charset=UTF-8',
						dataType : 'json',
						error : function() {
							alert("ajax error")
						},
						success : function(data) {
							
							console.log(data)
							var arrived = data.employee.arrived_at
									.substr(0, 10).split('/').join('-')
							$("#exampleInputName1").attr("value",
									data.account.account);
							
							$("#password").attr("value", data.account.password);
							$("#EmployeeName").attr("value",
									data.employee.name);
							$("#EmployeeNo").attr("value",
									data.employee.employee_no);
							$("#Arrived").attr("value", arrived);
							$("#Email").attr("value",
									data.employee.email);
							$("#Phone").attr("value",
									data.employee.phone);
									
							if (data.employee.image) {
								$("#preview_img").attr("src", imageurl + data.employee.image)
							}
							else{
								$("#preview_img").attr("src", "${contextRoot}/img2/nopicture.jpg")
							}
							$("#welcome").text(data.employee.name);

						}

					})
		}
		
		//**********完成編輯前做確認***********
		function checkedit(){
			Swal.fire({
				icon: 'question',
				title:'確定完成送出?',
			    color: "#7373b9",
			    showCancelButton: true,
			    cancelButtonText:"取消",
			    cancelButtonColor: "#FF0000",
			    confirmButtonText: '確定',
			    confirmButtonColor: "#0000e3"
			}).then((result) => {
			    if (result.isConfirmed) {
			    	Swal.fire('編輯成功', '', 'success').then((result) => {
			    	edit();
	 		    	window.location.reload()
			    	})
			    } 
			})  
			
		
	}
		
		//***********執行編輯*********
		function edit() {
			var password = document.getElementById("password").value
			var EmployeeName = document.getElementById("EmployeeName").value;
			var EmployeeNo = document.getElementById("EmployeeNo").value;
			var Arrived = document.getElementById("Arrived").value;
			var Email = document.getElementById("Email").value;
			var Phone = document.getElementById("Phone").value;

			var url = "<c:url value='/edit/employeeDetail' />"
			var object = {
				'account' : {
					'password' : password
				},
				'employee' : {
					'name' : EmployeeName,
					'email' : Email,
					'phone' : Phone,
					'employee_no' : EmployeeNo,
					'arrived_at' : Arrived
				},
				'image' : fileDataURL
			};
			var json = JSON.stringify(object);
			console.log(json)
			$.ajax({
				url : url,
				method : 'post',
				data : json,
				contentType : 'application/json;charset=UTF-8',
				dataType : 'json',
				error : function() {
					Swal.fire('編輯失敗', '', 'error')
				},
				success : function(data) {
					Swal.fire('編輯成功', '', 'success')
				}
			});

		}

		//************照片載入***************
		function loadImageFileAsURL() {
			let filesSelected = document.getElementById("inputFileToLoad").files;
			if (filesSelected.length > 0) {
				let fileToLoad = filesSelected[0];

				let fileReader = new FileReader();

				fileReader.onload = function(fileLoadedEvent) {
					fileDataURL = fileLoadedEvent.target.result;

				};

				fileReader.readAsDataURL(fileToLoad);
			}
		}

		//************確認員工密碼*************
		function checkPassword() {
			  let c1 = false; let c2 = false; c3 = false;
              let ThePwdObjVal = document.getElementById("password").value;
              let showpwd = document.getElementById("idsp1");
          		let v = document.querySelector("#password");
              let pwdvallength = ThePwdObjVal.length;
              if (ThePwdObjVal != "") {
                  if (pwdvallength >= 6) {
                      for (let i = 0; i < pwdvallength; i++) {
                          let ch = ThePwdObjVal.charAt(i).toUpperCase();
                          if (ch == "\u0021" || ch == "\u0040" || ch == "\u0023" || ch == "\u0022" || ch == "\u0024" || ch == "\u0025" || ch == "\u005e" || ch == "\u0026" || ch == "\u002a") {
                              c1 = true;
                          }
                          if ((ch >= "A" && ch <= "Z")) {
                              c2 = true;
                          }
                          if ((ch >= "0" && ch <= "9")) {
                              c3 = true
                          }
                          if (c1 == true && c2 == true && c3 == true) {
                              break;
                          }
                      }
                      if (c1 == true && c2 == true && c3 == true) {
                    		v.classList.remove("is-invalid");
							v.classList.add("is-valid");
                    	  showpwd.innerHTML = ("輸入正確");
                    	  showpwd.style = "color:green;font-size:14px";
                      } else {
                      	v.classList.remove("is-valid");
						v.classList.add("is-invalid");
                	  showpwd.innerHTML = ("密碼至少包含一個特殊符號、數字、英文");
                	  showpwd.style = "color:red;font-size:14px";
                      }
                  } else {
                	  	v.classList.remove("is-valid");
						v.classList.add("is-invalid");
              	  showpwd.innerHTML = ("密碼最少六位數");
              	  showpwd.style = "color:red;font-size:14px";
                  }
              } else {
            	  	v.classList.remove("is-valid");
					v.classList.add("is-invalid");
            	  showpwd.innerHTML = ("不可輸入空值");
            	  showpwd.style = "color:red;font-size:14px";
              }
			
			
			if ($("#password").val() == "" || $("#EmployeeName").val() == ""
					|| $("#EmployeeNo").val() == ""
					|| $("#Arrived").val() == "" || $("#Email").val() == ""
					|| $("#Phone").val() == "") {
				$("#edit").prop("disabled", true)
			} else {
				$("#edit").prop("disabled", false)
			}
		}

		//*********確認員工名字***********
		function checkName() {
			let StrObj = document.getElementById("EmployeeName");
			let showname = document.getElementById("idsp2");
			let v = document.querySelector("#EmployeeName");
			StrObjname = StrObj.value;
			if (StrObjname.charAt(0) != "") {
				if (StrObjname.charAt(1) != "") {
					for (let i = 0; i < StrObjname.length; i++) {
						let ch = StrObjname.charCodeAt(i);
						if (ch >= 0x4e00 && ch <= 0x9fff) {
							v.classList.remove("is-invalid");
							v.classList.add("is-valid");
							showname.innerHTML = ("輸入正確")
							showname.style = "color:green;font-size:14px";
						} else {
							v.classList.remove("is-invalid");
							v.classList.add("is-valid");
							showname.innerHTML = ("建議輸入中文")
							showname.style = "color:green;font-size:14px";
							break;
						}
					}
				} else {
					showname.innerHTML = ("至少兩個字以上");
					v.classList.remove("is-valid");
					v.classList.add("is-invalid");
					showname.style = "color:red;font-size:14px";

				}
			} else {
				showname.innerHTML = ("不可輸入空值");
				v.classList.remove("is-valid");
				v.classList.add("is-invalid");
				showname.style = "color:red;font-size:14px";

			}

			if ($("#password").val() == "" || $("#EmployeeName").val() == ""
					|| $("#EmployeeNo").val() == ""
					|| $("#Arrived").val() == "" || $("#Email").val() == ""
					|| $("#Phone").val() == "") {
				$("#edit").prop("disabled", true)
			} else {
				$("#edit").prop("disabled", false)
			}
		}

		//************確認員工編號*************
		function checkNo() {
			let StrObj = document.getElementById("EmployeeNo");
			let showNo = document.getElementById("idsp3");
			let v = document.querySelector("#EmployeeNo");
			StrObjname = StrObj.value;
			if (StrObjname.charAt(0) != "") {

				showNo.innerHTML = ("輸入正確");
				v.classList.remove("is-invalid");
				v.classList.add("is-valid");
				showNo.style = "color:green;font-size:14px";

			} else {
				showNo.innerHTML = ("不可輸入空值");
				v.classList.remove("is-valid");
				v.classList.add("is-invalid");
				showNo.style = "color:red;font-size:14px";

			}
			if ($("#password").val() == "" || $("#EmployeeName").val() == ""
					|| $("#EmployeeNo").val() == ""
					|| $("#Arrived").val() == "" || $("#Email").val() == ""
					|| $("#Phone").val() == "") {
				$("#edit").prop("disabled", true)
			} else {
				$("#edit").prop("disabled", false)
			}
		}

		//************確認到職日*************
		function checkArrived() {
			let StrObj = document.getElementById("Arrived");
			let showarrived = document.getElementById("idsp4");
			let v = document.querySelector("#Arrived");
			StrObjname = StrObj.value;
			if (StrObjname.charAt(0) != "") {

				showarrived.innerHTML = ("輸入正確");
				v.classList.remove("is-invalid");
				v.classList.add("is-valid");
				showarrived.style = "color:green;font-size:14px";

			} else {
				showarrived.innerHTML = ("不可輸入空值");
				v.classList.remove("is-valid");
				v.classList.add("is-invalid");
				showarrived.style = "color:red;font-size:14px";

			}
			if ($("#password").val() == "" || $("#EmployeeName").val() == ""
					|| $("#EmployeeNo").val() == ""
					|| $("#Arrived").val() == "" || $("#Email").val() == ""
					|| $("#Phone").val() == "") {
				$("#edit").prop("disabled", true)
			} else {
				$("#edit").prop("disabled", false)
			}
		}

		//************確認信箱*************
		function checkEmail() {
			let StrObj = document.getElementById("Email");
			let showemail = document.getElementById("idsp5");
			let v = document.querySelector("#Email");
			StrObjname = StrObj.value;
			if (StrObjname.charAt(0) != "") {

				showemail.innerHTML = ("輸入正確");
				v.classList.remove("is-invalid");
				v.classList.add("is-valid");
				showemail.style = "color:green;font-size:14px";

			} else {
				showemail.innerHTML = ("不可輸入空值");
				v.classList.remove("is-valid");
				v.classList.add("is-invalid");
				showemail.style = "color:red;font-size:14px";

			}
			if ($("#password").val() == "" || $("#EmployeeName").val() == ""
					|| $("#EmployeeNo").val() == ""
					|| $("#Arrived").val() == "" || $("#Email").val() == ""
					|| $("#Phone").val() == "") {
				$("#edit").prop("disabled", true)
			} else {
				$("#edit").prop("disabled", false)
			}
		}

		//************確認電話*************
		function checkPhone() {
			let StrObj = document.getElementById("Phone");
			let showphone = document.getElementById("idsp6");
			let v = document.querySelector("#Phone");
			StrObjname = StrObj.value;
			if (StrObjname.charAt(0) != "") {

				showphone.innerHTML = ("輸入正確");
				v.classList.remove("is-invalid");
				v.classList.add("is-valid");
				showphone.style = "color:green;font-size:14px";

			} else {
				showphone.innerHTML = ("不可輸入空值");
				v.classList.remove("is-valid");
				v.classList.add("is-invalid");
				showphone.style = "color:red;font-size:14px";

			}
			if ($("#password").val() == "" || $("#EmployeeName").val() == ""
					|| $("#EmployeeNo").val() == ""
					|| $("#Arrived").val() == "" || $("#Email").val() == ""
					|| $("#Phone").val() == "") {
				$("#edit").prop("disabled", true)
			} else {
				$("#edit").prop("disabled", false)
			}
		}
	</script>

			<br>
			<br>
			<br>
			<br>



			<div class="col-12 grid-margin stretch-card shadow p-3 mb-5 bg-body rounded"
				style="height: 700px; width: 600px; margin-left: 250px; float: left;">
				<div class="card" style="border-radius: 30px 30px 30px 30px;">
					<div class="card-body" style="height: 600px; margin-top: 40px">
						<h3 class="card-title">員工個人資料編輯</h3>

						<form class="forms-sample" id="form">
							<div class="form-group">
								<label for="exampleInputName1">Account</label> <input type="text" class="form-control"
									style="color: #7b7b7b; background-color: #f0f0f0" id="exampleInputName1"
									placeholder="Name" value="" readonly style="backround-color:grey">
							</div>
							<div class="form-group">
								<div style="text-align: right; margin-right: 440px; margin-bottom: -22px">
									<i class="show_pass fa-solid fa-eye-slash" id="icon"></i>
								</div>
								<label for="exampleInputEmail3">Password</label><input type="password"
									class="form-control" id="password" placeholder="password" value="" />
								<div id="idsp1" style="font-size: 20px"></div>

							</div>
							<div class="form-group">
								<label for="exampleInputPassword4">EmployeeName</label> <input type="text"
									class="form-control" id="EmployeeName" name="username" placeholder="username"
									value="">
								<div id="idsp2" style="font-size: 20px"></div>
							</div>

							<div class="form-group">
								<label for="exampleInputCity1">EmployeeNo</label> <input type="text"
									class="form-control" id="EmployeeNo" placeholder="birth" value="">
								<div id="idsp3" style="font-size: 20px"></div>
							</div>

							<div class="form-group">
								<label for="exampleInputCity1">Arrived</label> <input type="date" class="form-control"
									id="Arrived" placeholder="email" value="">
								<div id="idsp4" style="font-size: 20px"></div>
							</div>


							<div class="form-group">
								<label for="exampleInputCity1">Email</label> <input type="email" class="form-control"
									id="Email" placeholder="email" value="">
								<div id="idsp5" style="font-size: 20px"></div>
							</div>

							<div class="form-group">
								<label for="exampleInputCity1">Phone</label> <input type="text" class="form-control"
									id="Phone" placeholder="phone" value="">
								<div id="idsp6" style="font-size: 20px"></div>
							</div>

							<div class="form-group" style="margin-top: 20px">
								<label>Please select a photo</label><br> <input id="inputFileToLoad" type="file"
									name="photo" onchange="loadImageFileAsURL()" class="file-upload-default">


							</div>

						</form>
					</div>
				</div>
			</div>
			<div style="text-align: center">
				<img id="preview_img" src="#"
					style="height: 400px; width: 400px; border-radius: 190px 190px 190px 190px;">

				<br> <br> <br>
				<h2>
					歡迎您登入編輯頁面 : <span id="welcome"></span>
				</h2>
				<br>
				<!-- 		<ul id="news"> -->
				<!-- 			<li style="color: red">小編貼心提醒您~~~</li> -->
				<!-- 			<li style="color: red">現在參加簽到活動免費贈送紅利點數</li> -->
				<!-- 			<li style="color: red">還不趕快透過上方連結簽到 ?</li> -->
				<!-- 		</ul> -->

				<br> <br>
				<div style="justify-content: center;">
					<input type="button" id="edit" class="btn btn-primary me-2" value="確認送出" display="none"
						onclick="checkedit()">
					<button class="btn btn-danger" style="margin-left: 20px"
						onclick="window.location.reload()">取消編輯</button>
				</div>



				<!-- 							<button id="edit" type="button">Submit</button>  -->
				<!-- <div> -->
				<!-- 		<table> -->

				<!-- 			<tr height='36'> -->
				<!-- 				<td width='120' align='right'>會員密碼：</td> -->
				<!-- 				<td><input id='password' type="text" name="password" size="10"></td> -->
				<!-- 			</tr> -->
				<!-- 			<tr height='36'> -->
				<!-- 				<td width='120' align='right'>會員姓名：</td> -->
				<!-- 				<td><input id='username' type="text" name="username" size="20"></td> -->
				<!-- 			</tr> -->
				<!-- 			<tr height='36'> -->
				<!-- 				<td width='120' align='right'>會員生日：</td> -->
				<!-- 				<td><input id='birth' type="text" name="birth" size="20"></td> -->
				<!-- 			</tr> -->
				<!-- 			<tr height='36'> -->
				<!-- 				<td width='120' align='right'>會員郵件：</td> -->
				<!-- 				<td><input id='email' type="text" name="email" size="20"></td> -->
				<!-- 			</tr> -->
				<!-- 			<tr height='36'> -->
				<!-- 				<td width='120' align='right'>會員電話：</td> -->
				<!-- 				<td><input id='phone' type="text" name="phone" size="20"></td> -->
				<!-- 			</tr> -->
				<!-- 			<tr height='36'> -->
				<!-- 				<td width='120' align='right'>圖片名稱：</td> -->
				<!-- 				<td><input id='photoName' type="text" name="photoName" -->
				<!-- 					size="20"></td> -->
				<!-- 				<td><input id="inputFileToLoad" type="file" name="file" -->
				<!-- 					onchange="loadImageFileAsURL()" /> <img id="preview_img2" -->
				<!-- 					src="#" style="height: 100px; width: 100px"></td> -->
				<!-- 			</tr> -->

				<!-- 		</table> -->
				<!-- 		<input type="button" id="edit" value="編輯會員"> -->
				<!-- 	</div> -->



				<!-- <script src="https://code.jquery.com/jquery-3.6.1.js" integrity="sha256-3zlB5s2uwoUzrXK3BT7AX3FyvojsraNFxCc2vC/7pNI=" crossorigin="anonymous"></script> -->
				<script>
					$("#icon").click(
						function () {
							let pass_type = $("#password").attr("type");
							console.log(pass_type)

							if (pass_type === "password") {
								$("#password").attr("type", "type");
								$("#icon").removeClass("fa-solid fa-eye-slash")
									.addClass("fa-solid fa-eye")
							} else {
								$("#password").attr("type", "password");
								$("#icon").removeClass("fa-solid fa-eye").addClass(
									"fa-solid fa-eye-slash")
							}
						})

					$("#inputFileToLoad").change(function () {
						readURL(this);
					})

					function readURL(input) {
						if (input.files && input.files[0]) {
							var reader = new FileReader();
							reader.onload = function (e) {
								$("#preview_img").attr("src", e.target.result);

							}
							reader.readAsDataURL(input.files[0]);

						}
					}
				</script>
		</body>

		</html>