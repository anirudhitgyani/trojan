
-- Drop All Tables
   SET FOREIGN_KEY_CHECKS = 0; -- Set Foreign Keys Off For Skipping Constraints
    set @AllTableCount = 0;
    SELECT count(*) INTO @AllTableCount
            FROM information_schema.tables 
        WHERE table_schema = 'technofl_itgyaniv01';  
        SET @DropTables = NULL;
            SELECT GROUP_CONCAT(table_schema, '.', table_name) INTO @DropTables
                FROM information_schema.tables 
            WHERE table_schema = 'technofl_itgyaniv01'; -- specify DB name here.        
        set @TransSQL = case @AllTableCount
        when 0 then CONCAT(
              'select ''No Table Exists''')
        else CONCAT('DROP TABLE ',(SELECT GROUP_CONCAT(table_schema, '.', table_name)
                FROM information_schema.tables 
            WHERE table_schema = 'technofl_itgyaniv01'))
        end;
  
  PREPARE stmt FROM @TransSQL;
  EXECUTE stmt;
  DEALLOCATE PREPARE stmt;
   
-- Tables ///////////////////////////////////////////////////////////////////////////////
SET FOREIGN_KEY_CHECKS = 1; -- Set Foreign On To Check Constraints.
  -- Create User Group Table

      PREPARE stmt FROM 'CREATE TABLE usergroup (
          GroupID TINYINT(4) NOT NULL AUTO_INCREMENT,
          GroupName VARCHAR(50) NOT NULL,
          IsPaid TINYINT(1) NOT NULL,
          IsActive TINYINT(1) NOT NULL,
          IsDeleted TINYINT(1) NOT NULL,
          AddUserID SMALLINT(6) NOT NULL,
          AddUserTime TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
          UpdateUserID SMALLINT(6) DEFAULT NULL,
          UpdateUserTime DATETIME NULL,
          UNIQUE (GroupName),
          PRIMARY KEY (GroupID)
        )
        ENGINE = INNODB
        AUTO_INCREMENT = 1
        CHARACTER SET latin1
        COLLATE latin1_swedish_ci;        
        ';
      EXECUTE stmt;
      DEALLOCATE PREPARE stmt;
      -- Add Defalt Group
      PREPARE stmt FROM 'Insert InTo usergroup(GroupName,IsPaid,IsActive ,IsDeleted,AddUserID)
        values("Super Admin", "0" , "1", "0" , "1"),("Student", "1" , "1", "0" , "1"),("Corporate", "1" , "1", "0" , "1");       
        ';
      EXECUTE stmt;
      DEALLOCATE PREPARE stmt;
      -- Create Plan Table

      PREPARE stmt FROM 'CREATE TABLE commercialplan (
          PlanID TINYINT(4) NOT NULL AUTO_INCREMENT,
          PlanName VARCHAR(50) NOT NULL,
          IsFree TINYINT(1) NOT NULL,
          IsForStudent TINYINT(1) NOT NULL,
          IsForCorporate TINYINT(1) NOT NULL,
          PlanAmount DOUBLE(9,2) NOT NULL,          
          PlanValidityDays SMALLINT(6) NOT NULL,          
          IsActive TINYINT(1) NOT NULL,
          IsDeleted TINYINT(1) NOT NULL,
          AddUserID SMALLINT(6) NOT NULL,
          AddUserTime TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
          UpdateUserID SMALLINT(6) DEFAULT NULL,
          UpdateUserTime DATETIME NULL,
          UNIQUE (PlanName),
          PRIMARY KEY (PlanID)
        )
        ENGINE = INNODB
        AUTO_INCREMENT = 1
        CHARACTER SET latin1
        COLLATE latin1_swedish_ci;        
        ';
      EXECUTE stmt;
      DEALLOCATE PREPARE stmt;
      -- Add Plan Values
      PREPARE stmt FROM 'Insert InTo commercialplan ( PlanName, IsFree, IsForStudent, IsForCorporate, PlanAmount, PlanValidityDays, IsActive, IsDeleted, AddUserID) 
        Select  ''Free'' As PlanName, ''1'' As IsFree, ''1'' As IsForStudent, ''0'' As IsForCorporate, ''0.0'' As PlanAmount, ''30'' As PlanValidityDays, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID
        Union
        Select  '' 25000/-'' As PlanName, ''1'' As IsFree, ''1'' As IsForStudent, ''0'' As IsForCorporate, ''25000.00'' As PlanAmount,''360'' As PlanValidityDays,  ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID
        ; 
        ';
      EXECUTE stmt;
      DEALLOCATE PREPARE stmt;
        -- Plan Features

      PREPARE stmt FROM 'CREATE TABLE planFeature (
          PlanID TINYINT(4) NOT NULL,
          FeatureID TINYINT(4) NOT NULL AUTO_INCREMENT,
          FeatureProperty VARCHAR(50) NOT NULL,
          FeatureValue VARCHAR(50) NOT NULL,          
          IsActive TINYINT(1) NOT NULL,
          IsDeleted TINYINT(1) NOT NULL,
          AddUserID SMALLINT(6) NOT NULL,
          AddUserTime TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
          UpdateUserID SMALLINT(6) DEFAULT NULL,
          UpdateUserTime DATETIME NULL,
          PRIMARY KEY ITG_PK_FeatureID_$planFeature (FeatureID),
          FOREIGN KEY ITG_FK_PlanID_$commercialplan$TO$planFeature (PlanID) REFERENCES commercialplan(PlanID)
        )
        ENGINE = INNODB
        AUTO_INCREMENT = 1
        CHARACTER SET latin1
        COLLATE latin1_swedish_ci;        
        ';
      EXECUTE stmt;
      DEALLOCATE PREPARE stmt;
     -- Add Feature Values
      PREPARE stmt FROM 'Insert InTo planFeature (PlanID,  FeatureProperty, FeatureValue, IsActive, IsDeleted, AddUserID) 
        Select  ''1'' As PlanID,  ''Aptitude test'' As FeatureProperty, ''Yes'' As FeatureValue, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID 
        Union
        Select  ''2'' As PlanID,  ''Aptitude test'' As FeatureProperty, ''Yes'' As FeatureValue, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID 
        Union
        Select  ''1'' As PlanID,  ''Foundation course'' As FeatureProperty, ''Partial'' As FeatureValue, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID 
        Union
        Select  ''2'' As PlanID,  ''Foundation course'' As FeatureProperty, ''Yes'' As FeatureValue, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID 
        Union
        Select  ''1'' As PlanID,  ''Guarantee'' As FeatureProperty, ''No'' As FeatureValue, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID 
        Union
        Select  ''2'' As PlanID,  ''Guarantee'' As FeatureProperty, ''Yes'' As FeatureValue, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID 
        Union
        Select  ''1'' As PlanID,  ''Counseling'' As FeatureProperty, ''No'' As FeatureValue, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID 
        Union
        Select  ''2'' As PlanID,  ''Counseling'' As FeatureProperty, ''Yes'' As FeatureValue, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID 
        Union
        Select  ''1'' As PlanID,  ''Trainer access'' As FeatureProperty, ''Partial'' As FeatureValue, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID 
        Union
        Select  ''2'' As PlanID,  ''Trainer access'' As FeatureProperty, ''Yes'' As FeatureValue, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID 
        Union
        Select  ''1'' As PlanID,  ''Psychometric evaluation'' As FeatureProperty, ''No'' As FeatureValue, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID 
        Union
        Select  ''2'' As PlanID,  ''Psychometric evaluation'' As FeatureProperty, ''Yes'' As FeatureValue, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID 
        Union
        Select  ''1'' As PlanID,  ''Specialized training tests'' As FeatureProperty, ''No'' As FeatureValue, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID 
        Union
        Select  ''2'' As PlanID,  ''Specialized training tests'' As FeatureProperty, ''Yes'' As FeatureValue, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID 
        Union
        Select  ''1'' As PlanID,  ''Corporate access'' As FeatureProperty, ''No'' As FeatureValue, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID 
        Union
        Select  ''2'' As PlanID,  ''Corporate access'' As FeatureProperty, ''Yes'' As FeatureValue, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID 
        Union
        Select  ''1'' As PlanID,  ''Interview preparation'' As FeatureProperty, ''No'' As FeatureValue, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID 
        Union
        Select  ''2'' As PlanID,  ''Interview preparation'' As FeatureProperty, ''Yes'' As FeatureValue, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID 
        Union
        Select  ''1'' As PlanID,  ''Live environment training'' As FeatureProperty, ''No'' As FeatureValue, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID 
        Union
        Select  ''2'' As PlanID,  ''Live environment training'' As FeatureProperty, ''Yes'' As FeatureValue, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID 
        Union
        Select  ''1'' As PlanID,  ''Fee'' As FeatureProperty, ''0'' As FeatureValue, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID 
        Union
        Select  ''2'' As PlanID,  ''Fee'' As FeatureProperty, ''25000.00'' As FeatureValue, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID 
        Union
        Select  ''1'' As PlanID,  ''Validity'' As FeatureProperty, ''30 Days'' As FeatureValue, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID 
        Union
        Select  ''2'' As PlanID,  ''Fee'' As FeatureProperty, ''1 Year'' As FeatureValue, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID 
        ; 
        ';
      EXECUTE stmt;
      DEALLOCATE PREPARE stmt;
      -- Create Power Admin Table

      PREPARE stmt FROM 'CREATE TABLE AdminPanel(
          GroupID TINYINT NOT NULL,
          AdminID TINYINT(4) NOT NULL AUTO_INCREMENT,
          AdminEmail varchar(50) NOT NULL,          
          AdminPassword varchar(5000) NOT NULL,
          IsActive TINYINT(1) NOT NULL,
          IsDeleted TINYINT(1) NOT NULL,
          AddUserID SMALLINT(6) NOT NULL,
          AddUserTime TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
          UpdateUserID SMALLINT(6) DEFAULT NULL,
          UpdateUserTime DATETIME NULL,
          UNIQUE (AdminEmail),
          PRIMARY KEY (AdminID),
          FOREIGN KEY (GroupID) REFERENCES usergroup(GroupID)          
        )
        ENGINE = INNODB
        AUTO_INCREMENT = 1
        CHARACTER SET latin1
        COLLATE latin1_swedish_ci;        
        ';
      EXECUTE stmt;
      DEALLOCATE PREPARE stmt;
      -- Add Default Admin In Table.
      PREPARE stmt FROM '
          Insert InTo AdminPanel( GroupID, AdminEmail, AdminPassword, IsActive, IsDeleted, AddUserID) 
          Select ''1'' As GroupID, ''ashish.sharma14@gmail.com'' As AdminEmail, ''pRjtXyYsn/M='' As AdminPassword, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID; 
        ';
      EXECUTE stmt;
      DEALLOCATE PREPARE stmt;
      -- Create Trans Message's Table
      PREPARE stmt FROM 'CREATE TABLE TransMessages (         
          TransMessageId SMALLINT(6) NOT NULL AUTO_INCREMENT,
          TransMessage varchar(500) NOT NULL,          
          TransControl varchar(500) NOT NULL,
          UNIQUE (TransMessage),
          PRIMARY KEY (TransMessageId)
        )
        ENGINE = INNODB
        AUTO_INCREMENT = 1
        CHARACTER SET latin1
        COLLATE latin1_swedish_ci;        
        ';
      EXECUTE stmt;
      ALTER TABLE TransMessages AUTO_INCREMENT=501;
      
        Insert InTo TransMessages (TransMessageId, TransMessage, TransControl ) Select  '9001' As TransMessageId, 'Sorry For Inconvenience, System Is Under maintenance. Please Wait For Some Minute''s Or Call To Customer Care For Confirming Start Time. !!!' As TransMessage, 'N/A' As TransControl; 
        Insert InTo TransMessages (TransMessageId, TransMessage, TransControl ) Select  '9002' As TransMessageId, '@Replace !!!' As TransMessage, 'N/A' As TransControl; 
          
          PREPARE stmt FROM 
            '
              Insert InTo TransMessages (TransMessageId, TransMessage, TransControl ) 
              Select ''501'' As TransMessageId,  ''Login Failed. Please, Check Spelling Mistakes, Caps Lock Status For Valid Password Entry'' As TransMessage, ''EwebTxtUserID'' As TransControl
              Union
              Select ''502'' As TransMessageId,  ''Login Successfull.'' As TransMessage, ''EwebTxtUserID'' As TransControl
              Union
              Select ''503'' As TransMessageId,  ''Course With Name @Replace Already Exist''''s !!!.'' As TransMessage, ''ITGTxtCourseName'' As TransControl
              Union
              Select ''504'' As TransMessageId,  ''Course With Name @Replace Added Successfully !!!.'' As TransMessage, ''ITGTxtCourseName'' As TransControl
              Union
              Select ''505'' As TransMessageId,  ''Course With Name @Replace Updated Successfully !!!.'' As TransMessage, ''ITGTxtCourseName'' As TransControl
              Union
              Select ''506'' As TransMessageId,  ''Course With Name @Replace Deleted Successfully !!!.'' As TransMessage, ''ITGTxtCourseName'' As TransControl
              ; 
            '; -- #TransMessage
          EXECUTE stmt;
          DEALLOCATE PREPARE stmt;
      -- Create State Table
      PREPARE stmt FROM 'CREATE TABLE course (
          CourseID TINYINT(4) NOT NULL AUTO_INCREMENT,
          CourseName VARCHAR(50) NOT NULL,          
          CourseDesc VARCHAR(255) NOT NULL, 
          ImageName  VARCHAR(100) NOT NULL, 
          ImageData  LONGBLOB NOT NULL, 
          IsActive TINYINT(1) NOT NULL,
          IsDeleted TINYINT(1) NOT NULL,
          AddUserID SMALLINT(6) NOT NULL,
          AddUserTime TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
          UpdateUserID SMALLINT(6) DEFAULT NULL,
          UpdateUserTime DATETIME NULL,
          UNIQUE (CourseName),
          PRIMARY KEY (CourseID)
        )
        ENGINE = INNODB
        AUTO_INCREMENT = 1
        CHARACTER SET latin1
        COLLATE latin1_swedish_ci;        
        ';
      EXECUTE stmt;
      DEALLOCATE PREPARE stmt;
      
      -- Create State Table
      PREPARE stmt FROM 'CREATE TABLE state (
          StateID TINYINT(4) NOT NULL AUTO_INCREMENT,
          StateName VARCHAR(50) NOT NULL,          
          IsActive TINYINT(1) NOT NULL,
          IsDeleted TINYINT(1) NOT NULL,
          AddUserID SMALLINT(6) NOT NULL,
          AddUserTime TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
          UpdateUserID SMALLINT(6) DEFAULT NULL,
          UpdateUserTime DATETIME NULL,
          UNIQUE (StateName),
          PRIMARY KEY (StateID)
        )
        ENGINE = INNODB
        AUTO_INCREMENT = 1
        CHARACTER SET latin1
        COLLATE latin1_swedish_ci;        
        ';
      EXECUTE stmt;
      DEALLOCATE PREPARE stmt;
      
      PREPARE stmt FROM '
          Insert InTo state ( StateName, IsActive, IsDeleted, AddUserID) 
          Select   '''' As StateName, '''' As IsActive, '''' As IsDeleted, '''' As AddUserID; 
        ';
      EXECUTE stmt;
      DEALLOCATE PREPARE stmt;
      
      -- Create Maintinance
      PREPARE stmt FROM 'CREATE TABLE maintenance (
          maintenanceID TINYINT(4) NOT NULL AUTO_INCREMENT,
          maintenanceName VARCHAR(50) NOT NULL,          
          maintenanceDesc VARCHAR(255) NOT NULL,
          StartTime TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
          EndTime TIMESTAMP NULL ,          
          AddUserID SMALLINT(6) NOT NULL,
          AddUserTime DATETIME NULL,
          UpdateUserID SMALLINT(6) DEFAULT NULL,
          UpdateUserTime DATETIME NULL,
          PRIMARY KEY (maintenanceID)
        )
        ENGINE = INNODB
        AUTO_INCREMENT = 1
        CHARACTER SET latin1
        COLLATE latin1_swedish_ci;        
        ';
      EXECUTE stmt;
      DEALLOCATE PREPARE stmt;  
      PREPARE stmt FROM '
          Insert InTo maintenance ( maintenanceName,maintenanceDesc,StartTime,EndTime, AddUserID) 
          Select   ''Test'' As maintenanceName,''Test'' As maintenanceDesc,CURRENT_TIMESTAMP StartTime, CURRENT_TIMESTAMP as EndTime,  ''0'' As AddUserID; 
        ';
      EXECUTE stmt;
      DEALLOCATE PREPARE stmt;
      -- Create Maintinance
      PREPARE stmt FROM 'CREATE TABLE ErrorLog (
          ErrorLogID SMALLINT(6) NOT NULL AUTO_INCREMENT,
          ErrorLogNo VARCHAR(50) NOT NULL,          
          ErrorSQLState VARCHAR(50) NOT NULL,          
          ErrorMessage VARCHAR(255) NOT NULL,                   
          ErrorObjectName VARCHAR(50) NOT NULL,
          ErrorObjectValues VARCHAR(1000) NOT NULL,
          AddUserID SMALLINT(6) NOT NULL,
          AddUserTime TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,                   
          PRIMARY KEY (ErrorLogID)
        )
        ENGINE = INNODB
        AUTO_INCREMENT = 1
        CHARACTER SET latin1
        COLLATE latin1_swedish_ci;        ';
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
-- Procedures ///////////////////////////////////////////////////////////////////////////////
      -- Create Procedure
      -- Procedure Creation
      -- Procedure For Insert Statement
      DROP PROCEDURE IF EXISTS PrepareInsertStatement;
      DELIMITER $$;
      CREATE PROCEDURE PrepareInsertStatement(IN databasename VARCHAR(255), IN tablename VARCHAR(255))
        BEGIN
              SELECT  CONCAT( "Insert InTo " ,TABLE_NAME, " (", CONCAT("", GROUP_CONCAT(column_name ORDER BY ordinal_position SEPARATOR ", "), " ) Select " , CONCAT(" ", GROUP_CONCAT(CONCAT("'''' As ",column_name) ORDER BY ordinal_position SEPARATOR ", "), "; ")), "") AS columns   
                FROM information_schema.columns
              WHERE table_schema = databasename AND table_name = tablename;
      END$$;
      -- Procedure For Update Statement
      DROP PROCEDURE IF EXISTS PrepareUpdateStatement;      
      CREATE PROCEDURE PrepareUpdateStatement(IN databasename VARCHAR(255), IN tablename VARCHAR(255))
        BEGIN
              SELECT  CONCAT( "Update " ,TABLE_NAME, " ", CONCAT("", "", "  Set " , CONCAT(" ", GROUP_CONCAT(CONCAT(column_name , " = ''''  ") ORDER BY ordinal_position SEPARATOR ", "), "; ")), "") AS columns   
                FROM information_schema.columns
              WHERE table_schema = databasename AND table_name = tablename;
      END$$;
      -- Procedure For Returning Transaction Result      
      DELIMITER $$;
        DROP PROCEDURE IF EXISTS ExecuteMessage;
        CREATE PROCEDURE ExecuteMessage(IN ParaCurrentIdentification VARCHAR(50), IN ParaTransMessageId SMALLINT(6),IN ParaReplaceWord VARCHAR(255))
        BEGIN
              Select TransactionStatusCode(ParaCurrentIdentification ) as 'ResultID', TMS.TransMessageId,  REPLACE(TMS.TransMessage , '@Replace' ,CONCAT( '[ ' , ParaReplaceWord , ' ]'))  as  TransMessage, TMS.TransControl From TransMessages TMS Where TMS.TransMessageId = ParaTransMessageId ;
        END$$;
        -- Procedure For SignIn
      DELIMITER $$;
        DROP PROCEDURE IF EXISTS ManageAdminSignIn;
        CREATE PROCEDURE ManageAdminSignIn(IN ParaEmail VARCHAR(50), IN ParaPassword VARCHAR(5000))
        BEGIN
          DECLARE EXIT HANDLER FOR SQLEXCEPTION    
          BEGIN
              GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, 
              @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;
              SET @full_error = CONCAT("ERROR ", @errno, " (", @sqlstate, "): ", @text);
              Insert InTo errorlog ( ErrorLogNo, ErrorSQLState, ErrorMessage, ErrorObjectName, ErrorObjectValues, AddUserID) 
              Select   @errno As ErrorLogNo, @sqlstate As ErrorSQLState, @text As ErrorMessage, 'ManageAdminSignIn' As ErrorObjectName, Concat('Email : ' , ParaEmail , ' -> ' , ' Password : ' , ParaPassword) As ErrorObjectValues, '0' As AddUserID;           
          End;
              If Exists(Select * From maintenance Where EndTime IS NULL) THEN
                   CALL ExecuteMessage( 'maintenance' , 9001 , '');
              ElseIf Exists(Select * From AdminPanel WHERE AdminEmail = ParaEmail And AdminPassword = ParaPassword) THEN
                  CALL ExecuteMessage( 'SignInSuccess' , 502 , '');
              Else
                  CALL ExecuteMessage( 'SignInFailed' , 501 , '');
              End IF;
          
        END$$;
      -- Procedure For Inline Queries
        DELIMITER $$;
        DROP PROCEDURE IF EXISTS ExecuteUIControls;
        CREATE PROCEDURE ExecuteUIControls(IN ParaTransType SMALLINT(6),IN ParaTransValue  SMALLINT(6) ,IN ParaTranString  varchar(255),IN ParaUserID  SMALLINT(6))
        BEGIN
            
            DECLARE EXIT HANDLER FOR SQLEXCEPTION    
            BEGIN
                GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, 
                @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;
                SET @full_error = CONCAT("ERROR ", @errno, " (", @sqlstate, "): ", @text);
                Insert InTo errorlog ( ErrorLogNo, ErrorSQLState, ErrorMessage, ErrorObjectName, ErrorObjectValues, AddUserID) 
                Select   @errno As ErrorLogNo, @sqlstate As ErrorSQLState, @text As ErrorMessage, 'ExecuteUIControls' As ErrorObjectName, Concat('Type : ' , ParaTransType , ' -> ' , ' Value : ' , ParaTransValue , ' -> ' , ' String : ' , ParaTranString,' -> ' , ' UserID ', ParaUserID) As ErrorObjectValues, '0' As AddUserID;           
            End;
              if(ParaUserID = 0) Then
                Set ParaUserID = (Select AdminID From AdminPanel Where AdminEmail = ParaTranString LIMIT 1) ;
              End if;
              If ParaTransType = 101 THEN
                  Select GroupID, AdminID, AdminEmail, AdminPassword, IsActive, IsDeleted  From AdminPanel WHERE AdminEmail =  ParaTranString;
              ELSEIF ParaTransType = 102 THEN -- For Course Tree To Get All Course's
                  Select CourseID as "id", CourseName as "Parent", CourseName as 'text' From course where IsDeleted = '0' ORDER BY CourseName ASC;
              ELSEIF ParaTransType = 103 THEN -- Ger Tree Node For Selection.
                  Select CourseID as 'ID' , CourseName , CourseDesc, ImageName, ImageData, IsActive  From course where IsDeleted = '0' And CourseName = ParaTranString  ORDER BY CourseName ASC;
              ELSEIF ParaTransType = 104 THEN -- Ger Tree Node For Selection.
                  Select CourseID as 'ID' , CourseName , CourseDesc, ImageName, ImageData, IsActive  From course where IsDeleted = '0' And CourseID = ParaTransValue  ORDER BY CourseName ASC;
              Else
                  CALL ExecuteMessage( 'SignInFailed' , 501 , '');
              End IF;
                        
        END$$;
      -- Procedure For Managing Course
        DELIMITER $$;
        DROP PROCEDURE IF EXISTS ManageAdminCourse;
        CREATE PROCEDURE ManageAdminCourse(IN ParaCourseName VARCHAR(50), IN ParaCourseDesc VARCHAR(255), IN ParaImageName VARCHAR(100), IN ParaImageData LONGBLOB ,IN ParaIsActive TINYINT,IN ParaIsDeleted TINYINT, ParaAddUserID SMALLINT , ParaRecordID SMALLINT )
        BEGIN
           DECLARE EXIT HANDLER FOR SQLEXCEPTION    
              BEGIN
                  GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, 
                  @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;
                  SET @full_error = CONCAT("ERROR ", @errno, " (", @sqlstate, "): ", @text);
                  Insert InTo errorlog ( ErrorLogNo, ErrorSQLState, ErrorMessage, ErrorObjectName, ErrorObjectValues, AddUserID) 
                  Select   @errno As ErrorLogNo, @sqlstate As ErrorSQLState, @text As ErrorMessage, 'ManageCourse' As ErrorObjectName, Concat('Type : ' , ParaTransType , ' -> ' , ' Value : ' , ParaTransValue , ' -> ' , ' String : ' , ParaTranString,' -> ' , ' UserID ', ParaUserID) As ErrorObjectValues, '0' As AddUserID;           
              End;
              IF(ParaRecordID = 0 And ParaIsDeleted = '0') THEN
                    If Not Exists(Select * From course WHERE CourseName = ParaCourseName And IsDeleted = '0'  ) THEN
                        Insert InTo course ( CourseName, CourseDesc, ImageName, ImageData, IsActive, IsDeleted, AddUserID) 
                          Select   ParaCourseName As CourseName, 
                                   ParaCourseDesc As CourseDesc, 
                                   ParaImageName As ImageName, 
                                   ParaImageData As ImageData, 
                                   ParaIsActive As IsActive, 
                                   '0' As IsDeleted, 
                                   ParaAddUserID As AddUserID; 
                        CALL ExecuteMessage( 'Add' , 504 , ParaCourseName);
                    Else
                        CALL ExecuteMessage( 'Exist' , 503 , ParaCourseName);
                    End IF;
              ELSEIF(ParaRecordID > 0 And ParaIsDeleted = '0') THEN
                   If Not Exists(Select * From course WHERE CourseName = ParaCourseName And IsDeleted = '0' And NOT( CourseID = ParaRecordID ) ) THEN
                        Update course   Set                                  
                               CourseName = ParaCourseName  , 
                               CourseDesc = ParaCourseDesc  , 
                               ImageName = ParaImageName  , 
                               ImageData = ParaImageData  , 
                               IsActive = ParaIsActive  , 
                               IsDeleted = '0'  , 
                               UpdateUserID = ParaAddUserID  , 
                               UpdateUserTime = CURRENT_TIMESTAMP  
                        Where CourseID = ParaRecordID ; 
                        CALL ExecuteMessage( 'Update' , 505 , ParaCourseName);
                    Else
                        CALL ExecuteMessage( 'Exist' , 503 , ParaCourseName);
                    End IF;
              ELSEIF(ParaRecordID > 0 And ParaIsDeleted = '1') THEN      
                    Update course   Set                                                                 
                               IsDeleted = '1'  , 
                               UpdateUserID = ParaAddUserID  , 
                               UpdateUserTime = CURRENT_TIMESTAMP  
                        Where CourseID = ParaRecordID ; 
                    CALL ExecuteMessage( 'Delete' , 506 , ParaCourseName);
              END IF;
        END$$;
-- Functions ///////////////////////////////////////////////////////////////////////////////
      DELIMITER $$;
        DROP FUNCTION IF EXISTS TransactionStatusCode;
        CREATE FUNCTION TransactionStatusCode (CurrentIdentification varchar(50))
								RETURNS  SMALLINT(6)
								DETERMINISTIC
								BEGIN
                  DECLARE IdentificationStatus SMALLINT(6);
                  Set IdentificationStatus = CASE CurrentIdentification 
                    WHEN 'Exist' THEN 201 
                    WHEN 'Add' THEN 202 
                    WHEN 'Failure' THEN 203 
                    WHEN 'Update' THEN 204 
                    WHEN 'Delete' THEN 205 
                    WHEN 'Error' THEN 206
                    WHEN 'maintenance' THEN 207 
                    WHEN 'Denied' THEN 208
                    WHEN 'SignInFailed' THEN 209 
                    WHEN 'SignInSuccess' THEN 210
                    ELSE NULL END;          
                    return IdentificationStatus;
								END;
                $$;