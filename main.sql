CREATE TABLE Strings (
    id INT PRIMARY KEY,
    str TEXT
);

CREATE TABLE Patterns (
    id INT PRIMARY KEY,
    pattern TEXT
);

INSERT INTO Strings (id, str) VALUES
(1, 'abcdef'),
(2, 'abcabc'),
(3, 'xyzabc');

INSERT INTO Patterns (id, pattern) VALUES
(1, 'abc'),
(2, 'xyz'),
(3, 'def');

CREATE FUNCTION KMP(@string TEXT, @pattern TEXT)
RETURNS INT
AS
BEGIN
    DECLARE @i INT = 1;
    DECLARE @j INT = 1;
    DECLARE @l INT = LEN(@pattern);
    DECLARE @s INT = LEN(@string);
    DECLARE @next TABLE (i INT, value INT);

    INSERT INTO @next (i, value) VALUES
    (1, 0);

    WHILE @i < @l
    BEGIN
        IF @pattern[@i] = @pattern[@j]
        BEGIN
            SET @i = @i + 1;
            SET @j = @j + 1;
            INSERT INTO @next (i, value) VALUES (@i, @j - 1);
        END
        ELSE
        BEGIN
            IF @j = 1
            BEGIN
                SET @i = @i + 1;
                INSERT INTO @next (i, value) VALUES (@i, 0);
            END
            ELSE
            BEGIN
                SET @j = (SELECT value FROM @next WHERE i = @j - 1) + 1;
            END
        END
    END

    SET @i = 1;
    SET @j = 1;

    WHILE @i <= @s
    BEGIN
        IF @string[@i] = @pattern[@j]
        BEGIN
            SET @i = @i + 1;
            SET @j = @j + 1;

            IF @j > @l
            BEGIN
                RETURN @i - @l;
            END
        END
        ELSE
        BEGIN
            IF @j = 1
            BEGIN
                SET @i = @i + 1;
            END
            ELSE
            BEGIN
                SET @j = (SELECT value FROM @next WHERE i = @j - 1) + 1;
            END
        END
    END

    RETURN -1;
END

SELECT s.str, p.pattern, dbo.KMP(s.str, p.pattern) AS position
FROM Strings s
JOIN Patterns p ON 1 = 1;