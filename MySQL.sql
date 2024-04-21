-- *은 모든 칼럼을 의미한다.
SELECT * FROM EMPLOYEES;

-- select 다음에 내가 가져오고 싶은 속성을 입력하면 원하는 속성만 가져올 수 있다.
SELECT EMAIL, PHONE_NUMBER
FROM EMPLOYEES;

-- 모든 SQL 명령어는 ;으로 끝난다.
-- eclipse에서 여러개의 명령어를 한꺼번에 그룹으로 실행하고자 할때는 반드시 ;으로 입력해야한다.
-- eclipse 한개의 명령만 실행하는 경우는 ;을 입력하지 않아도 된다.

-- 속성명은 내맘대로 별명을 지울 수 있다.
-- as 별명을 쓰거나 한칸 띄고 별명을 써서 별명을 지울 수 있다.
SELECT EMAIL AS 이메일, PHONE_NUMBER 전화번호
FROM EMPLOYEES;

-- SQL에서 문자는 '', 열 이름은 ""을 쓴다.
SELECT EMAIL, PHONE_NUMBER
FROM EMPLOYEES
WHERE EMAIL = 'sking';

-- 데이터베이스에서 예약어, 속성명, 테이블명 대소문자를 구분하지 않는데,
-- 데이터 내용에서는 대소문자를 구분한다.

SELECT EMAIL, PHONE_NUMBER
FROM EMPLOYEES
WHERE EMAIL = 'SKING';

-- 데이터베이스에서 조회할때 순서를 정해서 조회할 수 있다.
SELECT *
FROM EMPLOYEES
ORDER BY PHONE_NUMBER;

-- ASC를 쓰면 오름차순으로 DESC를 쓰면 내림차순으로 정렬된다.
SELECT COMMISSION_PCT, SALARY
FROM EMPLOYEES
-- ORDER BY COMMISSION_PCT ASC;
ORDER BY COMMISSION_PCT DESC;

-- NULL는 특수한 데이터로 아무것도 아닌 것을 의미한다.
-- 공백문자 ' '나 빈문자''와는 다르다.

SELECT COMMISSION_PCT, SALARY
FROM EMPLOYEES
ORDER BY COMMISSION_PCT DESC NULLS LAST;

-- DB마다 NULL의 순서는 다르다.
-- ORACLE에서는 정렬했을 때 가장 큰 값 다음에 나온다.

-- SQL에서는 간단한 연산이 가능하다.
SELECT 1+3 FROM DUAL;

-- 존재하는 테이블에서 가져오면 테이블의 행의 갯수만큼 가져온다.
SELECT 1+3 FROM EMPLOYEES;

-- SQL에서 연산자는 산술연산자, 논리연산자, 관계연산자등을 모두 쓸 수 있다.
-- JAVA와 다르게 && AND라고 쓰고 || 연산자는 OR라고 쓴다.
-- SQL에서 ||는 문자 연결연산자이다.

SELECT '1+3 =' || (1+3) FROM DUAL;

SELECT 1+3 FROM DUAL;

SELECT SYSDATE  -- SYSDATE 속성에서
FROM EMPLOYEES  -- EMPLOYEES 테이블에서
GROUP BY SYSDATE; --SYDATE 그룹에서

SELECT SALARY -- SALARY속성 가져온다.
FROM EMPLOYEES  -- EMPLOYEES에서 
WHERE SALARY >= 5000 AND SALARY <= 10000; -- SALARY에서 5000보다 많거나 같고 10000보다 적거나 같은 것

SELECT SALARY -- SALARY 속성에서
FROM EMPLOYEES  -- EMPLOYEES 테이블안에서
WHERE SALARY BETWEEN 5000 AND 10000;  -- SALARY에서 5000과 10000 사이

-- % 기호는 여러개의 아무 문자를 의미한다.
SELECT * FROM EMPLOYEES -- SELECT 모든 속성 EMPLOYEES 테이블안에서
WHERE FIRST_NAME LIKE '%A%';  -- FIRST_NAME에서 모든 A를 가져와라

-- A로 시작하는 4글자의 FIRST_NAME을 갖고 있는 사람을 찾기
-- '_'는 한개의 글자를 의미한다.

SELECT * FROM EMPLOYEES -- SELECT 모든 속성 EMPLOYEES 테이블 안에서
WHERE FIRST_NAME LIKE 'A__';  -- FIRST_NAME에서 첫글자 A포함 뒤에 2글자들을 가져와라;

