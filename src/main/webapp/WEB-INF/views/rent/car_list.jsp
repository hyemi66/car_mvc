<!-- car_list.jsp -->
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>차량 렌탈</title>
</head>
<body>
    <h2>차량 목록</h2>
    <table border="1">
        <tr>
            <th>차량 ID</th>
            <th>차량명</th>
            <th>브랜드</th>
            <th>연식</th>
            <th>색상</th>
            <th>가격</th>
            <th>예약 가능 여부</th>
            <th>예약</th>
        </tr>
        <c:forEach var="car" items="${cars}">
            <tr>
                <td>${car.carId}</td>
                <td>${car.carName}</td>
                <td>${car.carBrand}</td>
                <td>${car.carYear}</td>
                <td>${car.carColor}</td>
                <td>${car.carPrice}</td>
                <td>${car.carAvailability == 1 ? "예약 가능" : "예약 불가능"}</td>
                <td>
                    <c:if test="${car.carAvailability == 1}">
                        <form action="CarRentalServlet" method="post">
                            <input type="hidden" name="action" value="rent">
                            <input type="hidden" name="userId" value="user1"> <!-- 예약자 ID 설정 -->
                            <input type="hidden" name="carId" value="${car.carId}">
                            <input type="submit" value="예약">
                        </form>
                    </c:if>
                </td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>
