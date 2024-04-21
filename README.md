# Oracle DB SQL 기초문법.
> version : Oracle Datavbase 11.2.0

## SQL에서 SELECT 문장은 크게 6개의 절로 구성

```
SELECT : 테이블에서 데이터 질의 하는 키워드

FROM : 데이터를 조회하고 싶은 테이블의 이름을 정하는 키워드

WHERE : 데이터를 조회하는 조건을 적는 키워드  

GROUP BY : 특정 속성을 기준으로 그룹화 하여 검색할 때 속성 키워드 

HAVING : 그룹 함수를 포함한 조건 키워드

ORDER BY : 정렬시 사용하는 키워드
```

# SELECT문의 실행 순서

#### SELECT문은 FROM-WHERE-GROUP BY-HAVING-SELECT-ORDER BY 순으로 실행됨

1. FROM : 발췌 대상 테이블 참조
2. WHERE : 발췌 대상 데이터가 아닌 것은 제거
3. GROUP BY : 행들을 소그룹화 한다.
4. HAVING : 그룹핑된 값의 조건에 맞는 것만을 출력한다.
5. SELECT : 데이터 값을 출력/계산한다.
6. ORDER BY : 데이터를 정렬한다.

# 포스팅에 사용할 테이블

#### SQL 프로그램의 최소 단위는 테이블. 테이블은 행과 열의 관계로 표현됨
#### SQL 포스팅에서 다른 테이블은 EMP 테이블과 DEPT 테이블을 다루도록 함.

# EMP TABLE

#### EMP 테이블은 다음과 같은 구성되어 있음.

<img src="/images/EMP 테이블.png" width="400px" height = "300px" style= "margin: 0 auto;">

#### EMP 테이블의 데이터

<img src="/images/EMP 테이블의 데이터.png" width="400px" height="300px">

#### EMP 테이블의 제약조건

<img src="/images/EMP 테이블의 제약조건.png" width="400px" height="300px">

#### 기본 키(PK)가 EMPNO이며, 외래 키가 DEPTINO이다.

#### EMP 테이블의 외래 키인 DEPTINO는 DEPT 테이블의 기본 키이다.

<img src="/images/DEPT 테이블의 기본 키.png" width="668px" height="65px">

#### SCOTT는 계정 이름이며, EMP, DEPT는 테이블 이름

# DEPT TAVBLE

#### DEPT 테이블은 다음과 같은 구성

<img src="/images/DEPT 테이블.png" width="605px" height="85px">

#### DEPT 테이블의 데이터는 다음과 같음

<img src="/images/DEPT 테이블의 데이터.png" width="303px" height="104px">

# SQL 기초문법

## 테이블의 총 레코드 수 구하기

#### 테이블 전체를 보고 싶을 때는 FULL SCAN(*)표시를 통해 볼 수 있음

```sql
SELECT * FROM EMP;
```

#### 테이블 전체의 레코드 수를 보기 위해서는 COUNT() 함수를 사용하여 볼 수 있음

```sql
SELECT COUNT(*) FROM EMP;
-- 14
```

#### 그러나, EMP처럼 소수의 데이터가 아니라 대량의 데이터가 있는 테이블을 다뤄야 할 경우, 이는 비효울 적이다. 더 효율적으로 계산하려면 테이블의 PK의 수를 조회하면 된다.

* 이유 : 기본키는 null 값이 입력될 수 없으므로, 테이블의 전체 레코드 수와 동일하게 나오기 때문

## Aliase(별칭) 사용하기

```sql
SELECT 
    A.EMPNO     AS EMPNO,    -- Employee Number
    A.ENAME     AS ENAME,    -- Employee Name
    A.JOB       AS JOB,      -- Employee Position
    A.MGR       AS MCR,      -- Manager Employee Number
    A.HIREDATE  AS HIREDATE, -- Hire Date
    A.SAL       AS SAL,      -- Salary    
    A.COMM      AS COMM,     -- Commission
    A.DEPTNO    AS DEPTNO    -- Department Number 
FROM 
    SCOTT.EMP A;
```

#### aliase(별칭)이란 AS 키워드를 사용하여 쿼리에서 반환된 열에 새 이름을 지정하는 것을 해당 열의 별칭 지정(aliasing)이라고 하며, 사용자가 지정한 새 이름을 별칭(aliase)라고 한다.


## Aliase(별칭) 주의사항

```sql
SELECT 
    A.EMPNO     AS EMPNO,    -- Employee Number
    A.ENAME     AS ENAME,    -- Employee Name
    A.JOB       AS JOB,      -- Employee Position
    A.MGR       AS MCR,      -- Manager Employee Number
    A.HIREDATE  AS HIREDATE, -- Hire Date
    A.SAL       AS SAL,      -- Salary    
    A.COMM      AS COMM,     -- Commission
    A.DEPTNO    AS DEPTNO    -- Department Number 
FROM 
    SCOTT.EMP A
WHERE DN = 10;
```

#### 해당 문을 실행할 경우 "Department" : 부적합한 식별자로 오류가 나게 된다.
* 이유 : SELECT문은 FROM-WHERE-GROUP BY-HAVING-SELECT-ORDER BY 순으로 실행되기 때문이다.

