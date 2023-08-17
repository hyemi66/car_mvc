<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>차량 예약</title>
</head>
<body>
    <h2>차량 예약</h2>
    <form method="post">
        <input type="hidden" name="m_id" id="m_id" value="${loggedInUser.m_id}" required><br>
        
        <label for="car_id">차량 고유번호:</label>
        <input type="number" name="car_id" id="car_id" required><br>
        
        <label for="rental_date_time">빌린 날짜 및 시간:</label>
        <input type="datetime-local" name="rental_date_time" id="rental_date_time" required><br>
        
        <label for="return_date_time">반납 날짜 및 시간:</label>
        <input type="datetime-local" name="return_date_time" id="return_date_time" required><br>
        
        
        <input type="submit" value="예약하기">
    </form>
</body>
</html>
