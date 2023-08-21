SELECT * FROM tblperson -- its show all the tables values present in tblperson table
SELECT * FROM tblgender -- its show all the table values present in tblgender table

INSERT INTO tblperson (ID,NAME,EMAIL,GENDER_ID) VALUES(7,'jayant','jayanti@gmail.com',NULL) -- it is use to insert the data into a table
INSERT INTO tblgender (ID,GENDER) VALUES(4,'TRANS')

ALTER TABLE tblperson -- before deleting a constraint we have to alter the table
DROP CONSTRAINT DF_tblperson_GENDERID -- now we can drop the constraint 

ALTER TABLE tblperson ADD CONSTRAINT DF_tblperson_GENDERID DEFAULT 3 FOR GENDER_ID -- it add a default constraints if user doesn't specify its 