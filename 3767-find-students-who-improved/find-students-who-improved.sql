# Write your MySQL query statement below
WITH RankedScores AS (
    SELECT
        student_id,
        subject,
        score,
        ROW_NUMBER() OVER (PARTITION BY student_id, subject 
                           ORDER BY exam_date ASC)  AS rn_first,
        ROW_NUMBER() OVER (PARTITION BY student_id, subject 
                           ORDER BY exam_date DESC) AS rn_last
    FROM Scores
),
FirstLastScores AS (
    SELECT
        student_id,
        subject,
        MIN(CASE WHEN rn_first = 1 THEN score END) AS first_score,
        MAX(CASE WHEN rn_last  = 1 THEN score END) AS latest_score
    FROM RankedScores
    GROUP BY student_id, subject
    HAVING COUNT(*) > 1
)
SELECT 
    student_id, 
    subject, 
    first_score, 
    latest_score
FROM FirstLastScores
WHERE latest_score > first_score
ORDER BY student_id, subject;