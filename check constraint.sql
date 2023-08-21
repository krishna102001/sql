SELECT * FROM tblperson
SELECT * FROM tblgender

-- INSERT INTO tblgender VALUES(3,'UNKNOWN')
INSERT INTO tblperson VALUES(8,'MARIYA','MA@K.COM',3,NULL)

-- ALTER TABLE tblperson DROP CONSTRAINT CK_tblperson_Age
ALTER TABLE tblperson ADD CONSTRAINT CK_tblperson_Age CHECK (AGE>0 AND AGE <150) -- check constraints are used to limit the range of value to be entered