#### 따라서, 순섯를 잘 인지하고 WHERE절데 A.DEPTINO=10으로 다시 입력하면 해결된다.

```sql
SELECT 
    A.EMPNO     AS EMPNO,    -- Employee Number
    A.ENAME     AS ENAME,    -- Employee Name
    A.JOB       AS JOB,      -- Employee Position
    A.MGR       AS MCR,      -- Manager Employee Number
    A.HIREDATE  AS HIREDATE, -- Hire Date
    A.SAL       AS SAL,      -- Salary    
    A.COMM      AS COMM,     -- Commission
    A.DEPTNO    AS DEPTNO    -- Department Number 
FROM 
    SCOTT.EMP A;
WHERE AA.DEPTINO = 10;
```
#### 만약, WHERE절에 꼭 DN으로 작성하여 출력하고 싶다면, FROM절에 서브쿼리문을 사용해서 해결할 수 있다.

```sql
SELECT 
    A.EMPNO     AS EMPNO,    -- Employee Number
    A.ENAME     AS ENAME,    -- Employee Name
    A.JOB       AS JOB,      -- Employee Position
    A.MGR       AS MCR,      -- Manager Employee Number
    A.HIREDATE  AS HIREDATE, -- Hire Date
    A.SAL       AS SAL,      -- Salary    
    A.COMM      AS COMM,     -- Commission
    A.DEPTNO    AS DEPTNO    -- Department Number 
FROM 
        (SELECT 
        	EMPNO     AS EMPNO    -- Employee Number
       		,ENAME     AS ENAME    -- Employee Name
       		,JOB       AS JOB      -- Employee Position
       		,MGR       AS MCR      -- Manager Employee Number
       		,HIREDATE  AS HIREDATE -- Hire Date
       		,SAL       AS SAL      -- Salary
       		,COMM      AS COMM     -- Commission
       		,DEPTNO    AS DN   -- Department Number
       FROM  EMP) A
WHERE  A.DN=10;
```

#### FROM 절은 WHERE절보다 더 먼저 실행되기 때문이다.

## WHERE 절 활용하기

#### WHERE절은 조건절로 활용할 수 있다. 예시로, 1981년 1월 1일부터 1981년 12월 31일까지 입사한 사원을 조회하는 경우, 다음과 같이 검색할 수 있습니다.

```sql
SELECT A* FROM SCOTT.EMP A
WHERE 1=1
AND TO_CHAR(TO_DATE(A.HIREDATE), 'YYYYMMDD') <= TO_CHAR(TO_DATE('1981/12/31'), 'YYYYMMDD')
AND TO_CHAR(TO_DATE(A.HIREDATE), 'YYYYMMDD') >= TO_CHAR(TO_DATE('1981/01/01'), 'YYYYMMDD')
```
#### SCOTT는 계정, EMP는 테이블 이름, A는 aliase이다.

#### WHERE 절은 반드시 해당 내용이 참일 때만 수행 된다. 가령 WHERE 절의 첫 번째가 1=2면 참이 아니기 때문에 실행되지 않는다.

#### TO_DATE는 소괄호 내의 칼럼을 DATE 형식으로 바꾼다는 의미이며, TO_CHAR는 첫 번째 날짜 칼럼을 특정 문자열로 변환하는 함수 이다.

#### AND는 전후로 모든 조건이 만족하는 값만 참으로 반환된다.

## 결측치 대체하기

#### 사원의 이름별로 급여와 연봉, 수당, 수당을 포함한 연봉을 구한 뒤 이틀 내림차순 정렬을 한다고 할 때, COMM(수당) 칼럼의 결측치가 있는 것을 확인 할 수 있다.

#### 결측치는 COUNT가 되지 않기 때문에 연산과 카운팅이 불가하다. 따라서, 결측치를 0으로 바꾸고 SELECT문을 실행시켜준다.

```sql
SELECT
  A.ENAME AS ENAME -- 사원이름
  ,A.SAL AS SAL -- 급여
  ,A.SAL * 12 AS TSAL -- 연봉
  ,NVL(A.COMM, 0) AS COMM -- 수당
  ,A. SAL * 12 + NVL(COMM, 0) AS  CSAL -- 수당을 포함한 연봉
FROM
  EMP A
ORDER BY TSAL DESC;
```

#### ORDER BY는 정렬 키워드로 DESC는 내림차순 정렬, ASC는 오름차순 정렬을 의미한다. (DEFAULT값은 ASC이다.)

## LIKE

#### 특정 글자가 들어가는 지 확인하는 키워드에는 LIKE 키워드가 있다.

```sql
SELECT ENMAE FROM EMP WHERE ENMAE LIKE '%S';
SELECT ENAME FROM EMP WHERE ENMAE LIKE '_A%';
```

#### 첫 번째 쿼리문은 마지막 글자가 S로 끝나는 사람을 출력시키라는 의미이고,

#### 두 번째 쿼리문은 두 번째 글자가 A인 사람을 출력하라는 의미이다.