-- NULL은 특별한 데이터이기 때문에 =로 비교할 수 없다.
SELECT * FROM EMPLOYEE  --SELECT에 모든 속성에서 EMPLOYEE모든 테이블안에서
WHERE COMMISSION_PCT IS NULL; -- COMMISSION_PCT는 NULL이다.

SELECT * FROM EMPLOYEE  --SELECT에 모든 속성에서 EMPLOYEE모든 테이블안에서
WHERE COMMISSION_PCT IS NULL; -- COMMISSION_PCT는 NULL이 아니다.

-- 집단함수는 같은 열의 계산할 대 사용한다.
-- sum, avg, max, min, dev, ..엑셀과 거의 똑같은 함수를 사용한다.
SELECT SUM(SALARY)  --SELECT SALARY 합계
FROM EMPLOYEES  -- EMPLOYEES 테이블에서
GROUP BY DEPARTMENT_ID; -- DEPARTMENT_ID 그룹에서

-- 보통 집단함수를 사용하 때는 GROUP BY절을 함께 쓴다.
-- 부서별로 월급의 한계를 조회하기
SELECT DEPARTMENT_ID, SUM(SALARY) -- DEPARTMENT_ID 속성에 SALARY합계를
FROM EMPLOYEES --ENPLOYEES 테이블 안에서
GROUP BY DEPARTMENT_ID; --DEPARTMENT_ID그룹에서

-- 조이을 하는 방법은 여러가지가 있다.
SELECT * FROM EMPLOYEES, DEPARYMENTS  -- 모든 속성을 EMPLOYEES, DEPARTMENTS 테이블 안에서
WHERE EMPLOYEES.DEPARTMENET_ID = DEPARTMENTS.DEPARTMENT_ID; -- EMPLOYEES.DEPARTMENT_ID 는 DEPARTMENTS.DEPARTMENT_ID 이다.

SELECT * FROM EMPLOYEES --모든 속성을 테이블 안에서
WHERE DEPARTMENT_ID IS NULL;  --DEPARTMENT_ID는 NULL에서
-- 필요한 속성들만 볼 수 있다.
SELECT * FROM DEPARTMENTS;

-- 두개 이상의 테이블을 이용하여 조회하는 경우에는
-- 테이블명.속성명 SELECT 다음에 써줘야 하는데,
-- 두개의 테이블에 공통적으로 사용하는 속성명이 아닌 경우에는
-- 테이블 이름을 생략해도 된다.

SELECT FRIST_NAME, LAST_NAME, DEPARTMENT_ID, DEPARTMENT_NAME  -- FIRST_NAME, LAST_NAME, DEPARTMENT_ID, DEPARTMENT_NAME 속성에서
FROM EMPLOYEES E, DEPARTMENT D -- EMPLOYEES에 E, DEPARTMENT에 테이블 안에서
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID;  -- E.DEPARTMENT_ID IS D.DEPARTMENT_ID

-- INNER JOIN
SELECT FIRST_NAME, LAST_NAME, DEPARTMENT_ID, DEPARTMENT_NAME
FROM EMPLOYEES E
INNER JOIN DEPARTMENT D
ON E.DEPARTMENT_ID D.DEPARTMENT;
-- 이 SQL 쿼리는 "EMPLOYEES" 테이블과 "DEPARTMENT" 테이블을 INNER JOIN하여 사용자에게 다음과 같은 정보를 제공
-- 이름(FIRST_NAME 및 LAST_NAME), 부서 ID
-- (DEPARTMENT_ID) 및 해당 부서의 이름 (DEPARTMENT_NAME). INNER JOIN은 두 테이블 간에 일치하는 행을 가져오는 데 사용 됨.

-- OUTER JOIN을 쓴다.
-- OUTER JOIN 3가지 있다.
-- LEFT OUTER JOIN, RIGHT OUTER JOIN, FULL OUTER JOIN

/**
INSERT INTO 테이블 명
(속성명들)
VALUES
(값들)
*/

INSERT INTO EMPLOYEES
(EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY)
VALUES
(207, 'jihun', 'jung', 'sdh230414', '1234', sydate, 'SH_CLERK', 5000);

SELECT MAX(EMPLOYEE_ID)
FROM EMPLOYEES;

/*
updaet 테이블명
set 속성명 - 값, 속성명2 = 값2
where 조건
*/
UPDATE EMPLOYEES
SET FIRST_NAME =  'jung'
WHERE EMPLOYEE_ID = 18;

SELECT * FROM EMPLOYEES WHERE EMPLOYEE_ID = 207;