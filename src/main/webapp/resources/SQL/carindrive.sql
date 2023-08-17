CREATE SEQUENCE m_seq START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE cars_seq START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE rentals_seq START WITH 1 INCREMENT BY 1 NOCACHE;

--ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
--member 테이블
CREATE TABLE cid_members (
  m_num NUMBER,
  m_id VARCHAR2(30) PRIMARY KEY, --유저 ID
  m_pwd VARCHAR2(30),
  m_name VARCHAR2(30),
  m_phone VARCHAR2(30)
);

-- cars 테이블
CREATE TABLE cid_cars (
  car_id NUMBER PRIMARY KEY,    --차량 고유 코드번호
  car_name varchar2(30),
  car_brand VARCHAR2(30),
  car_year NUMBER,
  car_color VARCHAR2(30),
  car_price NUMBER(10, 2),
  car_availability NUMBER
);

-- cid_rentals 테이블 수정
CREATE TABLE cid_rentals (
  rental_id NUMBER PRIMARY KEY,
  m_id VARCHAR2(30), -- 유저 ID
  car_id NUMBER, -- 차량 고유번호
  reservation_date varchar2(50), -- 렌트 신청일
  rental_date_time varchar2(50) , -- 실제 대여일
  return_date_time varchar2(50), -- 반납 날짜
  rental_cost NUMBER, -- 렌트 가격
  CONSTRAINT fk_m_id FOREIGN KEY (m_id) REFERENCES cid_members(m_id),
  CONSTRAINT fk_car_id FOREIGN KEY (car_id) REFERENCES cid_cars(car_id)
);

-----ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
INSERT INTO cid_rentals (rental_id, m_id, car_id, reservation_date, rental_date, rental_time, return_date, return_time, rental_cost)
	    VALUES (rentals_seq.NEXTVAL, 'zzz', 1, '2023-08-11', '2023-08-12', '14:30', '2023-08-13', '15:30', 7000);

INSERT INTO cid_rentals (rental_id, m_id, car_id, reservation_date, rental_date, rental_time, return_date, return_time, rental_cost)
VALUES (rentals_seq.NEXTVAL, 'zzz', 1, TO_DATE('2023-08-11', 'YYYY-MM-DD'), TO_DATE('2023-08-12', 'YYYY-MM-DD'), TO_DATE('14:30', 'HH24:MI'), TO_DATE('2023-08-13', 'YYYY-MM-DD'), TO_DATE('15:30', 'HH24:MI'), 7000);

INSERT INTO cid_rentals (rental_id, m_id, car_id, reservation_date, rental_date_time, return_date_time, rental_cost)
VALUES (rentals_seq.NEXTVAL, '이상헌', 1, TO_TIMESTAMP('2023-08-11T11:13', 'YYYY-MM-DD"T"HH24:MI'), TO_TIMESTAMP('2023-08-11T15:13', 'YYYY-MM-DD"T"HH24:MI'), TO_TIMESTAMP('2023-08-11T15:13', 'YYYY-MM-DD"T"HH24:MI'), 7000);

