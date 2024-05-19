use bank_loan_analysis;
select count(*) from `finance 1`;
select count(*) from `finance 2`;
select * from `finance 1`;
select * from `finance 2`;

# year wise loan amt stats
#kpi_1

SELECT
    issue_d AS year_issue_d,
    SUM(loan_amnt) AS total_loan_amnt
FROM
    `finance 1`
GROUP BY
    year_issue_d
ORDER BY
    year_issue_d;
  
# grade & sub-grade wise revol_bal
# kpi_2
SELECT
    grade,
    sub_grade,
    SUM(revol_bal) AS total_revol_bal
FROM
    `finance 1`
INNER JOIN
    `finance 2` ON `finance 1`.id = `finance 2`.id
GROUP BY
    grade, sub_grade
ORDER BY
    grade, sub_grade;
    
# total payment for verified status & total payment for non-verified status
# kpi_3
SELECT
    verification_status,
    CONCAT('$', FORMAT(ROUND(SUM(total_pymnt) / 1000000, 2), 2), 'M') AS total_payment
FROM
    `finance 1`
INNER JOIN
    `finance 2` ON `finance 1`.id = `finance 2`.id
GROUP BY
    verification_status;
    
# state wise & month wise loan status
# kpi_4
SELECT
    addr_state,
    last_credit_pull_d,
    loan_status
FROM
    `finance 1`
INNER JOIN
    `finance 2` ON `finance 1`.id = `finance 2`.id
GROUP BY
    addr_state,
    last_credit_pull_d,
    loan_status
ORDER BY
    last_credit_pull_d;
    
# home ownership vs last payment date status
# kpi_5
SELECT
    home_ownership,
    last_pymnt_d,
    CONCAT('$', FORMAT(ROUND(SUM(last_pymnt_amnt) / 10000, 2), 2), 'K') AS total_payment
FROM
    `finance 1`
INNER JOIN
    `finance 2` ON `finance 1`.id = `finance 2`.id
GROUP BY
    home_ownership,
    last_pymnt_d
ORDER BY
    last_pymnt_d DESC,
    home_ownership DESC;