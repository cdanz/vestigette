-- Core argument graph procedures (getAssociated, getMostEndorsed, getHeterodox)
-- These were rewritten to fix a MySQL 5.7 correlated-subquery bug: derived tables
-- that are materialized cannot reference outer aliases, so phrasing lookups were
-- moved out of derived tables and into direct JOIN ARGUMENT + inline COALESCE.
-- Run against the vestigette database to restore after a DB reset.

USE vestigette;

DROP PROCEDURE IF EXISTS getAssociated;
DELIMITER //
CREATE PROCEDURE getAssociated(argID INT UNSIGNED)
BEGIN
    SELECT E1.targArgID, E1.endorseType, E1.supportingArgID,
           SUM(E1.weight)/TotalUsers AS AggWeight,
           COALESCE(A1.currentPhrasing,
               (SELECT phrasing FROM PHRASING
                WHERE argumentID = A1.argumentID
                ORDER BY createdDate ASC LIMIT 1)
           ) AS phrasing
    FROM ENDORSEMENT E1
    JOIN (
        SELECT targArgID, endorseType, COUNT(DISTINCT profileID) AS TotalUsers
        FROM ENDORSEMENT
        WHERE targArgID = argID AND active = TRUE
        GROUP BY endorseType
    ) E2 ON E1.endorseType = E2.endorseType
    JOIN ARGUMENT A1 ON E1.supportingArgID = A1.argumentID
    WHERE E1.targArgID = argID AND E1.active = TRUE
    GROUP BY E1.endorseType, E1.supportingArgID, A1.currentPhrasing, A1.argumentID
    ORDER BY CASE
        WHEN E1.endorseType = 'Because' THEN '1'
        WHEN E1.endorseType = 'Rebuttal' THEN '2'
        WHEN E1.endorseType = 'Therefore' THEN '3'
        ELSE E1.endorseType
    END ASC, AggWeight DESC;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS getMostEndorsed;
DELIMITER //
CREATE PROCEDURE getMostEndorsed()
BEGIN
    SELECT
        E1.supportingArgID,
        SUM(E1.weight) AS TotalWeight,
        COALESCE(A.currentPhrasing,
            (SELECT phrasing FROM PHRASING
             WHERE argumentID = A.argumentID
             ORDER BY createdDate ASC LIMIT 1)
        ) AS phrased
    FROM ENDORSEMENT E1
    JOIN ARGUMENT A ON E1.supportingArgID = A.argumentID
    WHERE E1.active = TRUE
    GROUP BY E1.supportingArgID, A.currentPhrasing, A.argumentID
    ORDER BY TotalWeight DESC;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS getHeterodox;
DELIMITER //
CREATE PROCEDURE getHeterodox(proID INT UNSIGNED)
BEGIN
    SELECT
        A.argumentID,
        A.acceptance,
        D.Accept,
        D.Total,
        D.Percent,
        IF(A.acceptance = 0, D.Percent, 1 - D.Percent) AS Difference,
        COALESCE(
            AR.currentPhrasing,
            (SELECT P.phrasing FROM PHRASING P WHERE P.argumentID = AR.argumentID ORDER BY P.createdDate ASC LIMIT 1)
        ) AS phrased
    FROM OPINION A
    JOIN (
        SELECT B.argumentID,
            COUNT(B.acceptance) AS Accept,
            C.Total,
            COUNT(B.acceptance) / C.Total AS Percent
        FROM OPINION B
        JOIN (
            SELECT argumentID, COUNT(acceptance) AS Total
            FROM OPINION
            GROUP BY argumentID
        ) C ON B.argumentID = C.argumentID
        WHERE B.acceptance = TRUE
        GROUP BY B.argumentID
    ) D ON A.argumentID = D.argumentID
    JOIN ARGUMENT AR ON A.argumentID = AR.argumentID
    WHERE A.profileID = proID
      AND IF(A.acceptance = 0, D.Percent, 1 - D.Percent) > .5
    ORDER BY Difference DESC;
END //
DELIMITER ;
