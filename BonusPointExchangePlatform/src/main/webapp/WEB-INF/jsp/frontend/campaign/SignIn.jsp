<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<meta charset="UTF-8">
<title>SignIn</title>
<style>
        * {
            margin: 0;
            padding: 0
        }
        
        h1{
        margin-left: 10px ;
        }
        
        #btn,#gameSign{
            margin-left: 10px ;
        }

        #calendar {
            width: 270px;
            margin-left: 10px ;
            overflow: hidden;
            border: 1px solid #000;
            padding: 20px;
            position: relative;
            font-family: Arial, Helvetica, sans-serif;
        }

        #calendar h4 {
            text-align: center;
            margin-bottom: 10px
        }

        #calendar .a1 {
            position: absolute;
            top: 20px;
            left: 20px;
        }

        #calendar .a2 {
            position: absolute;
            top: 20px;
            right: 20px;
        }

        #calendar .week {
            height: 30px;
            line-height: 20px;
            border-bottom: 1px solid #000;
            margin-bottom: 10px
        }

        #calendar .week li {
            float: left;
            width: 30px;
            height: 30px;
            text-align: center;
            list-style: none;
        }

        #calendar .dateList {
            overflow: hidden;
            clear: both
        }

        #calendar .dateList li {
            float: left;
            width: 30px;
            height: 30px;
            text-align: center;
            line-height: 30px;
            list-style: none;
        }

        #calendar .dateList .ccc {
            color: #ccc;
        }

        #calendar .dateList .red {
            background: #F90;
            color: #fff;
        }

        #calendar .dateList .sun {
            color: #f00;
        }
        
        #calendar .dateList .sign {
            background-image: url("img2/2.jpg");
            background-repeat: no-repeat;
            background-position: center;
            color: black;
        }
        
        
    </style>
    <script>
        window.onload = function() {  
			btn.onclick = function() {
				$("#calendar").toggleClass("visually-hidden")
				let xhr = new XMLHttpRequest();
				xhr.open('GET', "<c:url value="/selectDate" />", true);
				xhr.send();
				xhr.onreadystatechange = function() {
					if (xhr.readyState == 4 && xhr.status == 200) {
						document.getElementById("calendar").removeAttribute("hidden");
						$(function () {

				            //???????????????
				            //???????????? ??? ??? ?????????????????????????????????????????????????????????
				            var iNow = 0;

				            function run(n) {

				                var oDate = new Date(); //????????????
				                oDate.setMonth(oDate.getMonth() + n);//????????????
				                var year = oDate.getFullYear(); //???
				                var month = oDate.getMonth(); //???
				                var today = oDate.getDate(); //???

				                //????????????????????????
				                var allDay = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31][month];

				                //????????????
				                if (month == 1) {
				                    if (year % 4 == 0 && year % 100 != 0 || year % 400 == 0) {
				                        allDay = 29;
				                    }
				                }

				                //?????????????????????????????????
				                oDate.setDate(1); //??????????????????????????????
				                var week = oDate.getDay(); //?????????????????????????????????

				                //console.log(week);
				                $(".dateList").empty();//????????????
				                //????????????

				                for (var i = 0; i < week; i++) {
				                    $(".dateList").append("<li></li>");
				                }

				                //???????????????dateList
				                for (var i = 1; i <= allDay; i++) {
				                    $(".dateList").append("<li>" + i + "</li>")
				                }
				                //????????????=====================
				                $(".dateList li").each(function (i, elm) {
				                    //console.log(index,elm);
				                    var val = $(this).text();
				                    //console.log(val);
				                    if (n == 0) {
				                        if (val < today) {
				                            if (i % 7 == 0 || i % 7 == 6) {
				                                $(this).addClass('sun')
				                            }
				                            // $(this).addClass('ccc')
				                        } else if (val == today) {
				                            $(this).addClass('red')
				                        } else if (i % 7 == 0 || i % 7 == 6) {
				                            $(this).addClass('sun')
				                        }
				                    } else if (n < 0) {
				                        if (i % 7 == 0 || i % 7 == 6) {
				                            $(this).addClass('sun')
				                        }
				                        // $(this).addClass('ccc')
				                    } else if (i % 7 == 0 || i % 7 == 6) {
				                        $(this).addClass('sun')
				                    }
				                    var list = JSON.parse(xhr.responseText);
									if (list.length > 0) {
										for ( var i in list) {
											var str = list[i]
											var y = parseInt(str.substring(0, 4));
								            var m = parseInt(str.substring(5, 7)) - 1;
								            var d = parseInt(str.substring(8, 10));
								            if (year == y && month == m && val == d) {
						                        $(this).addClass('sign')
						                    }
										}
									}
				                });

				                //??????????????????
				                $("#calendar h4").text(year + "???" + (month + 1) + "???");
				            };
				            run(0);

				            $(".a1").click(function () {
				                iNow--;
				                run(iNow);
				            });

				            $(".a2").click(function () {
				                iNow++;
				                run(iNow);
				            })
				        });
					}
				}
			}
			
			var gameSign = document.getElementById("gameSign")
				gameSign.onclick = function() {
				let xhr2 = new XMLHttpRequest();
				xhr2.open('GET', "<c:url value="/checkSignIn" />", true);
				xhr2.send();
				xhr2.onreadystatechange = function() {
					if (xhr2.readyState == 4 && xhr2.status == 200) {
						let signAlert = JSON.parse(xhr2.responseText);
						if(signAlert.game_type=="???????????????"){
							Swal.fire("??????!",signAlert.game_type, "success")
						}else{
							Swal.fire("??????!",signAlert.game_type, "error")
						}
					}
				}	
			}
			$("#gameBirthGift").click(function(){
				let xhr3 = new XMLHttpRequest();
				xhr3.open('GET', "<c:url value="/checkBirth" />", true);
				xhr3.send();
				xhr3.onreadystatechange = function() {
					if (xhr3.readyState == 4 && xhr3.status == 200) {
						let signAlert2 = JSON.parse(xhr3.responseText);
						if(signAlert2.game_type=="?????????????????????"){
							Swal.fire("??????!",signAlert2.game_type, "success")
						}else if(signAlert2.game_type=="?????????????????????????????????"){
							Swal.fire("??????!",signAlert2.game_type, "error")
						}else{
							Swal.fire("??????!",signAlert2.game_type, "error")
						}
					}
				}
			})
		}
    </script>
</head>
<body>
<jsp:include page="../../layout/Navbar.jsp"></jsp:include>
	<h1>??????</h1>
	<button id="gameSign" class="btn btn-danger">??????</button>
	<button id="gameBirthGift" class="btn btn-danger">?????????</button>
	<button id="btn" class="btn btn-primary">????????????</button>
	<br>
	<div id="dataArea">&nbsp;</div>
	<div id="calendar" class="visually-hidden">
        <h4 style="font-family: Arial, Helvetica, sans-serif;">??????</h4>
        <a href="##"  class="a1">&lt;&lt;</a>
        <a href="##"  class="a2">&gt;&gt;</a>
        <ul class="week">
            <li>???</li>
            <li>???</li>
            <li>???</li>
            <li>???</li>
            <li>???</li>
            <li>???</li>
            <li>???</li>

        </ul>
        <ul class="dateList"></ul>
    </div>
</body>
</html>