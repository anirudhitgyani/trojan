
-- Drop All Tables
   SET FOREIGN_KEY_CHECKS = 0; -- Set Foreign Keys Off For Skipping Constraints
    set @AllTableCount = 0;
    SELECT count(*) INTO @AllTableCount
            FROM information_schema.tables 
        WHERE table_schema = 'itgyaniv01';  
        SET @DropTables = NULL;
            SELECT GROUP_CONCAT(table_schema, '.', table_name) INTO @DropTables
                FROM information_schema.tables 
            WHERE table_schema = 'itgyaniv01'; -- specify DB name here.        
        set @TransSQL = case @AllTableCount
        when 0 then CONCAT(
              'select ''No Table Exists''')
        else CONCAT('DROP TABLE ',(SELECT GROUP_CONCAT(table_schema, '.', table_name)
                FROM information_schema.tables 
            WHERE table_schema = 'itgyaniv01'))
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
      
        Insert InTo TransMessages (TransMessageId, TransMessage, TransControl ) Select  '9001' As TransMessageId, 'Sorry For Inconvenience, System Is Under Maintenance. Please Wait For Some Minute''s Or Call To Customer Care For Confirming Start Time. !!!' As TransMessage, 'N/A' As TransControl; 
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
              Union
              Select ''507'' As TransMessageId,  ''Topic With Name @Replace Added Successfully''''s !!!.'' As TransMessage, ''N/A'' As TransControl
              Union
              Select ''508'' As TransMessageId,  ''Error Occurred For Topic @Replace To Upload !!!.'' As TransMessage, ''N/A'' As TransControl
              Union
              Select ''509'' As TransMessageId,  ''Topic With Name  @Replace Already Exist''''s !!!.'' As TransMessage, ''N/A'' As TransControl
              Union
              Select ''510'' As TransMessageId,  ''FAQ With Name @Replace Added Successfully''''s !!!.'' As TransMessage, ''N/A'' As TransControl
              Union
              Select ''511'' As TransMessageId,  ''Error Occurred For FAQ @Replace To Upload !!!.'' As TransMessage, ''N/A'' As TransControl
              Union
              Select ''512'' As TransMessageId,  ''FAQ With Name  @Replace Already Exist''''s !!!.'' As TransMessage, ''N/A'' As TransControl
              Union
              Select ''513'' As TransMessageId,  ''Question Set With Question @Replace Added Successfully''''s !!!.'' As TransMessage, ''N/A'' As TransControl
              Union
              Select ''514'' As TransMessageId,  ''Error Occurred For Question @Replace To Upload !!!.'' As TransMessage, ''N/A'' As TransControl
              Union
              Select ''515'' As TransMessageId,  ''Question Set With Name  @Replace Already Exist''''s !!!.'' As TransMessage, ''N/A'' As TransControl
              ; 
            '; -- #TransMessage
          EXECUTE stmt;
          DEALLOCATE PREPARE stmt;
      -- Create Course Table
      PREPARE stmt FROM 'CREATE TABLE course (
          CourseID SMALLINT NOT NULL AUTO_INCREMENT,
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
      -- Create Topic Table
      PREPARE stmt FROM 'CREATE TABLE topic (
          CourseID SMALLINT NOT NULL ,
          TopicID SMALLINT NOT NULL AUTO_INCREMENT,
          TopicSRNO SMALLINT NOT NULL,
          TopicName VARCHAR(500) NOT NULL,          
          TopicDesc VARCHAR(1000) NOT NULL, 
          URL01 VARCHAR(500)  NULL, 
          URL01Locked TINYINT(1)  NULL,
          URL02 VARCHAR(500)  NULL, 
          URL02Locked TINYINT(1)  NULL,
          URL03 VARCHAR(500)  NULL, 
          URL03Locked TINYINT(1)  NULL,
          URL04 VARCHAR(500)  NULL, 
          URL04Locked TINYINT(1)  NULL,
          Doc01 VARCHAR(500)  NULL, 
          Doc01Locked TINYINT(1)  NULL,
          Doc02 VARCHAR(500)  NULL, 
          Doc02Locked TINYINT(1)  NULL,
          Doc03 VARCHAR(500)  NULL, 
          Doc03Locked TINYINT(1)  NULL,
          Doc04 VARCHAR(500)  NULL, 
          Doc04Locked TINYINT(1)  NULL,
          ChangeLog VARCHAR(1000)  NULL, 
          IsActive TINYINT(1) NOT NULL,
          IsDeleted TINYINT(1) NOT NULL,
          AddUserID SMALLINT(6) NOT NULL,
          AddUserTime TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
          UpdateUserID SMALLINT(6) DEFAULT NULL,
          UpdateUserTime DATETIME NULL,          
          PRIMARY KEY (TopicID),
          FOREIGN KEY (CourseID ) REFERENCES course(CourseID )
        )
        ENGINE = INNODB
        AUTO_INCREMENT = 1
        CHARACTER SET latin1
        COLLATE latin1_swedish_ci;        
        ';
      EXECUTE stmt;
      DEALLOCATE PREPARE stmt;
      -- Create FAQ Table
      PREPARE stmt FROM 'CREATE TABLE faq (
          CourseID SMALLINT NOT NULL ,
          FAQID SMALLINT NOT NULL AUTO_INCREMENT,
          FAQSRNO SMALLINT NOT NULL,
          FAQ VARCHAR(500) NOT NULL,          
          FAQAnswer VARCHAR(1000) NOT NULL,           
          ChangeLog VARCHAR(1000)  NULL, 
          IsActive TINYINT(1) NOT NULL,
          IsDeleted TINYINT(1) NOT NULL,
          AddUserID SMALLINT(6) NOT NULL,
          AddUserTime TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
          UpdateUserID SMALLINT(6) DEFAULT NULL,
          UpdateUserTime DATETIME NULL,          
          PRIMARY KEY (FAQID),
          FOREIGN KEY (CourseID ) REFERENCES course(CourseID )
        )
        ENGINE = INNODB
        AUTO_INCREMENT = 1
        CHARACTER SET latin1
        COLLATE latin1_swedish_ci;        
        ';
      EXECUTE stmt;
      DEALLOCATE PREPARE stmt;
      -- Create FAQ Table
      PREPARE stmt FROM 'CREATE TABLE QuestionSet (
          TopicID SMALLINT(6) NOT NULL ,
          QuestionSetID SMALLINT NOT NULL AUTO_INCREMENT,          
          QuestionSetSrNo SMALLINT NOT NULL,
          Question VARCHAR(500) NOT NULL,          
          Answer01 VARCHAR(1000) NOT NULL,
          IsAnswer01Ok TINYINT(1) NOT NULL,          
          Answer02 VARCHAR(1000) NOT NULL,
          IsAnswer02Ok TINYINT(1) NOT NULL,
          Answer03 VARCHAR(1000)  NULL,
          IsAnswer03Ok TINYINT(1)  NULL,
          Answer04 VARCHAR(1000)  NULL,
          IsAnswer04Ok TINYINT(1)  NULL,
          AnswerTimeInSec SMALLINT NOT NULL,
          ControlType VARCHAR(20)  NULL, 
          ChangeLog VARCHAR(1000)  NULL, 
          IsActive TINYINT(1) NOT NULL,
          IsDeleted TINYINT(1) NOT NULL,
          AddUserID SMALLINT(6) NOT NULL,
          AddUserTime TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
          UpdateUserID SMALLINT(6) DEFAULT NULL,
          UpdateUserTime DATETIME NULL,          
          PRIMARY KEY (QuestionSetID),
          FOREIGN KEY (TopicID ) REFERENCES topic(TopicID )
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
      PREPARE stmt FROM 'CREATE TABLE Maintenance (
          MaintenanceID TINYINT(4) NOT NULL AUTO_INCREMENT,
          MaintenanceName VARCHAR(50) NOT NULL,          
          MaintenanceDesc VARCHAR(255) NOT NULL,
          StartTime TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
          EndTime TIMESTAMP NULL ,          
          AddUserID SMALLINT(6) NOT NULL,
          AddUserTime TIMESTAMP NULL,
          UpdateUserID SMALLINT(6) DEFAULT NULL,
          UpdateUserTime DATETIME NULL,
          PRIMARY KEY (MaintenanceID)
        )
        ENGINE = INNODB
        AUTO_INCREMENT = 1
        CHARACTER SET latin1
        COLLATE latin1_swedish_ci;        
        ';
      EXECUTE stmt;
      DEALLOCATE PREPARE stmt;  
      PREPARE stmt FROM '
          Insert InTo Maintenance ( MaintenanceName,MaintenanceDesc,StartTime,EndTime, AddUserID) 
          Select   ''Test'' As MaintenanceName,''Test'' As MaintenanceDesc,CURRENT_TIMESTAMP StartTime, CURRENT_TIMESTAMP as EndTime,  ''0'' As AddUserID; 
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
                   CALL ExecuteMessage( 'Maintenance' , 9001 , '');
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
              ELSEIF ParaTransType = 105 THEN -- Get Topic From Course
                IF Exists(SELECT * From topic WHERE CourseID = ParaTransValue) THEN
                  SELECT TopicSRNO 'SrNo', TopicName 'TopicName', TopicDesc 'TopicDesc' , 
                  URL01, CASE URL01 WHEN '' THEN '' ELSE CASE WHEN URL01Locked = 0 THEN 'No' Else 'Yes' End End URL01Locked,
                  URL02, CASE URL02 WHEN '' THEN '' ELSE CASE WHEN URL02Locked = 0 THEN 'No' Else 'Yes' End End URL02Locked,
                  URL03, CASE URL03 WHEN '' THEN '' ELSE CASE WHEN URL03Locked = 0 THEN 'No' Else 'Yes' End End URL03Locked,
                  URL04, CASE URL04 WHEN '' THEN '' ELSE CASE WHEN URL04Locked = 0 THEN 'No' Else 'Yes' End End URL04Locked,
                  Doc01, CASE Doc01 WHEN '' THEN '' ELSE CASE WHEN Doc01Locked = 0 THEN 'No' Else 'Yes' End End Doc01Locked,
                  Doc02, CASE Doc02 WHEN '' THEN '' ELSE CASE WHEN Doc02Locked = 0 THEN 'No' Else 'Yes' End End Doc02Locked,
                  Doc03, CASE Doc03 WHEN '' THEN '' ELSE CASE WHEN Doc03Locked = 0 THEN 'No' Else 'Yes' End End Doc03Locked,
                  Doc04, CASE Doc04 WHEN '' THEN '' ELSE CASE WHEN Doc04Locked = 0 THEN 'No' Else 'Yes' End End Doc04Locked,
                  ChangeLog, CASE WHEN IsActive = 0 Then 'No' ELSE 'Yes' End IsActive,
                  CASE WHEN IsDeleted = 0 Then 'No' ELSE 'Yes' End IsDeleted
                  From topic WHERE CourseID = ParaTransValue ORDER BY TopicSRNO;
                Else
                  SELECT  '0' SrNo,  'Topic List Not Available !!!' TopicName,  'Topic List Not Available !!!'  TopicDesc, 
                  'N/A' URL01, 'N/A'  URL01Locked,
                  'N/A' URL02, 'N/A'  URL02Locked,
                  'N/A' URL03, 'N/A'  URL03Locked,
                  'N/A' URL04, 'N/A'  URL04Locked,
                  'N/A' Doc01, 'N/A'  Doc01Locked,
                  'N/A' Doc02, 'N/A'  Doc02Locked,
                  'N/A' Doc03, 'N/A'  Doc03Locked,
                  'N/A' Doc04, 'N/A'  Doc04Locked,
                  'N/A' ChangeLog, 'N/A'  IsActive,
                  'N/A' IsDeleted ;
                End IF;
              ELSEIF ParaTransType = 106 THEN -- Get FAQ From Course
                IF Exists(Select * From faq WHERE CourseID = ParaTransValue)THEN
                  SELECT FAQSRNO 'SrNo',FAQ 'FAQ', FAQAnswer 'FAQAnswer',
                  ChangeLog, CASE WHEN IsActive = 0 Then 'No' ELSE 'Yes' End IsActive,
                  CASE WHEN IsDeleted = 0 Then 'No' ELSE 'Yes' End IsDeleted
                  From faq WHERE CourseID = ParaTransValue ORDER BY FAQSRNO;
                Else
                  SELECT '0' As 'SrNo','FAQ List Doesn''t Exist''s' AS 'FAQ', 'FAQ List Doesn''t Exist''s' AS 'FAQAnswer',
                  'N/A' ChangeLog, 'N/A' IsActive,
                  'N/A' IsDeleted;
                End IF;
              ELSEIF ParaTransType = 107 THEN -- Get Questionset From Topic
                IF Exists(SELECT * From questionset QS INNER JOIN topic TP ON TP.TopicID = QS.TopicID WHERE TP.CourseID = ParaTransValue)THEN
                  SELECT TP.TopicName , TP.TopicID , QS.QuestionSetSrNo, QS.Question,
                        QS.Answer01 , CASE QS.IsAnswer01Ok WHEN 1 THEN 'Yes' ELSE 'No' End As IsAnswer01Ok, 
                        QS.Answer02 , CASE QS.IsAnswer02Ok WHEN 1 THEN 'Yes' ELSE 'No' End As IsAnswer02Ok, 
                        QS.Answer03 , CASE LENGTH(QS.Answer03) When 0 THEN '' ELSE  CASE QS.IsAnswer03Ok WHEN 1 THEN 'Yes' ELSE 'No' End End As IsAnswer03Ok, 
                        QS.Answer04 , CASE LENGTH(QS.Answer04) When 0 THEN '' ELSE  CASE QS.IsAnswer04Ok WHEN 1 THEN 'Yes' ELSE 'No' End End As IsAnswer04Ok, 
                        QS.AnswerTimeInSec, QS.ControlType ,QS.ChangeLog,
                        CASE QS.IsActive WHEN 1 THEN 'Yes' ELSE 'No' End As IsActive,
                        CASE QS.IsDeleted WHEN 1 THEN 'Yes' ELSE 'No' End As IsDeleted  
                  From questionset QS INNER JOIN topic TP ON TP.TopicID = QS.TopicID WHERE TP.CourseID = ParaTransValue ORDER BY TP.TopicID ;
                Else
                  SELECT 'Question Set Not Exists !!!' TopicName , 'Question Set Not Exists!!!' TopicID , 'Question Set Not Exists!!!' QuestionSetSrNo, 'N/A' Question,
                        'N/A' Answer01 , 'N/A'  IsAnswer01Ok, 
                        'N/A' Answer02 , 'N/A'  As IsAnswer02Ok, 
                        'N/A' Answer03 , 'N/A'  As IsAnswer03Ok, 
                        'N/A' Answer04 , 'N/A'  As IsAnswer04Ok, 
                        'N/A' AnswerTimeInSec, 'N/A' ControlType ,'N/A' ChangeLog,
                        'N/A'  As IsActive,
                        'N/A'  As IsDeleted ;
                End IF;
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
  -- Procedure For Managing Upload
        DELIMITER $$;
        DROP PROCEDURE IF EXISTS ManageAdminCourseUpload;
        CREATE PROCEDURE ManageAdminCourseUpload(IN ParaCourseID SMALLINT, IN ParaTopicSRNO SMALLINT, IN ParaTopicName  varchar(1000), IN ParaTopicDesc  varchar(5000), IN ParaURL01  varchar(500), IN ParaURL01Locked  varchar(3), IN ParaURL02  varchar(500), IN ParaURL02Locked  varchar(3), IN ParaURL03  varchar(500), IN ParaURL03Locked  varchar(3), IN ParaURL04  varchar(500), IN ParaURL04Locked  varchar(3),IN ParaDoc01  varchar(500),IN ParaDoc01Locked  varchar(3), IN ParaDoc02  varchar(500), IN ParaDoc02Locked  varchar(3), IN ParaDoc03  varchar(500), IN ParaDoc03Locked  varchar(3), IN ParaDoc04  varchar(500), IN ParaDoc04Locked  varchar(3), IN ParaChangeLog  varchar(1000),IN ParaIsActive varchar(3),IN ParaIsDeleted varchar(3), ParaUserID SMALLINT , ParaRecordID SMALLINT )
        BEGIN
           DECLARE EXIT HANDLER FOR SQLEXCEPTION    
              BEGIN
                  GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, 
                  @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;
                  SET @full_error = CONCAT("ERROR ", @errno, " (", @sqlstate, "): ", @text);
                  Insert InTo errorlog ( ErrorLogNo, ErrorSQLState, ErrorMessage, ErrorObjectName, ErrorObjectValues, AddUserID) 
                  Select   @errno As ErrorLogNo, @sqlstate As ErrorSQLState, @text As ErrorMessage, 'ManageAdminCourseUpload' As ErrorObjectName, Concat('CourseID : ' , ParaCourseID , ' -> ' , ' Topic SR No : ' , ParaTopicSRNO , ' -> ' , ' Topic Name : ' , ParaTopicName,' -> ' , ' UserID ', ParaUserID) As ErrorObjectValues, '0' As AddUserID;           
              End;
              Set ParaTopicName = replace(ParaTopicName , "'" , "''");
              Set ParaTopicDesc = replace(ParaTopicDesc , "'" , "''");
              Set ParaChangeLog = replace(ParaChangeLog , "'" , "''");

              Set ParaURL01 = replace(ParaURL01 , "'" , "''");
              Set ParaURL02 = replace(ParaURL02 , "'" , "''");
              Set ParaURL03 = replace(ParaURL03 , "'" , "''");
              Set ParaURL04 = replace(ParaURL04 , "'" , "''");

              Set ParaDoc01 = replace(ParaDoc01 , "'" , "''");
              Set ParaDoc02 = replace(ParaDoc02 , "'" , "''");
              Set ParaDoc03 = replace(ParaDoc03 , "'" , "''");
              Set ParaDoc04 = replace(ParaDoc04 , "'" , "''");

              IF (UPPER(ParaURL01Locked) = 'YES') Then
                 Set  ParaURL01Locked = '1';
              ElseIF (UPPER(ParaURL01Locked) = 'NO') Then
                 Set  ParaURL01Locked = '0';
              Else
                  Set  ParaURL01Locked = NULL;
              End IF;
              IF (UPPER(ParaURL02Locked) = 'YES') Then
                 Set  ParaURL02Locked = '1';
              ElseIF (UPPER(ParaURL02Locked) = 'NO') Then
                 Set  ParaURL02Locked = '0';
              Else
                  Set  ParaURL02Locked = NULL;
              End IF;
              IF (UPPER(ParaURL03Locked) = 'YES') Then
                 Set  ParaURL03Locked = '1';
              ElseIF (UPPER(ParaURL03Locked) = 'NO') Then
                 Set  ParaURL03Locked = '0';
              Else
                  Set  ParaURL03Locked = NULL;
              End IF;
              IF (UPPER(ParaURL04Locked) = 'YES') Then
                 Set  ParaURL04Locked = '1';
              ElseIF (UPPER(ParaURL04Locked) = 'NO') Then
                 Set  ParaURL04Locked = '0';
              Else
                  Set  ParaURL04Locked = NULL;
              End IF;

              IF (UPPER(ParaDoc01Locked) = 'YES') Then
                 Set  ParaDoc01Locked = '1';
              ElseIF (UPPER(ParaDoc01Locked) = 'NO') Then
                 Set  ParaDoc01Locked = '0';
              Else
                  Set  ParaDoc01Locked = NULL;
              End IF;
              IF ( UPPER(ParaDoc02Locked) = 'YES') Then
                 Set  ParaDoc02Locked = '1';
              ElseIF (UPPER(ParaDoc02Locked) = 'NO') Then
                 Set  ParaDoc02Locked = '0';
              Else
                  Set  ParaDoc02Locked = NULL;
              End IF;
              IF (UPPER(ParaDoc03Locked) = 'YES') Then
                 Set  ParaDoc03Locked = '1';
              ElseIF (UPPER(ParaDoc03Locked) = 'NO') Then
                 Set  ParaDoc03Locked = '0';
              Else
                  Set  ParaDoc03Locked = NULL;
              End IF;
              IF (UPPER(ParaDoc04Locked) = 'YES') Then
                 Set  ParaDoc04Locked = '1';
              ElseIF (UPPER(ParaDoc04Locked) = 'NO') Then
                 Set  ParaDoc04Locked = '0';
              Else
                  Set  ParaDoc04Locked = NULL;
              End IF;

              IF (UPPER(ParaIsActive) = 'YES') Then
                 Set  ParaIsActive = '1';
              ElseIF (UPPER(ParaIsActive) = 'NO') Then
                 Set  ParaIsActive = '0';
              Else
                  Set  ParaIsActive = NULL;
              End IF;

              IF (UPPER(ParaIsDeleted) = 'YES') Then
                 Set  ParaIsDeleted = '1';
              ElseIF (UPPER(ParaIsDeleted) = 'NO') Then
                 Set  ParaIsDeleted = '0';
              Else
                  Set  ParaIsDeleted = NULL;
              End IF;

              IF Not Exists (SELECT * From topic Where CourseID = ParaCourseID And TopicSRNO = ParaTopicSRNO) THEN
                  Insert InTo topic (CourseID,  TopicSRNO, TopicName, TopicDesc, URL01, URL01Locked, URL02, URL02Locked, URL03, URL03Locked, URL04, URL04Locked, Doc01, Doc01Locked, Doc02, Doc02Locked, Doc03, Doc03Locked, Doc04, Doc04Locked, ChangeLog, IsActive, IsDeleted, AddUserID) 
                  Select  ParaCourseID As CourseID,  ParaTopicSRNO As TopicSRNO, ParaTopicName As TopicName, ParaTopicDesc As TopicDesc, ParaURL01 As URL01, ParaURL01Locked As URL01Locked, ParaURL02 As URL02, ParaURL02Locked As URL02Locked, ParaURL03 As URL03, ParaURL03Locked As URL03Locked, ParaURL04 As URL04, ParaURL04Locked As URL04Locked, ParaDoc01 As Doc01, ParaDoc01Locked As Doc01Locked, ParaDoc02 As Doc02, ParaDoc02Locked As Doc02Locked, ParaDoc03 As Doc03, ParaDoc03Locked As Doc03Locked, ParaDoc04 As Doc04, ParaDoc04Locked As Doc04Locked, ParaChangeLog As ChangeLog, ParaIsActive As IsActive, ParaIsDeleted As IsDeleted, ParaUserID As AddUserID; 
                  IF Exists(Select * From topic WHERE CourseID = ParaCourseID And TopicSRNO = ParaTopicSRNO) THEN
                    CALL ExecuteMessage( 'Add' , 507 , ParaTopicName);
                  Else
                     CALL ExecuteMessage( 'Failure' , 508 , ParaTopicName);
                  End IF;
                  
              ElseIF Not Exists (SELECT * From topic Where CourseID = ParaCourseID And TopicSRNO = ParaTopicSRNO AND ChangeLog = ParaChangeLog ) THEN
                  Update topic
                    Set 
                      TopicName = ParaTopicName , 
                      TopicDesc = ParaTopicDesc , 
                      URL01 = ParaURL01 ,
                      URL01Locked = ParaURL01Locked  , 
                      URL02 = ParaURL02 , 
                      URL02Locked = ParaURL02Locked , 
                      URL03 = ParaURL03 , 
                      URL03Locked = ParaURL03Locked, 
                      URL04 = ParaURL04 , 
                      URL04Locked = ParaURL04Locked, 
                      Doc01 = ParaDoc01 , 
                      Doc01Locked = ParaDoc01Locked, 
                      Doc02 = ParaDoc02 , 
                      Doc02Locked = ParaDoc02Locked , 
                      Doc03 = ParaDoc03, 
                      Doc03Locked = ParaDoc03Locked, 
                      Doc04 = ParaDoc04, 
                      Doc04Locked = ParaDoc04Locked, 
                      ChangeLog = ParaChangeLog, 
                      IsActive = ParaIsActive, 
                      IsDeleted = ParaIsDeleted, 
                      UpdateUserID = ParaUserID ,
                      UpdateUserTime = CURRENT_TIMESTAMP
                  Where CourseID = ParaCourseID And TopicSRNO = ParaTopicSRNO;
                      CALL ExecuteMessage( 'Add' , 507 , ParaTopicName);
              Else
                      CALL ExecuteMessage( 'Exist' , 509 , ParaTopicName);
              END IF;
        END$$;
  -- Procedure For Managing FAQ
        DELIMITER $$;
        DROP PROCEDURE IF EXISTS ManageAdminFAQUpload;
        -- Procedure For Managing FAQ        
        DROP PROCEDURE IF EXISTS ManageAdminFAQUpload;
        CREATE PROCEDURE ManageAdminFAQUpload(IN ParaCourseID SMALLINT, IN ParaQSetSRNO SMALLINT, IN ParaQuestion  varchar(1000), IN ParaAnswer01  varchar(5000), IN ParaChangeLog  varchar(1000),IN ParaIsActive varchar(3),IN ParaIsDeleted varchar(3), ParaUserID SMALLINT , ParaRecordID SMALLINT )
        BEGIN
           DECLARE EXIT HANDLER FOR SQLEXCEPTION    
              BEGIN
                  GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, 
                  @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;
                  SET @full_error = CONCAT("ERROR ", @errno, " (", @sqlstate, "): ", @text);
                  Insert InTo errorlog ( ErrorLogNo, ErrorSQLState, ErrorMessage, ErrorObjectName, ErrorObjectValues, AddUserID) 
                  Select   @errno As ErrorLogNo, @sqlstate As ErrorSQLState, @text As ErrorMessage, 'ManageAdminFAQUpload' As ErrorObjectName, Concat('CourseID : ' , ParaCourseID , ' -> ' , ' FAQ SR No : ' , ParaQSetSRNO , ' -> ' , ' FAQ Name : ' , ParaQuestion,' -> ' , ' UserID ', ParaUserID) As ErrorObjectValues, '0' As AddUserID;           
              End;
              Set ParaQuestion = replace(ParaQuestion , "'" , "''");
              Set ParaAnswer01 = replace(ParaAnswer01 , "'" , "''");
              Set ParaChangeLog = replace(ParaChangeLog , "'" , "''");
                        
              IF (UPPER(ParaIsActive) = 'YES') Then
                 Set  ParaIsActive = '1';
              ElseIF (UPPER(ParaIsActive) = 'NO') Then
                 Set  ParaIsActive = '0';
              Else
                  Set  ParaIsActive = NULL;
              End IF;

              IF (UPPER(ParaIsDeleted) = 'YES') Then
                 Set  ParaIsDeleted = '1';
              ElseIF (UPPER(ParaIsDeleted) = 'NO') Then
                 Set  ParaIsDeleted = '0';
              Else
                  Set  ParaIsDeleted = NULL;
              End IF;

              IF Not Exists (SELECT * From faq Where CourseID = ParaCourseID And FAQSRNO = ParaQSetSRNO) THEN
                  Insert InTo faq (CourseID,  FAQSRNO, FAQ, FAQAnswer,  ChangeLog, IsActive, IsDeleted, AddUserID) 
                  Select  ParaCourseID As CourseID,  ParaQSetSRNO As FAQSRNO, ParaQuestion As FAQ, ParaAnswer01 As FAQAnswer, ParaChangeLog As ChangeLog, ParaIsActive As IsActive, ParaIsDeleted As IsDeleted, ParaUserID As AddUserID; 
                  IF Exists(Select * From faq WHERE CourseID = ParaCourseID And FAQSRNO = ParaQSetSRNO) THEN
                    CALL ExecuteMessage( 'Add' , 510 , ParaQuestion);
                  Else
                     CALL ExecuteMessage( 'Failure' , 511 , ParaQuestion);
                  End IF;
                  
              ElseIF Not Exists (SELECT * From faq Where CourseID = ParaCourseID And FAQSRNO = ParaQSetSRNO AND ChangeLog = ParaChangeLog ) THEN
                  Update faq
                    Set 
                      FAQ = ParaQuestion , 
                      FAQAnswer = ParaAnswer01 ,                       
                      ChangeLog = ParaChangeLog, 
                      IsActive = ParaIsActive, 
                      IsDeleted = ParaIsDeleted, 
                      UpdateUserID = ParaUserID ,
                      UpdateUserTime = CURRENT_TIMESTAMP
                  Where CourseID = ParaCourseID And FAQSRNO = ParaQSetSRNO;
                      CALL ExecuteMessage( 'Add' , 510 , ParaQuestion);
              Else
                      CALL ExecuteMessage( 'Exist' , 512 , ParaQuestion);
              END IF;
        END$$;
  -- Procedure For Managing QSet Transaction                        
                DELIMITER $$;
        DROP PROCEDURE IF EXISTS ManageAdminQSetUpload;
        CREATE PROCEDURE ManageAdminQSetUpload(IN ParaCourseID SMALLINT, IN ParaTopicID SMALLINT, IN ParaQSetSRNO SMALLINT, IN ParaQuestion  varchar(1000), IN ParaAnswer01  varchar(1000), IN ParaAnswer01Correct  varchar(5), IN ParaAnswer02  varchar(1000), IN ParaAnswer02Correct  varchar(5), IN ParaAnswer03  varchar(1000), IN ParaAnswer03Correct  varchar(5), IN ParaAnswer04  varchar(1000), IN ParaAnswer04Correct  varchar(5), IN ParaAnswerTimeInSec SMALLINT,IN ParaControlType VARCHAR(20), IN ParaChangeLog  varchar(1000),IN ParaIsActive varchar(3),IN ParaIsDeleted varchar(3), ParaUserID SMALLINT , ParaRecordID SMALLINT )
        BEGIN
           DECLARE EXIT HANDLER FOR SQLEXCEPTION    
              BEGIN
                  GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, 
                  @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;
                  SET @full_error = CONCAT("ERROR ", @errno, " (", @sqlstate, "): ", @text);
                  Insert InTo errorlog ( ErrorLogNo, ErrorSQLState, ErrorMessage, ErrorObjectName, ErrorObjectValues, AddUserID) 
                  Select   @errno As ErrorLogNo, @sqlstate As ErrorSQLState, @text As ErrorMessage, 'ManageAdminQSetUpload' As ErrorObjectName, Concat('CourseID : ' , ParaCourseID , ' -> ' , ' Topic ID : ' , ParaTopicID , ' -> ' , ' Question : ' , ParaQuestion,' -> ' , ' UserID ', ParaUserID) As ErrorObjectValues, '0' As AddUserID;           
              End;
              Set ParaQuestion = replace(ParaQuestion , "'" , "''");
              Set ParaChangeLog = replace(ParaChangeLog , "'" , "''");

              Set ParaAnswer01 = replace(ParaAnswer01 , "'" , "''");
              Set ParaAnswer02 = replace(ParaAnswer02 , "'" , "''");
              Set ParaAnswer03 = replace(ParaAnswer03 , "'" , "''");
              Set ParaAnswer04 = replace(ParaAnswer04 , "'" , "''");
                     
                 
              IF (UPPER(ParaAnswer01Correct) = 'YES') Then
                 Set  ParaAnswer01Correct = '1';
              ElseIF (UPPER(ParaAnswer01Correct) = 'NO') Then
                 Set  ParaAnswer01Correct = '0';
              Else
                  Set  ParaAnswer01Correct = NULL;
              End IF;
              
              IF (UPPER(ParaAnswer02Correct) = 'YES') Then
                 Set  ParaAnswer02Correct = '1';
              ElseIF (UPPER(ParaAnswer02Correct) = 'NO') Then
                 Set  ParaAnswer02Correct = '0';
              Else
                  Set  ParaAnswer02Correct = NULL;
              End IF;
              
              IF (UPPER(ParaAnswer03Correct) = 'YES') Then
                 Set  ParaAnswer03Correct = '1';
              ElseIF (UPPER(ParaAnswer03Correct) = 'NO') Then
                 Set  ParaAnswer03Correct = '0';
              Else
                  Set  ParaAnswer03Correct = NULL;
              End IF;
              
              IF (UPPER(ParaAnswer04Correct) = 'YES') Then
                 Set  ParaAnswer04Correct = '1';
              ElseIF (UPPER(ParaAnswer04Correct) = 'NO') Then
                 Set  ParaAnswer04Correct = '0';
              Else
                  Set  ParaAnswer04Correct = NULL;
              End IF;

              IF (UPPER(ParaIsActive) = 'YES') Then
                 Set  ParaIsActive = '1';
              ElseIF (UPPER(ParaIsActive) = 'NO') Then
                 Set  ParaIsActive = '0';
              Else
                  Set  ParaIsActive = NULL;
              End IF;

              IF (UPPER(ParaIsDeleted) = 'YES') Then
                 Set  ParaIsDeleted = '1';
              ElseIF (UPPER(ParaIsDeleted) = 'NO') Then
                 Set  ParaIsDeleted = '0';
              Else
                  Set  ParaIsDeleted = NULL;
              End IF;
              
              IF Not Exists (SELECT * From questionset Where TopicID = ParaTopicID AND QuestionSetSrNo = ParaQSetSRNO) THEN
                  Insert InTo questionset (TopicID,  QuestionSetSrNo, Question, Answer01, IsAnswer01Ok, Answer02, IsAnswer02Ok, Answer03, IsAnswer03Ok, Answer04, IsAnswer04Ok, AnswerTimeInSec, ControlType, ChangeLog, IsActive, IsDeleted, AddUserID) 
                      Select  TP.TopicID As TopicID,  ParaQSetSRNO As QuestionSetSrNo, ParaQuestion As Question, ParaAnswer01 As Answer01, ParaAnswer01Correct As IsAnswer01Ok, ParaAnswer02 As Answer02, ParaAnswer02Correct As IsAnswer02Ok, ParaAnswer03 As Answer03, ParaAnswer03Correct As IsAnswer03Ok, ParaAnswer04 As Answer04, ParaAnswer04Correct As IsAnswer04Ok, ParaAnswerTimeInSec As AnswerTimeInSec, ParaControlType As ControlType, ParaChangeLog As ChangeLog, ParaIsActive As IsActive, ParaIsDeleted As IsDeleted, ParaUserID As AddUserID
                      FROM topic TP  Where CourseID = ParaCourseID AND TopicID = ParaTopicID;

                  IF Exists(SELECT * From questionset Where TopicID = ParaTopicID AND QuestionSetSrNo = ParaQSetSRNO) THEN
                    CALL ExecuteMessage( 'Add' , 513 , ParaQuestion);
                  Else
                     CALL ExecuteMessage( 'Failure' , 514 , ParaQuestion);
                  End IF;
                  
              ElseIF Not Exists (SELECT * From questionset Where TopicID = ParaTopicID AND QuestionSetSrNo = ParaQSetSRNO AND ChangeLog = ParaChangeLog ) THEN
                  UPDATE questionset 
                      Set   QuestionSetSrNo = ParaQSetSRNO , 
                            Question = ParaQuestion, 
                            Answer01 = ParaAnswer01 , 
                            IsAnswer01Ok = ParaAnswer01Correct, 
                            Answer02 = ParaAnswer02, 
                            IsAnswer02Ok = ParaAnswer02Correct, 
                            Answer03 = ParaAnswer03 , 
                            IsAnswer03Ok = ParaAnswer03Correct,
                            Answer04 = ParaAnswer04, 
                            IsAnswer04Ok = ParaAnswer04Correct, 
                            AnswerTimeInSec = ParaAnswerTimeInSec, 
                            ControlType = ParaControlType, 
                            ChangeLog = ParaChangeLog, 
                            IsActive = ParaIsActive, 
                            IsDeleted = ParaIsDeleted, 
                            UpdateUserID = ParaUserID ,
                            UpdateUserTime = CURRENT_TIMESTAMP
                      WHERE TopicID = ParaTopicID AND QuestionSetSrNo = ParaQSetSRNO;
                                        
                      CALL ExecuteMessage( 'Add' , 513 , ParaQuestion);
              Else
                      CALL ExecuteMessage( 'Exist' , 515 , ParaQuestion);
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
                    WHEN 'Maintenance' THEN 207 
                    WHEN 'Denied' THEN 208
                    WHEN 'SignInFailed' THEN 209 
                    WHEN 'SignInSuccess' THEN 210
                    ELSE NULL END;          
                    return IdentificationStatus;
								END;
                $$;