INSERT INTO cid_rentals (rental_id, m_id, car_id, reservation_date, rental_date_time, return_date_time, rental_cost)
VALUES (rentals_seq.NEXTVAL, '이상헌', 1, TO_DATE('2023-08-11T15:13', 'YYYY-MM-DD"T"HH24:MI'), TO_DATE(#{rental_date_time}, 'YYYY-MM-DD"T"HH24:MI'), TO_DATE(#{return_date_time}, 'YYYY-MM-DD"T"HH24:MI'), 7000);


commit;
select * from cid_members order by m_num desc;
select * from cid_cars order by car_brand desc;;
select * from cid_rentals order by rental_id desc;

--원상복구
ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MON-RR';
ALTER SESSION SET NLS_TIMESTAMP_FORMAT = 'DD-MON-RR HH.MI.SSXFF AM';



--시간값을 빼고 날짜만 가져오기 (DATE 타입 변경)
alter session set nls_date_format = 'YYYY-MM-DD HH:MI';

--날짜값을 빼고 시간값만 가져오기
SELECT TO_CHAR(rental_time, 'HH24:MI:SS') AS extracted_time FROM cid_rentals;

ALTER SESSION SET NLS_TIMESTAMP_FORMAT = 'HH24:MI';






--날짜와 시간으로 해당 아이디의 가장 최근의 렌트 정보를 가져옴 (결제에 쓸 예정)
SELECT * FROM cid_rentals WHERE m_id = '콩' ORDER BY reservation_date DESC FETCH FIRST 1 ROW ONLY;

-------------------------------------------------------------------------------------
--삭제관련 명령어

-- members 테이블의 외래 키 제약 조건 해제
ALTER TABLE cid_rentals DROP CONSTRAINT fk_m_id;

-- cars 테이블의 외래 키 제약 조건 해제
ALTER TABLE cid_rentals DROP CONSTRAINT fk_car_id;

DROP TABLE cid_members;
DROP TABLE cid_cars;
DROP TABLE cid_rentals;

DROP SEQUENCE m_seq;
DROP SEQUENCE cars_seq;
DROP SEQUENCE rentals_seq;


--렌트목록을 이름과 전화번호로 가져오기

select * from cid_rentals where m_id  = '이순신' and car_id = 1;



-- 기존 제약 조건 삭제
ALTER TABLE cid_rentals DROP CONSTRAINT fk_m_id;
ALTER TABLE cid_rentals DROP CONSTRAINT fk_car_id;

-- 새로운 제약 조건 생성
ALTER TABLE cid_rentals ADD CONSTRAINT fk_m_id FOREIGN KEY (m_id) REFERENCES cid_members(m_id);
ALTER TABLE cid_rentals ADD CONSTRAINT fk_car_id FOREIGN KEY (car_id) REFERENCES cid_cars(car_id);

--------------------------------------------------------------------------------------


delete from cid_members;

select * from cid_members;

-------------------------------------------------------------------------------------
select * from cid_members; --차량 확인
select * from cid_cars; --차량 확인
select * from cid_rentals; --차량 확인

select * from cid_members where m_id = 'zzz';

--테스트용도
INSERT INTO cid_members (m_num, m_id, m_pwd, m_name, m_phone)   --회원계정 추가 아이디 zzz 비번 1234
VALUES (m_seq.NEXTVAL, 'zzz', '1234', '홍길동', '010-1111-1111');

delete from cid_members;

INSERT INTO cid_cars (car_id, car_name, car_brand, car_year, car_color, car_price, car_availability)    --차량추가
VALUES (cars_seq.NEXTVAL, '레이', '현대자동차', 2022, '흰색', 5000, 0);

INSERT INTO cid_cars (car_id, car_name, car_brand, car_year, car_color, car_price, car_availability)    --차량추가
VALUES (cars_seq.NEXTVAL, 'sonata', '현대자동차', 2022, '검정색', 7000, 0);



INSERT INTO cid_rentals (rental_id, m_id, car_id, rental_date, rental_time, return_date, return_time, rental_cost)
VALUES (rentals_seq.NEXTVAL,'zzz',1,TO_DATE('2023-07-13', 'YYYY-MM-DD'),TO_DATE('1030', 'HH24MI'),TO_DATE('2023-07-15', 'YYYY-MM-DD'),TO_DATE('1445', 'HH24MI'),100000
);
SELECT
    rental_id,
    m_id,
    car_id,
    TO_CHAR(rental_date, 'YYYY-MM-DD') AS formatted_rental_date,
    TO_CHAR(rental_time, 'HH24:MI') AS formatted_rental_time,
    TO_CHAR(return_date, 'YYYY-MM-DD') AS formatted_return_date,
    TO_CHAR(return_time, 'HH24:MI') AS formatted_return_time,
    rental_cost
FROM cid_rentals;

select * from cid_rentals; --렌탈 확인


--시간만 출력
SELECT
    TO_CHAR(rental_date, 'YYYY-MM-DD') AS formatted_rental_date,
    TO_CHAR(rental_time, 'HH24:MI') AS formatted_rental_time,
    TO_CHAR(return_date, 'YYYY-MM-DD') AS formatted_return_date,
    TO_CHAR(return_time, 'HH24:MI') AS formatted_return_time
FROM cid_rentals;


SELECT SUBSTR(TO_CHAR(your_date_column, 'YYYY-MM-DD HH24:MI:SS'), 1, 16) AS formatted_date
FROM your_table;


delete cid_rentals;

SELECT * FROM cid_rentals;

select * from cid_rentals where m_id='zzz';


SELECT
  rental_id,
  m_id,
  car_id,
  TO_CHAR(rental_date, 'YYYY"년" MM"월" DD"일" HH24"시" MI"분"') AS rental_date,
  TO_CHAR(return_date, 'YYYY"년" MM"월" DD"일" HH24"시" MI"분"') AS return_date,
  rental_cost
FROM cid_rentals;



--------------------------------------------------------------------------------------------------------------------------------------------

commit;

--ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
drop table car_test;
--test테이블
create table car_test(
mnum int,
mid varchar2(30) primary key,
car_name varchar2(30)
);
CREATE SEQUENCE car_test_seq START WITH 1 INCREMENT BY 1 NOCACHE;

select * from car_test;
select * from car_test where mid = '홍';
delete car_test;
commit;

