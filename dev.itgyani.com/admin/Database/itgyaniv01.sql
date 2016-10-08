
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

      PREPARE stmt FROM 'CREATE TABLE adminpanel(
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
          Insert InTo adminpanel( GroupID, AdminEmail, AdminPassword, IsActive, IsDeleted, AddUserID) 
          Select ''1'' As GroupID, ''ashish.sharma14@gmail.com'' As AdminEmail, ''6523a5ddae77c83d598712f1507069935bdc8760'' As AdminPassword, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID; 
        ';
      EXECUTE stmt;
      DEALLOCATE PREPARE stmt;
      -- Create Trans Message's Table
      PREPARE stmt FROM 'CREATE TABLE transmessages (         
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
      ALTER TABLE transmessages AUTO_INCREMENT=501;
      
        Insert InTo transmessages (TransMessageId, TransMessage, TransControl ) Select  '9001' As TransMessageId, 'Sorry For Inconvenience, System Is Under Maintenance. Please Wait For Some Minute''s Or Call To Customer Care For Confirming Start Time. !!!' As TransMessage, 'N/A' As TransControl; 
        Insert InTo transmessages (TransMessageId, TransMessage, TransControl ) Select  '9002' As TransMessageId, '@Replace !!!' As TransMessage, 'N/A' As TransControl; 
          
          PREPARE stmt FROM 
            '
              Insert InTo transmessages (TransMessageId, TransMessage, TransControl ) 
              Select ''501'' As TransMessageId,  ''Login Failed. Please, Check Spelling Mistakes, Caps Lock Status For Valid Password Entry'' As TransMessage, ''user_name'' As TransControl
              Union
              Select ''502'' As TransMessageId,  ''Login Successfull.'' As TransMessage, ''user_name'' As TransControl
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
              Union
              Select ''516'' As TransMessageId,  ''Student With Name @Replace Already Exist''''s !!!.'' As TransMessage, ''N/A'' As TransControl
              Union
              Select ''517'' As TransMessageId,  ''Student With Name  @Replace Registered Successfully !!!.'' As TransMessage, ''N/A'' As TransControl
              Union
              Select ''518'' As TransMessageId,  ''Career Path With Title @Replace Already Exist''''s !!!.'' As TransMessage, ''ITGTxtCareerPath'' As TransControl
              Union
              Select ''519'' As TransMessageId,  ''Career Path With Title @Replace Added Successfully !!!.'' As TransMessage, ''ITGTxtCareerPath'' As TransControl
              Union
              Select ''520'' As TransMessageId,  ''Career Path With Title @Replace Updated Successfully !!!.'' As TransMessage, ''ITGTxtCareerPath'' As TransControl
              Union
              Select ''521'' As TransMessageId,  ''Career Path With Title @Replace Deleted Successfully !!!.'' As TransMessage, ''ITGTxtCareerPath'' As TransControl
              Union
              Select ''522'' As TransMessageId,  ''Career Path Course With ID @Replace Already Exist''''s !!!.'' As TransMessage, ''N/A'' As TransControl
              Union
              Select ''523'' As TransMessageId,  ''Career Path Course With ID @Replace Added Successfully !!!.'' As TransMessage, ''N/A'' As TransControl
              Union
              Select ''524'' As TransMessageId,  ''Career Path Course With ID @Replace Updated Successfully !!!.'' As TransMessage, ''N/A'' As TransControl
              Union
              Select ''525'' As TransMessageId,  ''Career Path Course With ID @Replace Deleted Successfully !!!.'' As TransMessage, ''N/A'' As TransControl
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
          IsDafult TINYINT(1) DEFAULT ''1'',
          
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
        PREPARE stmt FROM '
          Insert InTo course ( CourseName, CourseDesc, ImageName, ImageData, IsActive, IsDeleted,IsDafult, AddUserID) 
          Select   ''Pre-Foundation'' As CourseName, ''Pre-Foundation Course. Default and free to all registed students. Need to complete it, At first'' As CourseDesc, ''N/A'' As ImageName, ''N/A'' As ImageData, ''1'' As IsActive , ''0'' As IsDeleted,''1'' As  IsDafult, ''1'' As AddUserID
          Union
          Select   ''Foundation'' As CourseName, ''Foundation Course. Default and free to all registed students. Need to complete it, after prefoundation.'' As CourseDesc, ''N/A'' As ImageName, ''N/A'' As ImageData, ''1'' As IsActive, ''0'' As IsDeleted , ''1'' As  IsDafult,''1'' As AddUserID
          ; 
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
      -- Create State Table
      PREPARE stmt FROM 'CREATE TABLE city (
          StateID TINYINT(4) NOT NULL,
          CityID int NOT NULL AUTO_INCREMENT,
          CityName VARCHAR(50) NOT NULL,          
          IsActive TINYINT(1) NOT NULL,
          IsDeleted TINYINT(1) NOT NULL,
          AddUserID SMALLINT(6) NOT NULL,
          AddUserTime TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
          UpdateUserID SMALLINT(6) DEFAULT NULL,
          UpdateUserTime DATETIME NULL,          
          FOREIGN KEY (StateID ) REFERENCES state(StateID ),
          PRIMARY KEY (CityID)
        )
        ENGINE = INNODB
        AUTO_INCREMENT = 1
        CHARACTER SET latin1
        COLLATE latin1_swedish_ci;        
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
      -- Create Error Log
      PREPARE stmt FROM 'CREATE TABLE errorlog (
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
  -- Create Career Path Table
      PREPARE stmt FROM 'CREATE TABLE careerpath (
          CareerPathID INT NOT NULL AUTO_INCREMENT,
          CareerPathTitle VARCHAR(50) NOT NULL,          
          CareerPathDesc VARCHAR(500) NOT NULL, 
          IsActive TINYINT(1) NOT NULL,
          IsDeleted TINYINT(1) NOT NULL,
          AddUserID SMALLINT(6) NOT NULL,
          AddUserTime TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
          UpdateUserID SMALLINT(6) DEFAULT NULL,
          UpdateUserTime DATETIME NULL,
          UNIQUE (CareerPathTitle),
          PRIMARY KEY (CareerPathID)
        )
        ENGINE = INNODB
        AUTO_INCREMENT = 1
        CHARACTER SET latin1
        COLLATE latin1_swedish_ci;        
        ';
      EXECUTE stmt;
      DEALLOCATE PREPARE stmt;
      -- Create Career Path Table
      PREPARE stmt FROM 'CREATE TABLE careerpathcourse (
          CareerPathID INT NOT NULL ,
          CareerPathCourseID SMALLINT NOT NULL ,
          CareerPathCoursePID smallint NOT NULL AUTO_INCREMENT,                              
          IsActive TINYINT(1) NOT NULL,
          AddUserID SMALLINT(6) NOT NULL,
          AddUserTime TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
          UpdateUserID SMALLINT(6) DEFAULT NULL,
          UpdateUserTime DATETIME NULL,
          FOREIGN KEY ITG_FK_CareerPathID_$careerpath$TO$careerpath (CareerPathID) REFERENCES careerpath(CareerPathID),
          FOREIGN KEY ITG_FK_CareerPathCourseID_$careerpath$TO$course (CareerPathCourseID) REFERENCES course(CourseID),
          PRIMARY KEY (CareerPathCoursePID)
        )
        ENGINE = INNODB
        AUTO_INCREMENT = 1
        CHARACTER SET latin1
        COLLATE latin1_swedish_ci;        
        ';
      EXECUTE stmt;
      DEALLOCATE PREPARE stmt;
  -- Create Profile Table
      PREPARE stmt FROM 'CREATE TABLE profile (
          GroupID TINYINT(4) NOT NULL ,
          CareerPathID INT NULL,
          ProfileID TINYINT(4) NOT NULL AUTO_INCREMENT,
          ProfileName VARCHAR(50) NOT NULL,
          ProfileEmail VARCHAR(50) NOT NULL,          
          ProfilePassword VARCHAR(50) NULL,
          ProfilePicture VARCHAR(1000) NULL,          
          ProfileFirstName VARCHAR(50) NULL,
          ProfileLastName VARCHAR(50) NULL,
          ProfileMobile VARCHAR(10) NULL,
          ProfileDBO DATE NULL,
          ProfileGender VARCHAR(10) NULL,
          ProfileCompanyName VARCHAR(50) NULL,
          IsFaceBook TINYINT(1) NOT NULL,
          IsFaceGmail TINYINT(1) NOT NULL,
          IsPaid TINYINT(1) NOT NULL,
          ExpiryDate DATETIME NULL DEFAULT NULL,
          IsActived TINYINT(1) NOT NULL DEFAULT ''0'',
          IsActive TINYINT(1) NOT NULL,
          IsDeleted TINYINT(1) NOT NULL,
          AddUserID SMALLINT(6) NOT NULL,
          AddUserTime TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
          UpdateUserID SMALLINT(6) DEFAULT NULL,
          UpdateUserTime DATETIME NULL,
          UNIQUE (ProfileEmail),
          PRIMARY KEY (ProfileID),
          FOREIGN KEY (GroupID) REFERENCES usergroup(GroupID), 
          FOREIGN KEY (CareerPathID) REFERENCES careerpath(CareerPathID)
        )
        ENGINE = INNODB
        AUTO_INCREMENT = 1
        CHARACTER SET latin1
        COLLATE latin1_swedish_ci;        
        ';
      EXECUTE stmt;
      DEALLOCATE PREPARE stmt;
      -- Create Profile Course
      PREPARE stmt FROM 'CREATE TABLE profilecourse (
          ProfileID TINYINT(4) NOT NULL ,
          CourseID INT NULL,
          IsCurrent TINYINT(1) NOT NULL DEFAULT ''0'',
          ProfileCourseID TINYINT(4) NOT NULL AUTO_INCREMENT,                    
          IsComplete TINYINT(1) NOT NULL DEFAULT ''0'',
          PRIMARY KEY (ProfileCourseID),
          FOREIGN KEY (ProfileID) REFERENCES profile(ProfileID)
        )
        ENGINE = INNODB
        AUTO_INCREMENT = 1
        CHARACTER SET latin1
        COLLATE latin1_swedish_ci;        
        ';
      EXECUTE stmt;
      DEALLOCATE PREPARE stmt;
      -- Create Topic Table
      PREPARE stmt FROM 'CREATE TABLE profiletopic (
          ProfileCourseID TINYINT(4) NULL ,
          ProfileTopicRowID SMALLINT NOT NULL AUTO_INCREMENT,
          IsCurrent TINYINT(1)  NULL Default ''0'',
          TopicID SMALLINT NOT NULL ,
          TopicSRNO SMALLINT NOT NULL,       
          TopicName VARCHAR(500) NOT NULL,
          TopicDesc VARCHAR(1000) NOT NULL,    
          URL01 VARCHAR(500)  NULL, 
          URL01Locked TINYINT(1)  NULL,
          URL01Status TINYINT(1)  NULL,
          URL02 VARCHAR(500)  NULL, 
          URL02Locked TINYINT(1)  NULL,
          URL02Status TINYINT(1)  NULL,
          URL03 VARCHAR(500)  NULL, 
          URL03Locked TINYINT(1)  NULL,
          URL03Status TINYINT(1)  NULL,
          URL04 VARCHAR(500)  NULL, 
          URL04Locked TINYINT(1)  NULL,
          URL04Status TINYINT(1)  NULL,
          Doc01 VARCHAR(500)  NULL, 
          Doc01Locked TINYINT(1)  NULL,
          Doc01Status TINYINT(1)  NULL,
          Doc02 VARCHAR(500)  NULL, 
          Doc02Locked TINYINT(1)  NULL,
          Doc02Status TINYINT(1)  NULL,
          Doc03 VARCHAR(500)  NULL, 
          Doc03Locked TINYINT(1)  NULL,
          Doc03Status TINYINT(1)  NULL,
          Doc04 VARCHAR(500)  NULL, 
          Doc04Locked TINYINT(1)  NULL,
          Doc04Status TINYINT(1)  NULL,          
          PRIMARY KEY (ProfileTopicRowID),
          FOREIGN KEY (ProfileCourseID ) REFERENCES profilecourse(ProfileCourseID )
        )
        ENGINE = INNODB
        AUTO_INCREMENT = 1
        CHARACTER SET latin1
        COLLATE latin1_swedish_ci;        
        ';
      EXECUTE stmt;
      DEALLOCATE PREPARE stmt;
      -- Create register user Table
      PREPARE stmt FROM 'CREATE TABLE IF NOT EXISTS `registered_users` (
                `id` int(8) NOT NULL AUTO_INCREMENT,
                `user_name` varchar(255) NOT NULL,
                `first_name` varchar(255) NOT NULL,
                `last_name` varchar(255) NOT NULL,
                `fb_id` varchar(255) DEFAULT NULL,
                `oauth_uid` varchar(255) DEFAULT NULL,
                `company_name` varchar(255) NOT NULL,
                `mobile` varchar(255) NOT NULL,
                `dateofbirth` varchar(255) NOT NULL,
                `password` varchar(255) NOT NULL,
                `email` varchar(55) NOT NULL,
                `gender` varchar(20) NOT NULL,
                `created_date` date NOT NULL,
                `status` varchar(10) NOT NULL DEFAULT ''Inactive'',
                PRIMARY KEY (`id`)
              ) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=12 ;
        ';
      EXECUTE stmt;
      DEALLOCATE PREPARE stmt;
      -- Create student register Table
      PREPARE stmt FROM 'CREATE TABLE IF NOT EXISTS `student_register` (
                `id` int(8) NOT NULL AUTO_INCREMENT,
                `user_name` varchar(255) NOT NULL,
                `first_name` varchar(255) NOT NULL,
                `last_name` varchar(255) NOT NULL,
                `fb_id` varchar(255) DEFAULT NULL,
                `oauth_uid` varchar(255) DEFAULT NULL,
                `mobile` varchar(255) NOT NULL,
                `dateofbirth` varchar(255) NOT NULL,
                `password` varchar(255) NOT NULL,
                `email` varchar(55) NOT NULL,
                `gender` varchar(20) NOT NULL,
                `created_date` date NOT NULL,
                `status` varchar(10) NOT NULL DEFAULT ''Inactive'',
                PRIMARY KEY (`id`)
              ) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=16 ;
        ';
      EXECUTE stmt;
      DEALLOCATE PREPARE stmt;
      
      
      -- Create Standard Properties Group

      PREPARE stmt FROM 'CREATE TABLE standardpropertygroup (
          StandardPropID tinyint NOT NULL AUTO_INCREMENT,
          StandardPropName VARCHAR(50) NOT NULL,                    
          IsActive TINYINT(1) NOT NULL,
          IsDeleted TINYINT(1) NOT NULL,
          AddUserID SMALLINT(6) NOT NULL,
          AddUserTime TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
          UpdateUserID SMALLINT(6) DEFAULT NULL,
          UpdateUserTime DATETIME NULL,
          UNIQUE (StandardPropName),
          PRIMARY KEY (StandardPropID)
        )
        ENGINE = INNODB
        AUTO_INCREMENT = 1
        CHARACTER SET latin1
        COLLATE latin1_swedish_ci;        
        ';
      EXECUTE stmt;
      DEALLOCATE PREPARE stmt;        
      -- Create Standard Properties List
      PREPARE stmt FROM 'CREATE TABLE standardpropertylist (
          StandardPropID TINYINT(4) NOT NULL ,
          StandardPropListID int NOT NULL AUTO_INCREMENT,
          StandardPropListName VARCHAR(500) NOT NULL,                    
          IsActive TINYINT(1) NOT NULL,
          IsDeleted TINYINT(1) NOT NULL,
          AddUserID SMALLINT(6) NOT NULL,
          AddUserTime TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
          UpdateUserID SMALLINT(6) DEFAULT NULL,
          UpdateUserTime DATETIME NULL,
          FOREIGN KEY (StandardPropID) REFERENCES standardpropertygroup(StandardPropID),          
          PRIMARY KEY (StandardPropListID)
        )
        ENGINE = INNODB
        AUTO_INCREMENT = 1
        CHARACTER SET latin1
        COLLATE latin1_swedish_ci;        
        ';
      EXECUTE stmt;
      DEALLOCATE PREPARE stmt; 
      -- Create Profile Academic
      PREPARE stmt FROM 'CREATE TABLE academic (
          AcademicID TINYINT(4) NOT NULL AUTO_INCREMENT,
          ProfileID TINYINT(4) NOT NULL,
          10ThBoard int  NULL ,
          10ThSchoolName VARCHAR(50) NOT NULL,
          10ThPercentage VARCHAR(5) NOT NULL,
          10ThPassingYear VARCHAR(4) NOT NULL,
          12ThBoard int NOT NULL ,
          12ThCollegeName VARCHAR(50) NOT NULL,
          12ThPercentage VARCHAR(5) NOT NULL,
          12ThPassingYear VARCHAR(4) NOT NULL,
          GraduationUniversity int NOT NULL ,
          GraduationCollegeName VARCHAR(50) NOT NULL,
          GraduationPercentage VARCHAR(5) NOT NULL,
          GraduationPassingYear VARCHAR(4) NOT NULL,
          GraduationPassing01Year VARCHAR(4) NOT NULL,
          GraduationPassing01Per VARCHAR(5) NOT NULL,
          GraduationPassing02Year VARCHAR(4) NOT NULL,
          GraduationPassing02Per VARCHAR(5) NOT NULL,
          GraduationPassing03Year VARCHAR(4) NOT NULL,
          GraduationPassing03Per VARCHAR(5) NOT NULL,
          GraduationPassing04Year VARCHAR(4) NOT NULL,
          GraduationPassing04Per VARCHAR(5) NOT NULL,
          InstituteID int NOT NULL ,
          ExternalCertificationName VARCHAR(50) NOT NULL,
          ExternalCertificationPassingYear VARCHAR(4) NOT NULL,
          ExternalCertificationPassingPer VARCHAR(5) NOT NULL,
          AddUserID SMALLINT(6) NOT NULL,
          AddUserTime TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
          UpdateUserID SMALLINT(6) DEFAULT NULL,
          UpdateUserTime DATETIME NULL,          
          PRIMARY KEY (AcademicID),
          FOREIGN KEY (ProfileID) REFERENCES profile(ProfileID),
          FOREIGN KEY (10ThBoard) REFERENCES standardpropertylist(StandardPropListID),
          FOREIGN KEY (12ThBoard) REFERENCES standardpropertylist(StandardPropListID),
          FOREIGN KEY (GraduationUniversity) REFERENCES standardpropertylist(StandardPropListID),
          FOREIGN KEY (InstituteID) REFERENCES standardpropertylist(StandardPropListID)
        )
        ENGINE = INNODB
        AUTO_INCREMENT = 1
        CHARACTER SET latin1
        COLLATE latin1_swedish_ci;        
        ';
      EXECUTE stmt;
      DEALLOCATE PREPARE stmt;
  -- Create Profile Biodata
      PREPARE stmt FROM 'CREATE TABLE biodata (
          BiodataID TINYINT(4) NOT NULL AUTO_INCREMENT,
          ProfileID TINYINT(4) NOT NULL,          
          LastName VARCHAR(50) NOT NULL,
          FirstName VARCHAR(50) NOT NULL,
          MiddleName VARCHAR(50) NOT NULL,
          DateOfBirth TIMESTAMP NOT NULL,          
          Address VARCHAR(500) NOT NULL,
          CityID INT NOT NULL,
          PinCode VARCHAR(8) NOT NULL,
          Email VARCHAR(50) NOT NULL,
          Mobile VARCHAR(10) NOT NULL,
          Photo VARCHAR(1000) NOT NULL,
          PanCard VARCHAR(50) NOT NULL,
          PassportNo VARCHAR(50) NOT NULL,
          PassportExpiryDate TIMESTAMP NOT NULL,          
          AddUserID SMALLINT(6) NOT NULL,
          AddUserTime TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
          UpdateUserID SMALLINT(6) DEFAULT NULL,
          UpdateUserTime DATETIME NULL,          
          PRIMARY KEY (BiodataID),
          FOREIGN KEY (ProfileID) REFERENCES profile(ProfileID),
          FOREIGN KEY (CityID) REFERENCES city(CityID)
        )
        ENGINE = INNODB
        AUTO_INCREMENT = 1
        CHARACTER SET latin1
        COLLATE latin1_swedish_ci;        
        ';
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
              Select TransactionStatusCode(ParaCurrentIdentification ) as 'ResultID', TMS.TransMessageId,  REPLACE(TMS.TransMessage , '@Replace' ,CONCAT( '[ ' , ParaReplaceWord , ' ]'))  as  TransMessage, TMS.TransControl From transmessages TMS Where TMS.TransMessageId = ParaTransMessageId ;
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
              If Exists(Select * From Maintenance Where EndTime IS NULL) THEN
                   CALL ExecuteMessage( 'Maintenance' , 9001 , '');
              ElseIf Exists(Select * From adminpanel WHERE AdminEmail = ParaEmail And AdminPassword = ParaPassword) THEN
                  CALL ExecuteMessage( 'SignInSuccess' , 502 , '');
              Else
                  CALL ExecuteMessage( 'SignInFailed' , 501 , '');
              End IF;
          
        END$$;
-- Procedure For PortalSignIn
        DELIMITER $$;
        DROP PROCEDURE IF EXISTS `ManagePortalSignIn`;
        CREATE  PROCEDURE `ManagePortalSignIn`(IN ParaEmail VARCHAR(50), IN ParaPassword VARCHAR(5000))
        BEGIN
          DECLARE EXIT HANDLER FOR SQLEXCEPTION    
          BEGIN
              GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, 
              @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;
              SET @full_error = CONCAT("ERROR ", @errno, " (", @sqlstate, "): ", @text);
              Insert InTo errorlog ( ErrorLogNo, ErrorSQLState, ErrorMessage, ErrorObjectName, ErrorObjectValues, AddUserID) 
              Select   @errno As ErrorLogNo, @sqlstate As ErrorSQLState, @text As ErrorMessage, 'ManagePortalSignIn' As ErrorObjectName, Concat('Email : ' , ParaEmail , ' -> ' , ' Password : ' , ParaPassword) As ErrorObjectValues, '0' As AddUserID;           
          End;
              If Exists(Select * From Maintenance Where EndTime IS NULL) THEN
                   CALL ExecuteMessage( 'Maintenance' , 9001 , '');
              ElseIf Exists(Select * From profile WHERE ProfileEmail = ParaEmail And ProfilePassword = ParaPassword) THEN
                  CALL ExecuteMessage( 'SignInSuccess' , 502 , ParaEmail);
              Else
                  CALL ExecuteMessage( 'SignInFailed' , 501 , ParaEmail);
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
                Set ParaUserID = (Select AdminID From adminpanel Where AdminEmail = ParaTranString LIMIT 1) ;
              End if;
              If ParaTransType = 101 THEN
                  Select GroupID, AdminID, AdminEmail, AdminPassword, IsActive, IsDeleted  From adminpanel WHERE AdminEmail =  ParaTranString;
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
              ELSEIF ParaTransType = 108 THEN -- Execute Portal Login
                  SELECT  GroupID , ProfileID ,IFNULL(ProfileName, '') ProfileName , IFNULL(ProfileEmail, '') ProfileEmail , IFNULL( ProfilePassword , '') ProfilePassword , IFNULL( ProfilePicture , '') ProfilePicture , IFNULL( IsFaceBook , '') IsFaceBook , IFNULL( IsFaceGmail , '') IsFaceGmail , IFNULL( IsPaid , '') IsPaid , IFNULL( ExpiryDate , '') ExpiryDate, IFNULL( IsActive , '') IsActive, IFNULL( IsDeleted , '') IsDeleted FROM profile WHERE ProfileEmail = ParaTranString;
              ELSEIF ParaTransType = 109 THEN -- Get Topic List
                  SELECT TopicID , TopicName FROM topic WHERE CourseID = ParaTransValue;
              ELSEIF ParaTransType = 110 THEN -- Get Topic Video  /   Docs             
                      SELECT TopicID, TopicSRNO, TopicName,TopicDesc 
                              , CASE URL01Locked WHEN '1' THEN CONCAT( LEFT( URL01 , 10) , ' ... ' ) ELSE URL01 End URL01 , URL02Locked, CASE URL02Locked WHEN '1' THEN CONCAT( LEFT( URL02 , 10) , ' ... ' ) ELSE URL02 End URL02 , URL02Locked
                              , CASE URL03Locked WHEN '1' THEN CONCAT( LEFT( URL03 , 10) , ' ... ' ) ELSE URL03 End URL03 , URL03Locked, CASE URL04Locked WHEN '1' THEN CONCAT( LEFT( URL04 , 10) , ' ... ' ) ELSE URL04 End URL04 , URL04Locked
                              , CASE DOC01Locked WHEN '1' THEN CONCAT( LEFT( DOC01 , 10) , ' ... ' ) ELSE DOC01 End DOC01 , DOC02Locked, CASE DOC02Locked WHEN '1' THEN CONCAT( LEFT( DOC02 , 10) , ' ... ' ) ELSE DOC02 End DOC02 , DOC02Locked
                              , CASE DOC03Locked WHEN '1' THEN CONCAT( LEFT( DOC03 , 10) , ' ... ' ) ELSE DOC03 End DOC03 , DOC03Locked, CASE DOC04Locked WHEN '1' THEN CONCAT( LEFT( DOC04 , 10) , ' ... ' ) ELSE DOC04 End DOC04 , DOC04Locked
                        FROM topic WHERE CourseID = ParaTransValue AND IsActive  = '1' AND IsDeleted = '0';
              ELSEIF ParaTransType = 111 THEN -- Get Topic Document                  
                      SELECT * FROM (    SELECT Doc01 'DOC' FROM topic WHERE CourseID = ParaTransValue
                                            UNION
                                          SELECT Doc02 'DOC' FROM topic WHERE CourseID = ParaTransValue
                          ) Main WHERE LENGTH(TRIM(DOC)) > 0;
              ELSEIf ParaTransType = 112 THEN -- Get Standard Property List For Treeview
                  SELECT StandardPropListID 'ID' , StandardPropListName 'value' From standardpropertylist PL INNER JOIN standardpropertygroup PG On PG.StandardPropID = PL.StandardPropID WHERE PG.StandardPropName = ParaTranString;
              ELSEIf ParaTransType = 113 THEN -- Get Standard Career Path List
                  Select CareerPathID as "id", CareerPathTitle as "Parent", CareerPathTitle as 'text' From careerpath where IsDeleted = '0' And IsActive = '1' ORDER BY CareerPathTitle ASC;
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
              
              IF Not Exists (SELECT * From questionset Where Question = ParaQuestion AND QuestionSetSrNo = ParaQSetSRNO) THEN
                  Insert InTo questionset (TopicID,  QuestionSetSrNo, Question, Answer01, IsAnswer01Ok, Answer02, IsAnswer02Ok, Answer03, IsAnswer03Ok, Answer04, IsAnswer04Ok, AnswerTimeInSec, ControlType, ChangeLog, IsActive, IsDeleted, AddUserID) 
                      Select  TP.TopicID As TopicID,  ParaQSetSRNO As QuestionSetSrNo, ParaQuestion As Question, ParaAnswer01 As Answer01, ParaAnswer01Correct As IsAnswer01Ok, ParaAnswer02 As Answer02, ParaAnswer02Correct As IsAnswer02Ok, ParaAnswer03 As Answer03, ParaAnswer03Correct As IsAnswer03Ok, ParaAnswer04 As Answer04, ParaAnswer04Correct As IsAnswer04Ok, ParaAnswerTimeInSec As AnswerTimeInSec, ParaControlType As ControlType, ParaChangeLog As ChangeLog, ParaIsActive As IsActive, ParaIsDeleted As IsDeleted, ParaUserID As AddUserID
                      FROM topic TP  Where CourseID = ParaCourseID AND TopicSRNO = ParaTopicID;
                  IF Exists(SELECT * From questionset Where Question = ParaQuestion AND QuestionSetSrNo = ParaQSetSRNO) THEN
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
-- Procedure For Register Portal Media User
      DELIMITER $$;
        DROP PROCEDURE IF EXISTS ManagePortalStudentRegisteration;
        CREATE PROCEDURE ManagePortalStudentRegisteration(IN ParaProfileName VARCHAR(50), IN ParaEmail VARCHAR(50), IN ParaPassword VARCHAR(500), IN ParaProfilePicture VARCHAR(5000), IN ParaProfileFirstName VARCHAR(50), IN ParaProfileLastName VARCHAR(50), IN ParaProfileMobile VARCHAR(10),IN ParaProfileDBO VARCHAR(11), IN ParaProfileGender VARCHAR(10), IN ParaProfileCompanyName VARCHAR(100), In ParaIsFaceBook TINYINT, In ParaIsGmail TINYINT)
        BEGIN
          DECLARE EXIT HANDLER FOR SQLEXCEPTION    
          BEGIN
              GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, 
              @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;
              SET @full_error = CONCAT("ERROR ", @errno, " (", @sqlstate, "): ", @text);
              Insert InTo errorlog ( ErrorLogNo, ErrorSQLState, ErrorMessage, ErrorObjectName, ErrorObjectValues, AddUserID) 
              Select   @errno As ErrorLogNo, @sqlstate As ErrorSQLState, @text As ErrorMessage, 'ManagePortalStudentRegisteration' As ErrorObjectName, Concat('Email : ' , ParaEmail , ' -> ' , ' Password : ' , ParaPassword) As ErrorObjectValues, '0' As AddUserID;           
          End;
              IF(ParaPassword='null') THEN
                Set ParaPassword = NULL; 
              End IF;
              If Not Exists(Select * From profile Where ProfileEmail = ParaEmail) THEN
                   Insert InTo profile (GroupID,  ProfileName, ProfileEmail, ProfilePassword, ProfilePicture,ProfileFirstName,ProfileLastName,ProfileMobile,ProfileDBO,ProfileGender,ProfileCompanyName, IsFaceBook, IsFaceGmail,IsPaid,IsActive, IsDeleted, AddUserID)
                  Select  '2' As GroupID,ParaProfileName  As ProfileName, ParaEmail As ProfileEmail, ParaPassword As ProfilePassword, ParaProfilePicture As ProfilePicture, ParaProfileFirstName As ProfileFirstName, ParaProfileLastName As ProfileLastName,ParaProfileMobile as ProfileMobile,ParaProfileDBO As ProfileDBO, ParaProfileGender As ProfileGender, ParaProfileCompanyName As ProfileCompanyName, ParaIsFaceBook As IsFaceBook, ParaIsGmail As IsFaceGmail, '0' As IsPaid, '1' As IsActive, '0' As IsDeleted, '1' As AddUserID; 
                   CALL ExecuteMessage( 'Add' , 517 , ParaProfileName);
              Else
                  CALL ExecuteMessage( 'Exist' , 516 , ParaProfileName);              
              End IF;
          
        END$$;
-- Procedure To Create Career Path
        DELIMITER $$;
        DROP PROCEDURE IF EXISTS ManageAdminCareerPath;
        CREATE 
        PROCEDURE ManageAdminCareerPath(IN ParaCareerPathTitle VARCHAR(50), IN ParaCareerPathDesc VARCHAR(255),IN ParaIsActive TINYINT,IN ParaIsDeleted TINYINT, ParaAddUserID SMALLINT , ParaRecordID SMALLINT )
        BEGIN
           DECLARE EXIT HANDLER FOR SQLEXCEPTION    
              BEGIN
                  GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, 
                  @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;
                  SET @full_error = CONCAT("ERROR ", @errno, " (", @sqlstate, "): ", @text);
                  Insert InTo errorlog ( ErrorLogNo, ErrorSQLState, ErrorMessage, ErrorObjectName, ErrorObjectValues, AddUserID) 
                  Select   @errno As ErrorLogNo, @sqlstate As ErrorSQLState, @text As ErrorMessage, 'ManageAdminCareerPath' As ErrorObjectName, Concat('Career Path Title : ' , ParaCareerPathTitle , ' -> ' , ' Career Path Desc : ' , ParaCareerPathDesc , ' -> ' , ' Record ID : ' , ParaRecordID,' -> ' , ' UserID ', ParaUserID) As ErrorObjectValues, '0' As AddUserID;           
              End;
              IF(ParaRecordID = 0 And ParaIsDeleted = '0') THEN
                    If Not Exists(Select * From careerpath WHERE CareerPathTitle = ParaCareerPathTitle And IsDeleted = '0'  ) THEN
                        Insert InTo careerpath ( CareerPathTitle, CareerPathDesc,  IsActive, IsDeleted, AddUserID) 
                          Select   ParaCareerPathTitle As CareerPathTitle, 
                                   ParaCareerPathDesc As CareerPathDesc,                                    
                                   ParaIsActive As IsActive, 
                                   '0' As IsDeleted, 
                                   ParaAddUserID As AddUserID;                         
                        CALL ExecuteMessage( 'Add' , 519 , ParaCareerPathTitle);
                    Else
                        CALL ExecuteMessage( 'Exist' , 518 , ParaCareerPathTitle);
                    End IF;
              ELSEIF(ParaRecordID > 0 And ParaIsDeleted = '0') THEN
                   If Not Exists(Select * From course WHERE CourseName = ParaCareerPathTitle And IsDeleted = '0' And NOT( CourseID = ParaRecordID ) ) THEN
                        Update careerpath   Set                                  
                               CareerPathTitle = ParaCareerPathTitle  , 
                               CareerPathDesc = ParaCareerPathDesc  ,                                
                               IsActive = ParaIsActive  , 
                               IsDeleted = '0'  , 
                               UpdateUserID = ParaAddUserID  , 
                               UpdateUserTime = CURRENT_TIMESTAMP  
                        Where CareerPathID = ParaRecordID ; 
                        CALL ExecuteMessage( 'Update' , 520 , ParaCareerPathTitle);
                    Else
                        CALL ExecuteMessage( 'Exist' , 518 , ParaCareerPathTitle);
                    End IF;
              ELSEIF(ParaRecordID > 0 And ParaIsDeleted = '1') THEN      
                    Update careerpath   Set                                                                 
                               IsDeleted = '1'  , 
                               UpdateUserID = ParaAddUserID  , 
                               UpdateUserTime = CURRENT_TIMESTAMP  
                        Where CareerPathID = ParaRecordID ; 
                    CALL ExecuteMessage( 'Delete' , 521 , ParaCareerPathTitle);
              END IF;
        END$$;
-- Procedure To Create Career Path Course
        DELIMITER $$;
        DROP PROCEDURE IF EXISTS ManageAdminCareerPathCourse;
CREATE 
PROCEDURE ManageAdminCareerPathCourse(IN ParaCareerPathID VARCHAR(50), IN ParaCareerPathCourseID VARCHAR(255), ParaIsActive TINYINT , ParaUserID SMALLINT , ParaRecordID SMALLINT )
BEGIN
           DECLARE EXIT HANDLER FOR SQLEXCEPTION    
              BEGIN
                  GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, 
                  @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;
                  SET @full_error = CONCAT("ERROR ", @errno, " (", @sqlstate, "): ", @text);
                  Insert InTo errorlog ( ErrorLogNo, ErrorSQLState, ErrorMessage, ErrorObjectName, ErrorObjectValues, AddUserID) 
                  Select   @errno As ErrorLogNo, @sqlstate As ErrorSQLState, @text As ErrorMessage, 'ManageAdminCareerPathCourse' As ErrorObjectName, Concat('Career Path ID : ' , ParaCareerPathID , ' -> ' , ' Career Path Course ID : ' , ParaCareerPathCourseID , ' -> ' , ' Record ID : ' , ParaRecordID,' -> ' , ' UserID ', ParaUserID) As ErrorObjectValues, '0' As AddUserID;           
              End;
       If Not Exists(Select * From careerpathcourse WHERE CareerPathID = ParaCareerPathID And CareerPathCourseID = ParaCareerPathCourseID And IsActive = ParaIsActive ) THEN
              UPDATE careerpathcourse 
              SET IsActive = ParaIsActive , 
                  UpdateUserID = ParaUserID, 
                  UpdateUserID = ParaAddUserID  , 
                  UpdateUserTime = CURRENT_TIMESTAMP
              Where  CareerPathCoursePID = ParaRecordID;
          End IF;
        END$$;
-- Procedure To Manage Default Courses
        DELIMITER $$;
        DROP PROCEDURE IF EXISTS ManageProfileDefaultCourse;
CREATE 
PROCEDURE ManageProfileDefaultCourse(IN ParaProfileID TINYINT(4))
BEGIN
           DECLARE EXIT HANDLER FOR SQLEXCEPTION    
              BEGIN
                  GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, 
                  @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;
                  SET @full_error = CONCAT("ERROR ", @errno, " (", @sqlstate, "): ", @text);
                  Insert InTo errorlog ( ErrorLogNo, ErrorSQLState, ErrorMessage, ErrorObjectName, ErrorObjectValues, AddUserID) 
                  Select   @errno As ErrorLogNo, @sqlstate As ErrorSQLState, @text As ErrorMessage, 'ManageProfileDefaultCourse' As ErrorObjectName, Concat('Profile ID : ' , ParaProfileID , ' -> ' , ' Profile ID : ' , ParaProfileID , ' -> ' , ' Record ID : ' , ParaProfileID,' -> ' , ' UserID ', ParaProfileID) As ErrorObjectValues, '0' As AddUserID;           
              End;
          If Not Exists(Select * From profilecourse WHERE CourseID = 1 And ProfileID = ParaProfileID  ) THEN
              Insert InTo profilecourse (ProfileID, CourseID, IsCurrent) Select  ParaProfileID As ProfileID, '1' As CourseID, '0' As IsCurrent; 
              Insert InTo profiletopic (ProfileCourseID,  IsCurrent, TopicID, TopicSRNO,TopicName,TopicDesc, URL01, URL01Locked, URL01Status, URL02, URL02Locked, URL02Status, URL03, URL03Locked, URL03Status, URL04, URL04Locked, URL04Status, Doc01, Doc01Locked, Doc01Status, Doc02, Doc02Locked, Doc02Status, Doc03, Doc03Locked, Doc03Status, Doc04, Doc04Locked, Doc04Status ) 
              SELECT PC.ProfileCourseID, TP.TopicID, TP.TopicSRNO, '0' As IsCurrent,
                     TP.TopicName As TopicName, TP.TopicDesc As TopicDesc,
                     TP.URL01,TP.URL01Locked ,   CASE LENGTH( TRIM( TP.URL01)) WHEN  0 THEN '1' ELSE '0' End As URL01Status, 
                     TP.URL02,TP.URL02Locked ,   CASE LENGTH( TRIM( TP.URL02)) WHEN  0 THEN '1' ELSE '0' End As URL02Status,
                     TP.URL03,TP.URL03Locked ,   CASE LENGTH( TRIM( TP.URL03)) WHEN  0 THEN '1' ELSE '0' End As URL03Status,
                     TP.URL04,TP.URL04Locked ,   CASE LENGTH( TRIM( TP.URL04)) WHEN  0 THEN '1' ELSE '0' End As URL04Status,
                     TP.Doc01,TP.URL01Locked ,   CASE LENGTH( TRIM( TP.Doc01)) WHEN  0 THEN '1' ELSE '0' End As Doc01Status, 
                     TP.Doc02,TP.URL02Locked ,   CASE LENGTH( TRIM( TP.Doc02)) WHEN  0 THEN '1' ELSE '0' End As Doc02Status,
                     TP.Doc03,TP.URL03Locked ,   CASE LENGTH( TRIM( TP.Doc03)) WHEN  0 THEN '1' ELSE '0' End As Doc03Status,
                     TP.Doc04,TP.URL04Locked ,   CASE LENGTH( TRIM( TP.Doc04)) WHEN  0 THEN '1' ELSE '0' End As Doc04Status
              FROM profilecourse PC INNER JOIN topic TP On PC.CourseID = TP.CourseID WHERE PC.ProfileID = ParaProfileID And PC.CourseID = 1 ORDER BY TP.TopicID asc Limit 1 ;
              
          End IF;
          If Not Exists(Select * From profilecourse WHERE CourseID = 2 And ProfileID = ParaProfileID  ) THEN
              Insert InTo profilecourse (ProfileID, CourseID, IsCurrent) Select  ParaProfileID As ProfileID, '2' As CourseID, '0' As IsCurrent;                             
          End IF;
          
        END$$;
  
-- Procedure To Manage Courses List
            DELIMITER $$;
            DROP PROCEDURE IF EXISTS ManageProfileCourseList;
            CREATE  PROCEDURE ManageProfileCourseList(IN ParaProfileID TINYINT(4))
            BEGIN
           DECLARE EXIT HANDLER FOR SQLEXCEPTION    
              BEGIN
                  GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, 
                  @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;
                  SET @full_error = CONCAT("ERROR ", @errno, " (", @sqlstate, "): ", @text);
                  Insert InTo errorlog ( ErrorLogNo, ErrorSQLState, ErrorMessage, ErrorObjectName, ErrorObjectValues, AddUserID) 
                  Select   @errno As ErrorLogNo, @sqlstate As ErrorSQLState, @text As ErrorMessage, 'ManageProfileCourseList' As ErrorObjectName, Concat('Profile ID : ' , ParaProfileID , ' -> ' , ' Profile ID : ' , ParaProfileID , ' -> ' , ' Record ID : ' , ParaProfileID,' -> ' , ' UserID ', ParaProfileID) As ErrorObjectValues, '0' As AddUserID;           
              End;
                IF Exists(Select * FROM profilecourse WHERE ProfileID = ParaProfileID And IsComplete = '0' AND CourseID = '1') THEN
                  SELECT PC.ProfileCourseID , CS.CourseName FROM profilecourse PC INNER JOIN course CS on PC.CourseID = CS.CourseID WHERE PC.ProfileID = ParaProfileID AND PC.CourseID = 1;
                Elseif  Exists(Select * FROM profilecourse WHERE ProfileID = ParaProfileID And IsComplete = '0' AND CourseID = '2') THEN
                  SELECT PC.ProfileCourseID , CS.CourseName FROM profilecourse PC INNER JOIN course CS on PC.CourseID = CS.CourseID WHERE PC.ProfileID = ParaProfileID AND PC.CourseID = 2;
                Else
                  SELECT PC.ProfileCourseID , CS.CourseName FROM profilecourse PC INNER JOIN course CS on PC.CourseID = CS.CourseID WHERE PC.ProfileID = ParaProfileID AND PC.CourseID > 2;
                End IF;
        END$$;
  -- Procedure To Manage Default Courses
        DELIMITER $$;
DROP PROCEDURE IF EXISTS GetProfileCourse;
CREATE  PROCEDURE GetProfileCourse(IN ParaProfileID TINYINT(4))
BEGIN
           DECLARE EXIT HANDLER FOR SQLEXCEPTION    
              BEGIN
                  GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, 
                  @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;
                  SET @full_error = CONCAT("ERROR ", @errno, " (", @sqlstate, "): ", @text);
                  Insert InTo errorlog ( ErrorLogNo, ErrorSQLState, ErrorMessage, ErrorObjectName, ErrorObjectValues, AddUserID) 
                  Select   @errno As ErrorLogNo, @sqlstate As ErrorSQLState, @text As ErrorMessage, 'GetProfileCourse' As ErrorObjectName, Concat('Profile ID : ' , ParaProfileID , ' -> ' , ' Profile ID : ' , ParaProfileID , ' -> ' , ' Record ID : ' , ParaProfileID,' -> ' , ' UserID ', ParaProfileID) As ErrorObjectValues, '0' As AddUserID;           
              End;
                SELECT CS.CourseID , CS.CourseName  From profilecourse PC INNER JOIN course CS On PC.CourseID = CS.CourseID WHERE PC.ProfileID = ParaProfileID ORDER By CS.CourseID;           
        END$$;
  DROP PROCEDURE IF EXISTS GetProfileTopic;
CREATE  PROCEDURE GetProfileTopic(IN ParaProfileCourseID TINYINT(4))
BEGIN
           DECLARE EXIT HANDLER FOR SQLEXCEPTION    
              BEGIN
                  GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, 
                  @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;
                  SET @full_error = CONCAT("ERROR ", @errno, " (", @sqlstate, "): ", @text);
                  Insert InTo errorlog ( ErrorLogNo, ErrorSQLState, ErrorMessage, ErrorObjectName, ErrorObjectValues, AddUserID) 
                  Select   @errno As ErrorLogNo, @sqlstate As ErrorSQLState, @text As ErrorMessage, 'GetProfileTopic' As ErrorObjectName, Concat('Profile ID : ' , ParaProfileCourseID , ' -> ' , ' Profile ID : ' , ParaProfileCourseID , ' -> ' , ' Record ID : ' , ParaProfileCourseID,' -> ' , ' UserID ', ParaProfileCourseID) As ErrorObjectValues, '0' As AddUserID;           
              End;
                SELECT * From profiletopic where ProfileCourseID = ParaProfileCourseID And IsCurrent = '1' ;           
        END$$;
-- Update Video Status.
  DROP PROCEDURE IF EXISTS UpdateVideoStatus;
CREATE  PROCEDURE UpdateVideoStatus(IN ParaProfileTopicRowID TINYINT(4), IN ParaVideoID TINYINT(4))
BEGIN
           DECLARE EXIT HANDLER FOR SQLEXCEPTION    
              BEGIN
                  GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, 
                  @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;
                  SET @full_error = CONCAT("ERROR ", @errno, " (", @sqlstate, "): ", @text);
                  Insert InTo errorlog ( ErrorLogNo, ErrorSQLState, ErrorMessage, ErrorObjectName, ErrorObjectValues, AddUserID) 
                  Select   @errno As ErrorLogNo, @sqlstate As ErrorSQLState, @text As ErrorMessage, 'UpdateVideoStatus' As ErrorObjectName, Concat('Profile ID : ' , ParaProfileTopicRowID , ' -> ' , ' Profile ID : ' , ParaProfileTopicRowID , ' -> ' , ' Record ID : ' , ParaProfileTopicRowID,' -> ' , ' UserID ', ParaProfileTopicRowID) As ErrorObjectValues, '0' As AddUserID;           
              End;
                if(ParaVideoID = 1) Then
                  Update profiletopic set URL01Status = '1' WHERE ProfileTopicRowID = ParaProfileTopicRowID;
                Elseif(ParaVideoID = 2) Then
                  Update profiletopic set URL02Status = '1' WHERE ProfileTopicRowID = ParaProfileTopicRowID;
                Elseif(ParaVideoID = 3) Then
                  Update profiletopic set URL03Status = '1' WHERE ProfileTopicRowID = ParaProfileTopicRowID;
                Elseif(ParaVideoID = 4) Then
                  Update profiletopic set URL04Status = '1' WHERE ProfileTopicRowID = ParaProfileTopicRowID;
                End if;
        END$$;
  -- Add New Topic.
  DROP PROCEDURE IF EXISTS AddNewTopic;
CREATE  PROCEDURE AddNewTopic(IN ParaProfileID TINYINT(4),  IN ParaProfileCourseID TINYINT(4), IN ParaProfileTopicRowID TINYINT(4))
BEGIN
           DECLARE EXIT HANDLER FOR SQLEXCEPTION    
              BEGIN
                  GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, 
                  @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;
                  SET @full_error = CONCAT("ERROR ", @errno, " (", @sqlstate, "): ", @text);
                  Insert InTo errorlog ( ErrorLogNo, ErrorSQLState, ErrorMessage, ErrorObjectName, ErrorObjectValues, AddUserID) 
                  Select   @errno As ErrorLogNo, @sqlstate As ErrorSQLState, @text As ErrorMessage, 'AddNewTopic' As ErrorObjectName, Concat('Profile ID : ' , ParaProfileID , ' -> ' , ' Profile ID : ' , ParaProfileID , ' -> ' , ' Record ID : ' , ParaProfileID,' -> ' , ' UserID ', ParaProfileID) As ErrorObjectValues, '0' As AddUserID;           
              End;
                Update profiletopic set IsCurrent = '0' WHERE ProfileTopicRowID = ParaProfileTopicRowID;
                Insert InTo profiletopic (ProfileCourseID,  IsCurrent, TopicID, TopicSRNO,TopicName,TopicDesc, URL01, URL01Locked, URL01Status, URL02, URL02Locked, URL02Status, URL03, URL03Locked, URL03Status, URL04, URL04Locked, URL04Status, Doc01, Doc01Locked, Doc01Status, Doc02, Doc02Locked, Doc02Status, Doc03, Doc03Locked, Doc03Status, Doc04, Doc04Locked, Doc04Status ) 
              SELECT PC.ProfileCourseID,  '1' As IsCurrent,TP.TopicID, TP.TopicSRNO,
                     TP.TopicName As TopicName, TP.TopicDesc As TopicDesc,
                     TP.URL01,TP.URL01Locked ,   CASE LENGTH( TRIM( TP.URL01)) WHEN  0 THEN '1' ELSE '0' End As URL01Status, 
                     TP.URL02,TP.URL02Locked ,   CASE LENGTH( TRIM( TP.URL02)) WHEN  0 THEN '1' ELSE '0' End As URL02Status,
                     TP.URL03,TP.URL03Locked ,   CASE LENGTH( TRIM( TP.URL03)) WHEN  0 THEN '1' ELSE '0' End As URL03Status,
                     TP.URL04,TP.URL04Locked ,   CASE LENGTH( TRIM( TP.URL04)) WHEN  0 THEN '1' ELSE '0' End As URL04Status,
                     TP.Doc01,TP.URL01Locked ,   CASE LENGTH( TRIM( TP.Doc01)) WHEN  0 THEN '1' ELSE '0' End As Doc01Status, 
                     TP.Doc02,TP.URL02Locked ,   CASE LENGTH( TRIM( TP.Doc02)) WHEN  0 THEN '1' ELSE '0' End As Doc02Status,
                     TP.Doc03,TP.URL03Locked ,   CASE LENGTH( TRIM( TP.Doc03)) WHEN  0 THEN '1' ELSE '0' End As Doc03Status,
                     TP.Doc04,TP.URL04Locked ,   CASE LENGTH( TRIM( TP.Doc04)) WHEN  0 THEN '1' ELSE '0' End As Doc04Status
              FROM profilecourse PC INNER JOIN topic TP On PC.CourseID = TP.CourseID WHERE PC.ProfileID = ParaProfileID And PC.ProfileCourseID = ParaProfileCourseID
                    AND TP.TopicID > (SELECT Max(PT.TopicID) FROM profilecourse PC INNER JOIN profiletopic PT On PT.ProfileCourseID = PC.ProfileCourseID  
                    WHERE PC.ProfileID = ParaProfileID AND PC.ProfileCourseID = ParaProfileCourseID)
                    ORDER BY TP.TopicID asc Limit 1 ;
                IF Exists(Select * From profiletopic WHERE IsCurrent = '1') THEN
                    CALL GetProfileTopic( ParaProfileCourseID );
                ELSE
                    Select '-1' as ProfileCourseID , '-1' As ProfileTopicRowID, '-1' As IsCurrent, '-1' As TopicID,
                      '-1' As TopicSRNO, 'N/A' as TopicName,'N/A' as TopicDesc,'N/A' as URL01,'N/A' as URL01Locked,'N/A' as URL01Status,'N/A' as URL02,
                      'N/A' as URL02Locked,'N/A' as URL02Status,'N/A' as URL03,'N/A' as URL03Locked,'N/A' as URL03Status,'N/A' as URL04,
                      'N/A' as URL04Locked,'N/A' as URL04Status,'N/A' as DOC01,'N/A' as DOC01Locked,'N/A' as Doc01Status,'N/A' as DOC02,
                      'N/A' as DOC02Locked,'N/A' as Doc02Status,'N/A' as DOC03,'N/A' as DOC03Locked,'N/A' as Doc03Status,'N/A' as DOC04, 'N/A' as DOC04Locked,'N/A' as Doc04Status;
                End IF;
        END$$;

-- Record Insert
 PREPARE stmt FROM '
          Insert InTo state ( StateName, IsActive, IsDeleted, AddUserID) 
          Select   ''Andra Pradesh'' As StateName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select   ''Arunachal Pradesh'' As StateName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select   ''Assam'' As StateName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select   ''Bihar'' As StateName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select   ''Chhattisgarh'' As StateName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select   ''Goa'' As StateName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select   ''Gujarat'' As StateName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select   ''Haryana'' As StateName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select   ''Himachal Pradesh'' As StateName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select   ''Jammu and Kashmir'' As StateName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select   ''Jharkhand'' As StateName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select   ''Karnataka'' As StateName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select   ''Kerala'' As StateName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select   ''Madya Pradesh'' As StateName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select   ''Maharashtra'' As StateName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select   ''Manipur'' As StateName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select   ''Meghalaya'' As StateName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select   ''Mizoram'' As StateName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select   ''Nagaland'' As StateName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select   ''Orissa'' As StateName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select   ''Punjab'' As StateName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select   ''Rajasthan'' As StateName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select   ''Sikkim'' As StateName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select   ''Tamil Nadu'' As StateName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select   ''Tripura'' As StateName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select   ''Uttar Pradesh'' As StateName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select   ''Uttaranchal'' As StateName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select   ''West Bengal'' As StateName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID 
          ; 
        ';
      EXECUTE stmt;
      DEALLOCATE PREPARE stmt;
      -- Insert City
        PREPARE stmt FROM '
          Insert InTo city (StateID,  CityName, IsActive, IsDeleted, AddUserID) 
          Select ''1'' As StateID, ''Achampet'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Adilabad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Adoni'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Alampur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Allagadda'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Alur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Amalapuram'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Amangallu'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Anakapalle'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Anantapur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Andole'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Araku'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Armoor'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Asifabad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Aswaraopet'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Atmakur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''B. Kothakota'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Badvel'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Banaganapalle'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Bandar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Bangarupalem'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Banswada'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Bapatla'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Bellampalli'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Bhadrachalam'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Bhainsa'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Bheemunipatnam'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Bhimadole'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Bhimavaram'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Bhongir'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Bhooragamphad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Boath'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Bobbili'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Bodhan'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Chandoor'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Chavitidibbalu'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Chejerla'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Chepurupalli'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Cherial'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Chevella'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Chinnor'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Chintalapudi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Chintapalle'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Chirala'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Chittoor'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Chodavaram'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Cuddapah'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Cumbum'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Darsi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Devarakonda'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Dharmavaram'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Dichpalli'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Divi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Donakonda'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Dronachalam'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''East Godavari'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Eluru'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Eturnagaram'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Gadwal'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Gajapathinagaram'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Gajwel'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Garladinne'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Giddalur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Godavari'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Gooty'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Gudivada'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Gudur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Guntur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Hindupur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Hunsabad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Huzurabad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Huzurnagar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Hyderabad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Ibrahimpatnam'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Jaggayyapet'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Jagtial'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Jammalamadugu'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Jangaon'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Jangareddygudem'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Jannaram'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Kadiri'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Kaikaluru'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Kakinada'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Kalwakurthy'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Kalyandurg'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Kamalapuram'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Kamareddy'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Kambadur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Kanaganapalle'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Kandukuru'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Kanigiri'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Karimnagar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Kavali'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Khammam'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Khanapur (AP)'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Kodangal'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Koduru'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Koilkuntla'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Kollapur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Kothagudem'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Kovvur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Krishna'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Krosuru'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Kuppam'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Kurnool'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Lakkireddipalli'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Madakasira'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Madanapalli'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Madhira'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Madnur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Mahabubabad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Mahabubnagar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Mahadevapur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Makthal'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Mancherial'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Mandapeta'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Mangalagiri'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Manthani'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Markapur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Marturu'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Medachal'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Medak'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Medarmetla'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Metpalli'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Mriyalguda'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Mulug'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Mylavaram'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Nagarkurnool'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Nalgonda'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Nallacheruvu'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Nampalle'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Nandigama'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Nandikotkur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Nandyal'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Narasampet'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Narasaraopet'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Narayanakhed'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Narayanpet'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Narsapur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Narsipatnam'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Nazvidu'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Nelloe'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Nellore'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Nidamanur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Nirmal'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Nizamabad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Nuguru'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Ongole'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Outsarangapalle'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Paderu'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Pakala'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Palakonda'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Paland'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Palmaneru'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Pamuru'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Pargi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Parkal'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Parvathipuram'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Pathapatnam'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Pattikonda'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Peapalle'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Peddapalli'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Peddapuram'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Penukonda'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Piduguralla'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Piler'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Pithapuram'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Podili'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Polavaram'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Prakasam'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Proddatur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Pulivendla'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Punganur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Putturu'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Rajahmundri'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Rajampeta'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Ramachandrapuram'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Ramannapet'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Rampachodavaram'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Rangareddy'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Rapur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Rayachoti'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Rayadurg'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Razole'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Repalle'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Saluru'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Sangareddy'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Sathupalli'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Sattenapalle'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Satyavedu'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Shadnagar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Siddavattam'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Siddipet'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Sileru'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Sircilla'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Sirpur Kagaznagar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Sodam'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Sompeta'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Srikakulam'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Srikalahasthi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Srisailam'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Srungavarapukota'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Sudhimalla'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Sullarpet'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Tadepalligudem'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Tadipatri'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Tanduru'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Tanuku'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Tekkali'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Tenali'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Thungaturthy'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Tirivuru'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Tirupathi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Tuni'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Udaygiri'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Ulvapadu'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Uravakonda'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Utnor'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''V.R. Puram'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Vaimpalli'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Vayalpad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Venkatgiri'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Venkatgirikota'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Vijayawada'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Vikrabad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Vinjamuru'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Vinukonda'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Visakhapatnam'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Vizayanagaram'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Vizianagaram'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Vuyyuru'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Wanaparthy'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Warangal'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Wardhannapet'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Yelamanchili'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Yelavaram'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Yeleswaram'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Yellandu'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Yellanuru'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Yellareddy'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Yerragondapalem'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''1'' As StateID, ''Zahirabad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''2'' As StateID, ''Along'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''2'' As StateID, ''Anini'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''2'' As StateID, ''Anjaw'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''2'' As StateID, ''Bameng'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''2'' As StateID, ''Basar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''2'' As StateID, ''Changlang'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''2'' As StateID, ''Chowkhem'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''2'' As StateID, ''Daporizo'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''2'' As StateID, ''Dibang Valley'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''2'' As StateID, ''Dirang'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''2'' As StateID, ''Hayuliang'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''2'' As StateID, ''Huri'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''2'' As StateID, ''Itanagar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''2'' As StateID, ''Jairampur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''2'' As StateID, ''Kalaktung'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''2'' As StateID, ''Kameng'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''2'' As StateID, ''Khonsa'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''2'' As StateID, ''Kolaring'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''2'' As StateID, ''Kurung Kumey'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''2'' As StateID, ''Lohit'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''2'' As StateID, ''Lower Dibang Valley'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''2'' As StateID, ''Lower Subansiri'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''2'' As StateID, ''Mariyang'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''2'' As StateID, ''Mechuka'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''2'' As StateID, ''Miao'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''2'' As StateID, ''Nefra'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''2'' As StateID, ''Pakkekesang'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''2'' As StateID, ''Pangin'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''2'' As StateID, ''Papum Pare'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''2'' As StateID, ''Passighat'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''2'' As StateID, ''Roing'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''2'' As StateID, ''Sagalee'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''2'' As StateID, ''Seppa'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''2'' As StateID, ''Siang'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''2'' As StateID, ''Tali'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''2'' As StateID, ''Taliha'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''2'' As StateID, ''Tawang'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''2'' As StateID, ''Tezu'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''2'' As StateID, ''Tirap'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''2'' As StateID, ''Tuting'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''2'' As StateID, ''Upper Siang'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''2'' As StateID, ''Upper Subansiri'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''2'' As StateID, ''Yiang Kiag'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''3'' As StateID, ''Abhayapuri'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''3'' As StateID, ''Baithalangshu'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''3'' As StateID, ''Barama'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''3'' As StateID, ''Barpeta Road'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''3'' As StateID, ''Bihupuria'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''3'' As StateID, ''Bijni'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''3'' As StateID, ''Bilasipara'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''3'' As StateID, ''Bokajan'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''3'' As StateID, ''Bokakhat'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''3'' As StateID, ''Boko'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''3'' As StateID, ''Bongaigaon'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''3'' As StateID, ''Cachar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''3'' As StateID, ''Cachar Hills'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''3'' As StateID, ''Darrang'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''3'' As StateID, ''Dhakuakhana'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''3'' As StateID, ''Dhemaji'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''3'' As StateID, ''Dhubri'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''3'' As StateID, ''Dibrugarh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''3'' As StateID, ''Digboi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''3'' As StateID, ''Diphu'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''3'' As StateID, ''Goalpara'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''3'' As StateID, ''Gohpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''3'' As StateID, ''Golaghat'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''3'' As StateID, ''Guwahati'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''3'' As StateID, ''Hailakandi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''3'' As StateID, ''Hajo'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''3'' As StateID, ''Halflong'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''3'' As StateID, ''Hojai'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''3'' As StateID, ''Howraghat'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''3'' As StateID, ''Jorhat'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''3'' As StateID, ''Kamrup'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''3'' As StateID, ''Karbi Anglong'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''3'' As StateID, ''Karimganj'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''3'' As StateID, ''Kokarajhar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''3'' As StateID, ''Kokrajhar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''3'' As StateID, ''Lakhimpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''3'' As StateID, ''Maibong'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''3'' As StateID, ''Majuli'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''3'' As StateID, ''Mangaldoi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''3'' As StateID, ''Mariani'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''3'' As StateID, ''Marigaon'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''3'' As StateID, ''Moranhat'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''3'' As StateID, ''Morigaon'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''3'' As StateID, ''Nagaon'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''3'' As StateID, ''Nalbari'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''3'' As StateID, ''Rangapara'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''3'' As StateID, ''Sadiya'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''3'' As StateID, ''Sibsagar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''3'' As StateID, ''Silchar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''3'' As StateID, ''Sivasagar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''3'' As StateID, ''Sonitpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''3'' As StateID, ''Tarabarihat'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''3'' As StateID, ''Tezpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''3'' As StateID, ''Tinsukia'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''3'' As StateID, ''Udalgiri'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''3'' As StateID, ''Udalguri'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''3'' As StateID, ''UdarbondhBarpeta'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Adhaura'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Amarpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Araria'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Areraj'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Arrah'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Arwal'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Aurangabad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Bagaha'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Banka'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Banmankhi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Barachakia'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Barauni'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Barh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Barosi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Begusarai'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Benipatti'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Benipur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Bettiah'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Bhabhua'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Bhagalpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Bhojpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Bidupur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Biharsharif'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Bikram'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Bikramganj'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Birpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Buxar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Chakai'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Champaran'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Chapara'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Dalsinghsarai'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Danapur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Darbhanga'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Daudnagar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Dhaka'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Dhamdaha'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Dumraon'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Ekma'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Forbesganj'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Gaya'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Gogri'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Gopalganj'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''H.Kharagpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Hajipur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Hathua'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Hilsa'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Imamganj'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Jahanabad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Jainagar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Jamshedpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Jamui'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Jehanabad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Jhajha'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Jhanjharpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Kahalgaon'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Kaimur (Bhabua)'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Katihar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Katoria'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Khagaria'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Kishanganj'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Korha'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Lakhisarai'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Madhepura'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Madhubani'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Maharajganj'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Mahua'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Mairwa'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Mallehpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Masrakh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Mohania'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Monghyr'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Motihari'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Motipur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Munger'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Muzaffarpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Nabinagar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Nalanda'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Narkatiaganj'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Naugachia'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Nawada'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Pakribarwan'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Pakridayal'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Patna'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Phulparas'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Piro'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Pupri'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Purena'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Purnia'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Rafiganj'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Rajauli'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Ramnagar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Raniganj'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Raxaul'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Rohtas'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Rosera'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''S.Bakhtiarpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Saharsa'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Samastipur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Saran'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Sasaram'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Seikhpura'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Sheikhpura'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Sheohar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Sherghati'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Sidhawalia'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Singhwara'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Sitamarhi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Siwan'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Sonepur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Supaul'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Thakurganj'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Triveniganj'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Udakishanganj'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Vaishali'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''4'' As StateID, ''Wazirganj '' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Ambikapur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Antagarh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Arang'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Bacheli'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Bagbahera'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Bagicha'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Baikunthpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Balod'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Balodabazar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Balrampur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Barpalli'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Basana'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Bastanar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Bastar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Bderajpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Bemetara'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Berla'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Bhairongarh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Bhanupratappur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Bharathpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Bhatapara'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Bhilai'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Bhilaigarh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Bhopalpatnam'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Bijapur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Bilaspur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Bodla'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Bokaband'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Chandipara'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Chhinagarh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Chhuriakala'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Chingmut'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Chuikhadan'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Dabhara'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Dallirajhara'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Dantewada'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Deobhog'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Dhamda'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Dhamtari'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Dharamjaigarh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Dongargarh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Durg'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Durgakondal'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Fingeshwar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Gariaband'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Garpa'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Gharghoda'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Gogunda'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Ilamidi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Jagdalpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Janjgir'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Janjgir-Champa'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Jarwa'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Jashpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Jashpurnagar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Kabirdham-Kawardha'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Kanker'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Kasdol'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Kathdol'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Kathghora'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Kawardha'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Keskal'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Khairgarh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Kondagaon'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Konta'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Korba'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Korea'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Kota'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Koyelibeda'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Kuakunda'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Kunkuri'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Kurud'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Lohadigundah'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Lormi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Luckwada'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Mahasamund'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Makodi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Manendragarh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Manpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Marwahi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Mohla'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Mungeli'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Nagri'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Narainpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Narayanpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Neora'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Netanar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Odgi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Padamkot'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Pakhanjur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Pali'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Pandaria'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Pandishankar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Parasgaon'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Pasan'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Patan'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Pathalgaon'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Pendra'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Pratappur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Premnagar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Raigarh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Raipur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Rajnandgaon'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Rajpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Ramchandrapur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Saraipali'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Saranggarh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Sarona'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Semaria'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Shakti'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Sitapur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Sukma'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Surajpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Surguja'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Tapkara'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Toynar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Udaipur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Uproda'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''5'' As StateID, ''Wadrainagar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''6'' As StateID, ''Canacona'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''6'' As StateID, ''Candolim'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''6'' As StateID, ''Chinchinim'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''6'' As StateID, ''Cortalim'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''6'' As StateID, ''Goa'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''6'' As StateID, ''Jua'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''6'' As StateID, ''Madgaon'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''6'' As StateID, ''Mahem'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''6'' As StateID, ''Mapuca'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''6'' As StateID, ''Marmagao'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''6'' As StateID, ''Panji'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''6'' As StateID, ''Ponda'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''6'' As StateID, ''Sanvordem'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''6'' As StateID, ''Terekhol'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Ahmedabad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Ahwa'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Amod'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Amreli'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Anand'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Anjar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Ankaleshwar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Babra'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Balasinor'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Banaskantha'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Bansada'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Bardoli'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Bareja'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Baroda'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Barwala'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Bayad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Bhachav'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Bhanvad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Bharuch'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Bhavnagar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Bhiloda'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Bhuj'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Billimora'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Borsad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Botad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Chanasma'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Chhota Udaipur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Chotila'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Dabhoi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Dahod'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Damnagar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Dang'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Danta'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Dasada'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Dediapada'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Deesa'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Dehgam'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Deodar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Devgadhbaria'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Dhandhuka'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Dhanera'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Dharampur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Dhari'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Dholka'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Dhoraji'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Dhrangadhra'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Dhrol'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Dwarka'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Fortsongadh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Gadhada'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Gandhi Nagar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Gariadhar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Godhra'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Gogodar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Gondal'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Halol'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Halvad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Harij'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Himatnagar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Idar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Jambusar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Jamjodhpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Jamkalyanpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Jamnagar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Jasdan'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Jetpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Jhagadia'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Jhalod'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Jodia'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Junagadh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Junagarh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Kalawad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Kalol'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Kapad Wanj'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Keshod'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Khambat'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Khambhalia'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Khavda'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Kheda'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Khedbrahma'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Kheralu'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Kodinar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Kotdasanghani'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Kunkawav'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Kutch'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Kutchmandvi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Kutiyana'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Lakhpat'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Lakhtar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Lalpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Limbdi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Limkheda'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Lunavada'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''M.M.Mangrol'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Mahuva'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Malia-Hatina'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Maliya'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Malpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Manavadar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Mandvi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Mangrol'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Mehmedabad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Mehsana'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Miyagam'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Modasa'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Morvi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Muli'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Mundra'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Nadiad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Nakhatrana'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Nalia'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Narmada'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Naswadi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Navasari'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Nizar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Okha'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Paddhari'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Padra'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Palanpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Palitana'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Panchmahals'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Patan'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Pavijetpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Porbandar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Prantij'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Radhanpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Rahpar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Rajaula'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Rajkot'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Rajpipla'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Ranavav'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Sabarkantha'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Sanand'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Sankheda'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Santalpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Santrampur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Savarkundla'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Savli'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Sayan'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Sayla'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Shehra'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Sidhpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Sihor'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Sojitra'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Sumrasar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Surat'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Surendranagar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Talaja'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Thara'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Tharad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Thasra'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Una-Diu'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Upleta'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Vadgam'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Vadodara'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Valia'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Vallabhipur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Valod'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Valsad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Vanthali'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Vapi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Vav'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Veraval'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Vijapur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Viramgam'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Visavadar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Visnagar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Vyara'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Waghodia'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''7'' As StateID, ''Wankaner'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''8'' As StateID, ''Adampur Mandi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''8'' As StateID, ''Ambala'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''8'' As StateID, ''Assandh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''8'' As StateID, ''Bahadurgarh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''8'' As StateID, ''Barara'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''8'' As StateID, ''Barwala'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''8'' As StateID, ''Bawal'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''8'' As StateID, ''Bawanikhera'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''8'' As StateID, ''Bhiwani'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''8'' As StateID, ''Charkhidadri'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''8'' As StateID, ''Cheeka'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''8'' As StateID, ''Chhachrauli'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''8'' As StateID, ''Dabwali'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''8'' As StateID, ''Ellenabad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''8'' As StateID, ''Faridabad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''8'' As StateID, ''Fatehabad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''8'' As StateID, ''Ferojpur Jhirka'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''8'' As StateID, ''Gharaunda'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''8'' As StateID, ''Gohana'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''8'' As StateID, ''Gurgaon'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''8'' As StateID, ''Hansi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''8'' As StateID, ''Hisar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''8'' As StateID, ''Jagadhari'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''8'' As StateID, ''Jatusana'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''8'' As StateID, ''Jhajjar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''8'' As StateID, ''Jind'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''8'' As StateID, ''Julana'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''8'' As StateID, ''Kaithal'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''8'' As StateID, ''Kalanaur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''8'' As StateID, ''Kalanwali'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''8'' As StateID, ''Kalka'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''8'' As StateID, ''Karnal'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''8'' As StateID, ''Kosli'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''8'' As StateID, ''Kurukshetra'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''8'' As StateID, ''Loharu'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''8'' As StateID, ''Mahendragarh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''8'' As StateID, ''Meham'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''8'' As StateID, ''Mewat'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''8'' As StateID, ''Mohindergarh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''8'' As StateID, ''Naraingarh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''8'' As StateID, ''Narnaul'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''8'' As StateID, ''Narwana'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''8'' As StateID, ''Nilokheri'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''8'' As StateID, ''Nuh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''8'' As StateID, ''Palwal'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''8'' As StateID, ''Panchkula'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''8'' As StateID, ''Panipat'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''8'' As StateID, ''Pehowa'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''8'' As StateID, ''Ratia'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''8'' As StateID, ''Rewari'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''8'' As StateID, ''Rohtak'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''8'' As StateID, ''Safidon'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''8'' As StateID, ''Sirsa'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''8'' As StateID, ''Siwani'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''8'' As StateID, ''Sonipat'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''8'' As StateID, ''Tohana'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''8'' As StateID, ''Tohsam'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''8'' As StateID, ''Yamunanagar '' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''9'' As StateID, ''Amb'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''9'' As StateID, ''Arki'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''9'' As StateID, ''Banjar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''9'' As StateID, ''Bharmour'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''9'' As StateID, ''Bilaspur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''9'' As StateID, ''Chamba'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''9'' As StateID, ''Churah'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''9'' As StateID, ''Dalhousie'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''9'' As StateID, ''Dehra Gopipur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''9'' As StateID, ''Hamirpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''9'' As StateID, ''Jogindernagar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''9'' As StateID, ''Kalpa'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''9'' As StateID, ''Kangra'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''9'' As StateID, ''Kinnaur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''9'' As StateID, ''Kullu'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''9'' As StateID, ''Lahaul'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''9'' As StateID, ''Mandi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''9'' As StateID, ''Nahan'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''9'' As StateID, ''Nalagarh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''9'' As StateID, ''Nirmand'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''9'' As StateID, ''Nurpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''9'' As StateID, ''Palampur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''9'' As StateID, ''Pangi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''9'' As StateID, ''Paonta'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''9'' As StateID, ''Pooh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''9'' As StateID, ''Rajgarh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''9'' As StateID, ''Rampur Bushahar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''9'' As StateID, ''Rohru'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''9'' As StateID, ''Shimla'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''9'' As StateID, ''Sirmaur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''9'' As StateID, ''Solan'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''9'' As StateID, ''Spiti'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''9'' As StateID, ''Sundernagar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''9'' As StateID, ''Theog'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''9'' As StateID, ''Udaipur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''9'' As StateID, ''Una'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''10'' As StateID, ''Akhnoor'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''10'' As StateID, ''Anantnag'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''10'' As StateID, ''Badgam'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''10'' As StateID, ''Bandipur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''10'' As StateID, ''Baramulla'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''10'' As StateID, ''Basholi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''10'' As StateID, ''Bedarwah'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''10'' As StateID, ''Budgam'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''10'' As StateID, ''Doda'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''10'' As StateID, ''Gulmarg'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''10'' As StateID, ''Jammu'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''10'' As StateID, ''Kalakot'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''10'' As StateID, ''Kargil'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''10'' As StateID, ''Karnah'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''10'' As StateID, ''Kathua'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''10'' As StateID, ''Kishtwar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''10'' As StateID, ''Kulgam'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''10'' As StateID, ''Kupwara'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''10'' As StateID, ''Leh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''10'' As StateID, ''Mahore'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''10'' As StateID, ''Nagrota'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''10'' As StateID, ''Nobra'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''10'' As StateID, ''Nowshera'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''10'' As StateID, ''Nyoma'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''10'' As StateID, ''Padam'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''10'' As StateID, ''Pahalgam'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''10'' As StateID, ''Patnitop'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''10'' As StateID, ''Poonch'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''10'' As StateID, ''Pulwama'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''10'' As StateID, ''Rajouri'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''10'' As StateID, ''Ramban'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''10'' As StateID, ''Ramnagar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''10'' As StateID, ''Reasi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''10'' As StateID, ''Samba'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''10'' As StateID, ''Srinagar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''10'' As StateID, ''Udhampur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''10'' As StateID, ''Vaishno Devi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''11'' As StateID, ''Bagodar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''11'' As StateID, ''Baharagora'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''11'' As StateID, ''Balumath'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''11'' As StateID, ''Barhi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''11'' As StateID, ''Barkagaon'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''11'' As StateID, ''Barwadih'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''11'' As StateID, ''Basia'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''11'' As StateID, ''Bermo'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''11'' As StateID, ''Bhandaria'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''11'' As StateID, ''Bhawanathpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''11'' As StateID, ''Bishrampur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''11'' As StateID, ''Bokaro'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''11'' As StateID, ''Bolwa'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''11'' As StateID, ''Bundu'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''11'' As StateID, ''Chaibasa'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''11'' As StateID, ''Chainpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''11'' As StateID, ''Chakardharpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''11'' As StateID, ''Chandil'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''11'' As StateID, ''Chatra'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''11'' As StateID, ''Chavparan'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''11'' As StateID, ''Daltonganj'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''11'' As StateID, ''Deoghar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''11'' As StateID, ''Dhanbad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''11'' As StateID, ''Dumka'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''11'' As StateID, ''Dumri'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''11'' As StateID, ''Garhwa'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''11'' As StateID, ''Garu'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''11'' As StateID, ''Ghaghra'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''11'' As StateID, ''Ghatsila'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''11'' As StateID, ''Giridih'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''11'' As StateID, ''Godda'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''11'' As StateID, ''Gomia'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''11'' As StateID, ''Govindpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''11'' As StateID, ''Gumla'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''11'' As StateID, ''Hazaribagh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''11'' As StateID, ''Hunterganj'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''11'' As StateID, ''Ichak'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''11'' As StateID, ''Itki'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''11'' As StateID, ''Jagarnathpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''11'' As StateID, ''Jamshedpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''11'' As StateID, ''Jamtara'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''11'' As StateID, ''Japla'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''11'' As StateID, ''Jharmundi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''11'' As StateID, ''Jhinkpani'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''11'' As StateID, ''Jhumaritalaiya'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''11'' As StateID, ''Kathikund'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''11'' As StateID, ''Kharsawa'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''11'' As StateID, ''Khunti'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''11'' As StateID, ''Koderma'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''11'' As StateID, ''Kolebira'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''11'' As StateID, ''Latehar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''11'' As StateID, ''Lohardaga'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''11'' As StateID, ''Madhupur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''11'' As StateID, ''Mahagama'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''11'' As StateID, ''Maheshpur Raj'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''11'' As StateID, ''Mandar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''11'' As StateID, ''Mandu'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''11'' As StateID, ''Manoharpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''11'' As StateID, ''Muri'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''11'' As StateID, ''Nagarutatri'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''11'' As StateID, ''Nala'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''11'' As StateID, ''Noamundi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''11'' As StateID, ''Pakur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''11'' As StateID, ''Palamu'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''11'' As StateID, ''Palkot'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''11'' As StateID, ''Patan'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''11'' As StateID, ''Rajdhanwar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''11'' As StateID, ''Rajmahal'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''11'' As StateID, ''Ramgarh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''11'' As StateID, ''Ranchi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''11'' As StateID, ''Sahibganj'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''11'' As StateID, ''Saraikela'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''11'' As StateID, ''Simaria'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''11'' As StateID, ''Simdega'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''11'' As StateID, ''Singhbhum'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''11'' As StateID, ''Tisri'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''11'' As StateID, ''Torpa'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Afzalpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Ainapur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Aland'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Alur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Anekal'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Ankola'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Arsikere'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Athani'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Aurad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Bableshwar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Badami'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Bagalkot'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Bagepalli'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Bailhongal'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Bangalore'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Bangalore Rural'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Bangarpet'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Bantwal'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Basavakalyan'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Basavanabagewadi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Basavapatna'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Belgaum'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Bellary'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Belthangady'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Belur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Bhadravati'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Bhalki'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Bhatkal'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Bidar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Bijapur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Biligi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Chadchan'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Challakere'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Chamrajnagar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Channagiri'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Channapatna'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Channarayapatna'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Chickmagalur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Chikballapur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Chikkaballapur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Chikkanayakanahalli'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Chikkodi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Chikmagalur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Chincholi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Chintamani'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Chitradurga'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Chittapur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Cowdahalli'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Davanagere'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Deodurga'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Devangere'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Devarahippargi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Dharwad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Doddaballapur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Gadag'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Gangavathi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Gokak'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Gowribdanpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Gubbi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Gulbarga'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Gundlupet'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''H.B.Halli'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''H.D. Kote'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Haliyal'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Hampi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Hangal'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Harapanahalli'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Hassan'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Haveri'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Hebri'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Hirekerur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Hiriyur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Holalkere'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Holenarsipur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Honnali'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Honnavar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Hosadurga'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Hosakote'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Hosanagara'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Hospet'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Hubli'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Hukkeri'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Humnabad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Hungund'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Hunsagi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Hunsur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Huvinahadagali'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Indi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Jagalur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Jamkhandi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Jewargi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Joida'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''K.R. Nagar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Kadur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Kalghatagi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Kamalapur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Kanakapura'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Kannada'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Kargal'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Karkala'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Karwar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Khanapur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Kodagu'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Kolar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Kollegal'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Koppa'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Koppal'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Koratageri'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Krishnarajapet'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Kudligi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Kumta'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Kundapur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Kundgol'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Kunigal'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Kurugodu'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Kustagi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Lingsugur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Madikeri'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Madugiri'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Malavalli'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Malur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Mandya'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Mangalore'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Manipal'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Manvi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Mashal'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Molkalmuru'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Mudalgi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Muddebihal'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Mudhol'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Mudigere'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Mulbagal'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Mundagod'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Mundargi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Murugod'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Mysore'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Nagamangala'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Nanjangud'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Nargund'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Narsimrajapur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Navalgund'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Nelamangala'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Nimburga'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Pandavapura'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Pavagada'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Puttur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Raibag'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Raichur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Ramdurg'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Ranebennur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Ron'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Sagar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Sakleshpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Salkani'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Sandur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Saundatti'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Savanur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Sedam'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Shahapur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Shankarnarayana'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Shikaripura'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Shimoga'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Shirahatti'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Shorapur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Siddapur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Sidlaghatta'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Sindagi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Sindhanur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Sira'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Sirsi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Siruguppa'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Somwarpet'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Sorab'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Sringeri'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Sriniwaspur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Srirangapatna'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Sullia'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''T. Narsipur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Tallak'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Tarikere'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Telgi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Thirthahalli'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Tiptur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Tumkur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Turuvekere'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Udupi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Virajpet'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Wadi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Yadgiri'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Yelburga'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''12'' As StateID, ''Yellapur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''13'' As StateID, ''Adimaly'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''13'' As StateID, ''Adoor'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''13'' As StateID, ''Agathy'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''13'' As StateID, ''Alappuzha'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''13'' As StateID, ''Alathur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''13'' As StateID, ''Alleppey'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''13'' As StateID, ''Alwaye'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''13'' As StateID, ''Amini'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''13'' As StateID, ''Androth'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''13'' As StateID, ''Attingal'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''13'' As StateID, ''Badagara'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''13'' As StateID, ''Bitra'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''13'' As StateID, ''Calicut'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''13'' As StateID, ''Cannanore'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''13'' As StateID, ''Chetlet'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''13'' As StateID, ''Ernakulam'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''13'' As StateID, ''Idukki'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''13'' As StateID, ''Irinjalakuda'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''13'' As StateID, ''Kadamath'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''13'' As StateID, ''Kalpeni'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''13'' As StateID, ''Kalpetta'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''13'' As StateID, ''Kanhangad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''13'' As StateID, ''Kanjirapally'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''13'' As StateID, ''Kannur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''13'' As StateID, ''Karungapally'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''13'' As StateID, ''Kasargode'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''13'' As StateID, ''Kavarathy'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''13'' As StateID, ''Kiltan'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''13'' As StateID, ''Kochi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''13'' As StateID, ''Koduvayur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''13'' As StateID, ''Kollam'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''13'' As StateID, ''Kottayam'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''13'' As StateID, ''Kovalam'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''13'' As StateID, ''Kozhikode'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''13'' As StateID, ''Kunnamkulam'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''13'' As StateID, ''Malappuram'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''13'' As StateID, ''Mananthodi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''13'' As StateID, ''Manjeri'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''13'' As StateID, ''Mannarghat'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''13'' As StateID, ''Mavelikkara'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''13'' As StateID, ''Minicoy'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''13'' As StateID, ''Munnar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''13'' As StateID, ''Muvattupuzha'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''13'' As StateID, ''Nedumandad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''13'' As StateID, ''Nedumgandam'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''13'' As StateID, ''Nilambur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''13'' As StateID, ''Palai'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''13'' As StateID, ''Palakkad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''13'' As StateID, ''Palghat'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''13'' As StateID, ''Pathaanamthitta'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''13'' As StateID, ''Pathanamthitta'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''13'' As StateID, ''Payyanur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''13'' As StateID, ''Peermedu'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''13'' As StateID, ''Perinthalmanna'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''13'' As StateID, ''Perumbavoor'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''13'' As StateID, ''Punalur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''13'' As StateID, ''Quilon'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''13'' As StateID, ''Ranni'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''13'' As StateID, ''Shertallai'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''13'' As StateID, ''Shoranur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''13'' As StateID, ''Taliparamba'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''13'' As StateID, ''Tellicherry'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''13'' As StateID, ''Thiruvananthapuram'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''13'' As StateID, ''Thodupuzha'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''13'' As StateID, ''Thrissur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''13'' As StateID, ''Tirur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''13'' As StateID, ''Tiruvalla'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''13'' As StateID, ''Trichur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''13'' As StateID, ''Trivandrum'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''13'' As StateID, ''Uppala'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''13'' As StateID, ''Vadakkanchery'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''13'' As StateID, ''Vikom'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''13'' As StateID, ''Wayanad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Agar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Ajaigarh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Alirajpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Amarpatan'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Amarwada'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Ambah'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Anuppur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Arone'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Ashoknagar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Ashta'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Atner'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Babaichichli'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Badamalhera'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Badarwsas'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Badnagar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Badnawar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Badwani'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Bagli'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Baihar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Balaghat'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Baldeogarh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Baldi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Bamori'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Banda'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Bandhavgarh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Bareli'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Baroda'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Barwaha'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Barwani'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Batkakhapa'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Begamganj'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Beohari'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Berasia'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Berchha'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Betul'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Bhainsdehi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Bhander'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Bhanpura'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Bhikangaon'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Bhimpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Bhind'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Bhitarwar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Bhopal'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Biaora'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Bijadandi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Bijawar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Bijaypur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Bina'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Birsa'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Birsinghpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Budhni'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Burhanpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Buxwaha'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Chachaura'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Chanderi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Chaurai'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Chhapara'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Chhatarpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Chhindwara'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Chicholi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Chitrangi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Churhat'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Dabra'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Damoh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Datia'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Deori'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Deosar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Depalpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Dewas'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Dhar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Dharampuri'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Dindori'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Gadarwara'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Gairatganj'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Ganjbasoda'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Garoth'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Ghansour'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Ghatia'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Ghatigaon'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Ghorandogri'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Ghughari'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Gogaon'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Gohad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Goharganj'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Gopalganj'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Gotegaon'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Gourihar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Guna'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Gunnore'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Gwalior'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Gyraspur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Hanumana'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Harda'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Harrai'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Harsud'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Hatta'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Hoshangabad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Ichhawar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Indore'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Isagarh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Itarsi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Jabalpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Jabera'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Jagdalpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Jaisinghnagar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Jaithari'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Jaitpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Jaitwara'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Jamai'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Jaora'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Jatara'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Jawad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Jhabua'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Jobat'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Jora'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Kakaiya'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Kannod'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Kannodi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Karanjia'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Kareli'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Karera'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Karhal'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Karpa'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Kasrawad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Katangi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Katni'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Keolari'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Khachrod'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Khajuraho'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Khakner'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Khalwa'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Khandwa'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Khaniadhana'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Khargone'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Khategaon'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Khetia'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Khilchipur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Khirkiya'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Khurai'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Kolaras'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Kotma'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Kukshi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Kundam'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Kurwai'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Kusmi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Laher'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Lakhnadon'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Lamta'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Lanji'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Lateri'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Laundi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Maheshwar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Mahidpurcity'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Maihar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Majhagwan'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Majholi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Malhargarh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Manasa'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Manawar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Mandla'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Mandsaur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Manpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Mauganj'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Mawai'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Mehgaon'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Mhow'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Morena'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Multai'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Mungaoli'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Nagod'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Nainpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Narsingarh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Narsinghpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Narwar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Nasrullaganj'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Nateran'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Neemuch'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Niwari'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Niwas'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Nowgaon'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Pachmarhi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Pandhana'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Pandhurna'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Panna'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Parasia'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Patan'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Patera'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Patharia'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Pawai'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Petlawad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Pichhore'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Piparia'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Pohari'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Prabhapattan'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Punasa'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Pushprajgarh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Raghogarh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Raghunathpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Rahatgarh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Raisen'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Rajgarh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Rajpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Ratlam'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Rehli'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Rewa'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Sabalgarh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Sagar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Sailana'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Sanwer'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Sarangpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Sardarpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Satna'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Saunsar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Sehore'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Sendhwa'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Seondha'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Seoni'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Seonimalwa'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Shahdol'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Shahnagar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Shahpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Shajapur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Sheopur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Sheopurkalan'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Shivpuri'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Shujalpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Sidhi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Sihora'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Silwani'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Singrauli'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Sirmour'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Sironj'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Sitamau'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Sohagpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Sondhwa'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Sonkatch'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Susner'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Tamia'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Tarana'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Tendukheda'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Teonthar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Thandla'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Tikamgarh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Timarani'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Udaipura'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Ujjain'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Umaria'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Umariapan'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Vidisha'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Vijayraghogarh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Waraseoni'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''14'' As StateID, ''Zhirnia'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Achalpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Aheri'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Ahmednagar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Ahmedpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Ajara'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Akkalkot'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Akola'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Akole'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Akot'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Alibagh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Amagaon'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Amalner'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Ambad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Ambejogai'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Amravati'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Arjuni Merogaon'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Arvi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Ashti'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Atpadi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Aurangabad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Ausa'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Babhulgaon'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Balapur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Baramati'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Barshi Takli'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Barsi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Basmatnagar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Bassein'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Beed'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Bhadrawati'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Bhamregadh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Bhandara'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Bhir'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Bhiwandi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Bhiwapur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Bhokar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Bhokardan'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Bhoom'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Bhor'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Bhudargad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Bhusawal'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Billoli'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Brahmapuri'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Buldhana'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Butibori'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Chalisgaon'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Chamorshi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Chandgad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Chandrapur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Chandur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Chanwad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Chhikaldara'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Chikhali'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Chinchwad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Chiplun'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Chopda'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Chumur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Dahanu'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Dapoli'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Darwaha'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Daryapur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Daund'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Degloor'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Delhi Tanda'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Deogad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Deolgaonraja'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Deori'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Desaiganj'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Dhadgaon'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Dhanora'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Dharani'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Dhiwadi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Dhule'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Dhulia'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Digras'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Dindori'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Edalabad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Erandul'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Etapalli'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Gadhchiroli'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Gadhinglaj'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Gaganbavada'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Gangakhed'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Gangapur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Gevrai'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Ghatanji'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Golegaon'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Gondia'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Gondpipri'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Goregaon'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Guhagar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Hadgaon'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Hatkangale'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Hinganghat'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Hingoli'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Hingua'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Igatpuri'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Indapur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Islampur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Jalgaon'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Jalna'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Jamkhed'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Jamner'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Jath'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Jawahar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Jintdor'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Junnar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Kagal'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Kaij'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Kalamb'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Kalamnuri'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Kallam'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Kalmeshwar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Kalwan'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Kalyan'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Kamptee'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Kandhar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Kankavali'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Kannad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Karad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Karjat'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Karmala'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Katol'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Kavathemankal'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Kedgaon'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Khadakwasala'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Khamgaon'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Khed'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Khopoli'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Khultabad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Kinwat'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Kolhapur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Kopargaon'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Koregaon'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Kudal'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Kuhi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Kurkheda'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Kusumba'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Lakhandur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Langa'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Latur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Lonar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Lonavala'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Madangad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Madha'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Mahabaleshwar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Mahad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Mahagaon'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Mahasala'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Mahaswad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Malegaon'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Malgaon'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Malgund'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Malkapur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Malsuras'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Malwan'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Mancher'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Mangalwedha'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Mangaon'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Mangrulpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Manjalegaon'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Manmad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Maregaon'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Mehda'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Mekhar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Mohadi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Mohol'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Mokhada'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Morshi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Mouda'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Mukhed'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Mul'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Mumbai'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Murbad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Murtizapur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Murud'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Nagbhir'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Nagpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Nahavara'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Nanded'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Nandgaon'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Nandnva'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Nandurbar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Narkhed'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Nashik'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Navapur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Ner'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Newasa'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Nilanga'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Niphad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Omerga'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Osmanabad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Pachora'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Paithan'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Palghar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Pali'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Pandharkawada'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Pandharpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Panhala'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Paranda'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Parbhani'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Parner'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Parola'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Parseoni'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Partur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Patan'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Pathardi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Pathari'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Patoda'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Pauni'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Peint'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Pen'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Phaltan'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Pimpalner'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Pirangut'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Poladpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Pune'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Pusad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Pusegaon'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Radhanagar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Rahuri'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Raigad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Rajapur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Rajgurunagar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Rajura'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Ralegaon'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Ramtek'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Ratnagiri'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Raver'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Risod'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Roha'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Sakarwadi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Sakoli'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Sakri'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Salekasa'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Samudrapur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Sangamner'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Sanganeshwar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Sangli'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Sangola'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Sanguem'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Saoner'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Saswad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Satana'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Satara'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Sawantwadi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Seloo'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Shahada'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Shahapur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Shahuwadi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Shevgaon'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Shirala'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Shirol'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Shirpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Shirur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Shirwal'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Sholapur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Shri Rampur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Shrigonda'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Shrivardhan'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Sillod'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Sinderwahi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Sindhudurg'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Sindkheda'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Sindkhedaraja'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Sinnar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Sironcha'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Soyegaon'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Surgena'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Talasari'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Talegaon S.Ji Pant'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Taloda'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Tasgaon'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Thane'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Tirora'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Tiwasa'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Trimbak'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Tuljapur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Tumsar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Udgir'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Umarkhed'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Umrane'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Umrer'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Urlikanchan'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Vaduj'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Velhe'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Vengurla'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Vijapur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Vita'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Wada'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Wai'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Walchandnagar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Wani'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Wardha'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Warlydwarud'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Warora'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Washim'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Wathar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Yavatmal'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Yawal'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Yeola'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''15'' As StateID, ''Yeotmal'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''16'' As StateID, ''Bishnupur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''16'' As StateID, ''Chakpikarong'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''16'' As StateID, ''Chandel'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''16'' As StateID, ''Chattrik'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''16'' As StateID, ''Churachandpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''16'' As StateID, ''Imphal'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''16'' As StateID, ''Jiribam'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''16'' As StateID, ''Kakching'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''16'' As StateID, ''Kalapahar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''16'' As StateID, ''Mao'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''16'' As StateID, ''Mulam'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''16'' As StateID, ''Parbung'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''16'' As StateID, ''Sadarhills'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''16'' As StateID, ''Saibom'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''16'' As StateID, ''Sempang'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''16'' As StateID, ''Senapati'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''16'' As StateID, ''Sochumer'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''16'' As StateID, ''Taloulong'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''16'' As StateID, ''Tamenglong'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''16'' As StateID, ''Thinghat'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''16'' As StateID, ''Thoubal'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''16'' As StateID, ''Ukhrul'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''17'' As StateID, ''Amlaren'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''17'' As StateID, ''Baghmara'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''17'' As StateID, ''Cherrapunjee'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''17'' As StateID, ''Dadengiri'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''17'' As StateID, ''Garo Hills'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''17'' As StateID, ''Jaintia Hills'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''17'' As StateID, ''Jowai'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''17'' As StateID, ''Khasi Hills'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''17'' As StateID, ''Khliehriat'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''17'' As StateID, ''Mariang'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''17'' As StateID, ''Mawkyrwat'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''17'' As StateID, ''Nongpoh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''17'' As StateID, ''Nongstoin'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''17'' As StateID, ''Resubelpara'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''17'' As StateID, ''Ri Bhoi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''17'' As StateID, ''Shillong'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''17'' As StateID, ''Tura'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''17'' As StateID, ''Williamnagar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''18'' As StateID, ''Aizawl'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''18'' As StateID, ''Champhai'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''18'' As StateID, ''Demagiri'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''18'' As StateID, ''Kolasib'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''18'' As StateID, ''Lawngtlai'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''18'' As StateID, ''Lunglei'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''18'' As StateID, ''Mamit'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''18'' As StateID, ''Saiha'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''18'' As StateID, ''Serchhip'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''19'' As StateID, ''Dimapur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''19'' As StateID, ''Jalukie'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''19'' As StateID, ''Kiphire'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''19'' As StateID, ''Kohima'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''19'' As StateID, ''Mokokchung'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''19'' As StateID, ''Mon'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''19'' As StateID, ''Phek'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''19'' As StateID, ''Tuensang'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''19'' As StateID, ''Wokha'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''19'' As StateID, ''Zunheboto'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Anandapur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Angul'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Anugul'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Aska'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Athgarh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Athmallik'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Attabira'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Bagdihi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Balangir'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Balasore'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Baleswar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Baliguda'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Balugaon'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Banaigarh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Bangiriposi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Barbil'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Bargarh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Baripada'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Barkot'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Basta'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Berhampur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Betanati'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Bhadrak'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Bhanjanagar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Bhawanipatna'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Bhubaneswar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Birmaharajpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Bisam Cuttack'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Boriguma'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Boudh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Buguda'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Chandbali'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Chhatrapur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Chhendipada'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Cuttack'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Daringbadi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Daspalla'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Deodgarh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Deogarh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Dhanmandal'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Dharamgarh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Dhenkanal'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Digapahandi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Dunguripali'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''G. Udayagiri'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Gajapati'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Ganjam'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Ghatgaon'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Gudari'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Gunupur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Hemgiri'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Hindol'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Jagatsinghapur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Jajpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Jamankira'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Jashipur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Jayapatna'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Jeypur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Jharigan'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Jharsuguda'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Jujumura'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Kalahandi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Kalimela'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Kamakhyanagar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Kandhamal'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Kantabhanji'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Kantamal'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Karanjia'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Kashipur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Kendrapara'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Kendujhar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Keonjhar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Khalikote'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Khordha'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Khurda'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Komana'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Koraput'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Kotagarh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Kuchinda'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Lahunipara'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Laxmipur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''M. Rampur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Malkangiri'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Mathili'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Mayurbhanj'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Mohana'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Motu'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Nabarangapur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Naktideul'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Nandapur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Narlaroad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Narsinghpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Nayagarh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Nimapara'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Nowparatan'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Nowrangapur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Nuapada'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Padampur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Paikamal'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Palla Hara'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Papadhandi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Parajang'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Pardip'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Parlakhemundi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Patnagarh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Pattamundai'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Phiringia'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Phulbani'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Puri'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Puruna Katak'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''R. Udayigiri'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Rairakhol'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Rairangpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Rajgangpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Rajkhariar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Rayagada'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Rourkela'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Sambalpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Sohela'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Sonapur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Soro'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Subarnapur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Sunabeda'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Sundergarh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Surada'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''T. Rampur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Talcher'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Telkoi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Titlagarh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Tumudibandha'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Udala'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''20'' As StateID, ''Umerkote'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''21'' As StateID, ''Abohar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''21'' As StateID, ''Ajnala'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''21'' As StateID, ''Amritsar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''21'' As StateID, ''Balachaur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''21'' As StateID, ''Barnala'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''21'' As StateID, ''Batala'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''21'' As StateID, ''Bathinda'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''21'' As StateID, ''Chandigarh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''21'' As StateID, ''Dasua'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''21'' As StateID, ''Dinanagar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''21'' As StateID, ''Faridkot'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''21'' As StateID, ''Fatehgarh Sahib'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''21'' As StateID, ''Fazilka'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''21'' As StateID, ''Ferozepur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''21'' As StateID, ''Garhashanker'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''21'' As StateID, ''Goindwal'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''21'' As StateID, ''Gurdaspur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''21'' As StateID, ''Guruharsahai'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''21'' As StateID, ''Hoshiarpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''21'' As StateID, ''Jagraon'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''21'' As StateID, ''Jalandhar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''21'' As StateID, ''Jugial'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''21'' As StateID, ''Kapurthala'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''21'' As StateID, ''Kharar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''21'' As StateID, ''Kotkapura'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''21'' As StateID, ''Ludhiana'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''21'' As StateID, ''Malaut'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''21'' As StateID, ''Malerkotla'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''21'' As StateID, ''Mansa'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''21'' As StateID, ''Moga'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''21'' As StateID, ''Muktasar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''21'' As StateID, ''Nabha'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''21'' As StateID, ''Nakodar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''21'' As StateID, ''Nangal'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''21'' As StateID, ''Nawanshahar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''21'' As StateID, ''Nawanshahr'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''21'' As StateID, ''Pathankot'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''21'' As StateID, ''Patiala'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''21'' As StateID, ''Patti'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''21'' As StateID, ''Phagwara'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''21'' As StateID, ''Phillaur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''21'' As StateID, ''Phulmandi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''21'' As StateID, ''Quadian'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''21'' As StateID, ''Rajpura'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''21'' As StateID, ''Raman'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''21'' As StateID, ''Rayya'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''21'' As StateID, ''Ropar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''21'' As StateID, ''Rupnagar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''21'' As StateID, ''Samana'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''21'' As StateID, ''Samrala'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''21'' As StateID, ''Sangrur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''21'' As StateID, ''Sardulgarh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''21'' As StateID, ''Sarhind'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''21'' As StateID, ''SAS Nagar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''21'' As StateID, ''Sultanpur Lodhi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''21'' As StateID, ''Sunam'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''21'' As StateID, ''Tanda Urmar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''21'' As StateID, ''Taran Taran'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''21'' As StateID, ''Zira'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Abu Road'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Ahore'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Ajmer'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Aklera'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Alwar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Amber'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Amet'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Anupgarh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Asind'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Aspur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Atru'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Bagidora'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Bali'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Bamanwas'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Banera'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Bansur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Banswara'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Baran'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Bari'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Barisadri'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Barmer'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Baseri'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Bassi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Baswa'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Bayana'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Beawar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Begun'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Behror'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Bhadra'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Bharatpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Bhilwara'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Bhim'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Bhinmal'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Bikaner'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Bilara'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Bundi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Chhabra'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Chhipaborad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Chirawa'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Chittorgarh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Chohtan'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Churu'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Dantaramgarh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Dausa'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Deedwana'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Deeg'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Degana'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Deogarh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Deoli'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Desuri'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Dhariawad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Dholpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Digod'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Dudu'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Dungarpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Dungla'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Fatehpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Gangapur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Gangdhar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Gerhi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Ghatol'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Girwa'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Gogunda'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Hanumangarh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Hindaun'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Hindoli'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Hurda'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Jahazpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Jaipur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Jaisalmer'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Jalore'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Jhalawar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Jhunjhunu'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Jodhpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Kaman'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Kapasan'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Karauli'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Kekri'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Keshoraipatan'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Khandar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Kherwara'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Khetri'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Kishanganj'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Kishangarh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Kishangarhbas'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Kolayat'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Kota'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Kotputli'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Kotra'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Kotri'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Kumbalgarh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Kushalgarh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Ladnun'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Ladpura'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Lalsot'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Laxmangarh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Lunkaransar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Mahuwa'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Malpura'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Malvi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Mandal'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Mandalgarh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Mandawar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Mangrol'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Marwar-Jn'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Merta'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Nadbai'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Nagaur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Nainwa'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Nasirabad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Nathdwara'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Nawa'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Neem Ka Thana'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Newai'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Nimbahera'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Nohar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Nokha'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Onli'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Osian'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Pachpadara'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Pachpahar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Padampur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Pali'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Parbatsar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Phagi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Phalodi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Pilani'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Pindwara'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Pipalda'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Pirawa'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Pokaran'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Pratapgarh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Raipur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Raisinghnagar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Rajgarh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Rajsamand'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Ramganj Mandi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Ramgarh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Rashmi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Ratangarh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Reodar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Rupbas'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Sadulshahar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Sagwara'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Sahabad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Salumber'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Sanchore'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Sangaria'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Sangod'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Sapotra'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Sarada'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Sardarshahar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Sarwar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Sawai Madhopur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Shahapura'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Sheo'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Sheoganj'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Shergarh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Sikar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Sirohi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Siwana'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Sojat'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Sri Dungargarh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Sri Ganganagar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Sri Karanpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Sri Madhopur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Sujangarh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Taranagar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Thanaghazi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Tibbi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Tijara'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Todaraisingh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Tonk'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Udaipur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Udaipurwati'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Uniayara'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Vallabhnagar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''22'' As StateID, ''Viratnagar '' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''23'' As StateID, ''Barmiak'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''23'' As StateID, ''Be'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''23'' As StateID, ''Bhurtuk'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''23'' As StateID, ''Chhubakha'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''23'' As StateID, ''Chidam'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''23'' As StateID, ''Chubha'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''23'' As StateID, ''Chumikteng'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''23'' As StateID, ''Dentam'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''23'' As StateID, ''Dikchu'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''23'' As StateID, ''Dzongri'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''23'' As StateID, ''Gangtok'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''23'' As StateID, ''Gauzing'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''23'' As StateID, ''Gyalshing'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''23'' As StateID, ''Hema'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''23'' As StateID, ''Kerung'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''23'' As StateID, ''Lachen'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''23'' As StateID, ''Lachung'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''23'' As StateID, ''Lema'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''23'' As StateID, ''Lingtam'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''23'' As StateID, ''Lungthu'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''23'' As StateID, ''Mangan'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''23'' As StateID, ''Namchi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''23'' As StateID, ''Namthang'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''23'' As StateID, ''Nanga'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''23'' As StateID, ''Nantang'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''23'' As StateID, ''Naya Bazar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''23'' As StateID, ''Padamachen'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''23'' As StateID, ''Pakhyong'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''23'' As StateID, ''Pemayangtse'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''23'' As StateID, ''Phensang'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''23'' As StateID, ''Rangli'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''23'' As StateID, ''Rinchingpong'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''23'' As StateID, ''Sakyong'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''23'' As StateID, ''Samdong'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''23'' As StateID, ''Singtam'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''23'' As StateID, ''Siniolchu'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''23'' As StateID, ''Sombari'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''23'' As StateID, ''Soreng'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''23'' As StateID, ''Sosing'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''23'' As StateID, ''Tekhug'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''23'' As StateID, ''Temi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''23'' As StateID, ''Tsetang'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''23'' As StateID, ''Tsomgo'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''23'' As StateID, ''Tumlong'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''23'' As StateID, ''Yangang'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''23'' As StateID, ''Yumtang'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Ambasamudram'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Anamali'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Arakandanallur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Arantangi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Aravakurichi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Ariyalur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Arkonam'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Arni'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Aruppukottai'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Attur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Avanashi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Batlagundu'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Bhavani'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Chengalpattu'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Chengam'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Chennai'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Chidambaram'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Chingleput'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Coimbatore'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Courtallam'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Cuddalore'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Cumbum'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Denkanikoitah'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Devakottai'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Dharampuram'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Dharmapuri'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Dindigul'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Erode'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Gingee'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Gobichettipalayam'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Gudalur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Gudiyatham'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Harur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Hosur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Jayamkondan'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Kallkurichi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Kanchipuram'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Kangayam'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Kanyakumari'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Karaikal'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Karaikudi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Karur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Keeranur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Kodaikanal'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Kodumudi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Kotagiri'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Kovilpatti'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Krishnagiri'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Kulithalai'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Kumbakonam'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Kuzhithurai'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Madurai'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Madurantgam'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Manamadurai'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Manaparai'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Mannargudi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Mayiladuthurai'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Mayiladutjurai'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Mettupalayam'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Metturdam'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Mudukulathur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Mulanur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Musiri'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Nagapattinam'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Nagarcoil'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Namakkal'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Nanguneri'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Natham'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Neyveli'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Nilgiris'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Oddanchatram'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Omalpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Ootacamund'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Ooty'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Orathanad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Palacode'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Palani'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Palladum'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Papanasam'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Paramakudi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Pattukottai'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Perambalur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Perundurai'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Pollachi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Polur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Pondicherry'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Ponnamaravathi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Ponneri'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Pudukkottai'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Rajapalayam'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Ramanathapuram'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Rameshwaram'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Ranipet'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Rasipuram'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Salem'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Sankagiri'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Sankaran'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Sathiyamangalam'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Sivaganga'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Sivakasi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Sriperumpudur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Srivaikundam'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Tenkasi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Thanjavur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Theni'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Thirumanglam'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Thiruraipoondi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Thoothukudi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Thuraiyure'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Tindivanam'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Tiruchendur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Tiruchengode'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Tiruchirappalli'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Tirunelvelli'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Tirupathur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Tirupur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Tiruttani'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Tiruvallur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Tiruvannamalai'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Tiruvarur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Tiruvellore'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Tiruvettipuram'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Trichy'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Tuticorin'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Udumalpet'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Ulundurpet'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Usiliampatti'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Uthangarai'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Valapady'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Valliyoor'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Vaniyambadi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Vedasandur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Vellore'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Velur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Vilathikulam'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Villupuram'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Virudhachalam'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Virudhunagar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Wandiwash'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''24'' As StateID, ''Yercaud'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''25'' As StateID, ''Agartala'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''25'' As StateID, ''Ambasa'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''25'' As StateID, ''Bampurbari'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''25'' As StateID, ''Belonia'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''25'' As StateID, ''Dhalai'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''25'' As StateID, ''Dharam Nagar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''25'' As StateID, ''Kailashahar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''25'' As StateID, ''Kamal Krishnabari'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''25'' As StateID, ''Khopaiyapara'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''25'' As StateID, ''Khowai'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''25'' As StateID, ''Phuldungsei'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''25'' As StateID, ''Radha Kishore Pur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''25'' As StateID, ''Tripura'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Achhnera'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Agra'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Akbarpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Aliganj'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Aligarh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Allahabad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Ambedkar Nagar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Amethi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Amiliya'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Amroha'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Anola'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Atrauli'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Auraiya'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Azamgarh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Baberu'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Badaun'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Baghpat'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Bagpat'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Baheri'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Bahraich'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Ballia'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Balrampur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Banda'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Bansdeeh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Bansgaon'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Bansi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Barabanki'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Bareilly'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Basti'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Bhadohi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Bharthana'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Bharwari'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Bhogaon'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Bhognipur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Bidhuna'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Bijnore'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Bikapur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Bilari'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Bilgram'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Bilhaur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Bindki'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Bisalpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Bisauli'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Biswan'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Budaun'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Budhana'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Bulandshahar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Bulandshahr'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Capianganj'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Chakia'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Chandauli'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Charkhari'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Chhata'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Chhibramau'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Chirgaon'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Chitrakoot'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Chunur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Dadri'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Dalmau'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Dataganj'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Debai'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Deoband'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Deoria'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Derapur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Dhampur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Domariyaganj'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Dudhi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Etah'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Etawah'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Faizabad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Farrukhabad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Fatehpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Firozabad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Garauth'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Garhmukteshwar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Gautam Buddha Nagar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Ghatampur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Ghaziabad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Ghazipur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Ghosi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Gonda'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Gorakhpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Gunnaur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Haidergarh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Hamirpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Hapur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Hardoi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Harraiya'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Hasanganj'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Hasanpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Hathras'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Jalalabad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Jalaun'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Jalesar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Jansath'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Jarar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Jasrana'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Jaunpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Jhansi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Jyotiba Phule Nagar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Kadipur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Kaimganj'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Kairana'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Kaisarganj'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Kalpi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Kannauj'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Kanpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Karchhana'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Karhal'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Karvi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Kasganj'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Kaushambi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Kerakat'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Khaga'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Khair'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Khalilabad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Kheri'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Konch'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Kumaon'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Kunda'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Kushinagar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Lalganj'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Lalitpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Lucknow'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Machlishahar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Maharajganj'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Mahoba'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Mainpuri'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Malihabad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Mariyahu'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Math'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Mathura'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Mau'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Maudaha'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Maunathbhanjan'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Mauranipur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Mawana'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Meerut'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Mehraun'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Meja'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Mirzapur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Misrikh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Modinagar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Mohamdabad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Mohamdi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Moradabad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Musafirkhana'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Muzaffarnagar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Nagina'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Najibabad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Nakur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Nanpara'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Naraini'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Naugarh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Nawabganj'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Nighasan'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Noida'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Orai'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Padrauna'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Pahasu'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Patti'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Pharenda'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Phoolpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Phulpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Pilibhit'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Pitamberpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Powayan'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Pratapgarh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Puranpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Purwa'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Raibareli'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Rampur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Ramsanehi Ghat'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Rasara'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Rath'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Robertsganj'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Sadabad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Safipur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Sagri'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Saharanpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Sahaswan'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Sahjahanpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Saidpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Salempur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Salon'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Sambhal'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Sandila'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Sant Kabir Nagar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Sant Ravidas Nagar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Sardhana'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Shahabad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Shahganj'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Shahjahanpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Shikohabad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Shravasti'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Siddharthnagar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Sidhauli'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Sikandra Rao'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Sikandrabad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Sitapur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Siyana'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Sonbhadra'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Soraon'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Sultanpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Tanda'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Tarabganj'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Tilhar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Unnao'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Utraula'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Varanasi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''26'' As StateID, ''Zamania '' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''27'' As StateID, ''Almora'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''27'' As StateID, ''Bageshwar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''27'' As StateID, ''Bhatwari'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''27'' As StateID, ''Chakrata'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''27'' As StateID, ''Chamoli'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''27'' As StateID, ''Champawat'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''27'' As StateID, ''Dehradun'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''27'' As StateID, ''Deoprayag'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''27'' As StateID, ''Dharchula'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''27'' As StateID, ''Dunda'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''27'' As StateID, ''Haldwani'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''27'' As StateID, ''Haridwar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''27'' As StateID, ''Joshimath'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''27'' As StateID, ''Karan Prayag'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''27'' As StateID, ''Kashipur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''27'' As StateID, ''Khatima'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''27'' As StateID, ''Kichha'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''27'' As StateID, ''Lansdown'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''27'' As StateID, ''Munsiari'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''27'' As StateID, ''Mussoorie'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''27'' As StateID, ''Nainital'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''27'' As StateID, ''Pantnagar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''27'' As StateID, ''Partapnagar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''27'' As StateID, ''Pauri Garhwal'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''27'' As StateID, ''Pithoragarh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''27'' As StateID, ''Purola'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''27'' As StateID, ''Rajgarh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''27'' As StateID, ''Ranikhet'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''27'' As StateID, ''Roorkee'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''27'' As StateID, ''Rudraprayag'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''27'' As StateID, ''Tehri Garhwal'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''27'' As StateID, ''Udham Singh Nagar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''27'' As StateID, ''Ukhimath'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''27'' As StateID, ''Uttarkashi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Adra'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Alipurduar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Amlagora'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Arambagh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Asansol'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Balurghat'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Bankura'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Bardhaman'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Basirhat'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Berhampur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Bethuadahari'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Birbhum'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Birpara'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Bishanpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Bolpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Bongoan'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Bulbulchandi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Burdwan'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Calcutta'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Canning'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Champadanga'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Contai'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Cooch Behar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Daimond Harbour'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Dalkhola'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Dantan'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Darjeeling'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Dhaniakhali'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Dhuliyan'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Dinajpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Dinhata'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Durgapur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Gangajalghati'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Gangarampur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Ghatal'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Guskara'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Habra'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Haldia'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Harirampur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Harishchandrapur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Hooghly'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Howrah'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Islampur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Jagatballavpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Jalpaiguri'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Jhalda'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Jhargram'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Kakdwip'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Kalchini'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Kalimpong'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Kalna'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Kandi'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Karimpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Katwa'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Kharagpur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Khatra'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Krishnanagar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Mal Bazar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Malda'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Manbazar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Mathabhanga'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Medinipur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Mekhliganj'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Mirzapur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Murshidabad'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Nadia'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Nagarakata'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Nalhati'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Nayagarh'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Parganas'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Purulia'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Raiganj'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Rampur Hat'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Ranaghat'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Seharabazar'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Siliguri'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Suri'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Takipur'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID UNION
          Select ''28'' As StateID, ''Tamluk'' As CityName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID 

          ; 
        ';
      EXECUTE stmt;
      DEALLOCATE PREPARE stmt;

      -- Add Defalt Standard Groups
      
      PREPARE stmt FROM 'Insert InTo standardpropertygroup(StandardPropName,IsActive ,IsDeleted,AddUserID)
          Select ''10ThBoard'' As StandardPropName , 1 As IsActive,  0 As IsDeleted, 1 As AddUserID Union            
          Select ''12ThBoard'' As StandardPropName , 1 As IsActive,  0 As IsDeleted, 1 As AddUserID Union
          Select ''University'' As StandardPropName , 1 As IsActive,  0 As IsDeleted, 1 As AddUserID Union
          Select ''Graduation Degree'' As StandardPropName , 1 As IsActive,  0 As IsDeleted, 1 As AddUserID Union
          Select ''Year'' As StandardPropName , 1 As IsActive,  0 As IsDeleted, 1 As AddUserID Union
          Select ''Institute List'' As StandardPropName , 1 As IsActive,  0 As IsDeleted, 1 As AddUserID Union
          Select ''Job Profile List'' As StandardPropName , 1 As IsActive,  0 As IsDeleted, 1 As AddUserID

        ';
      EXECUTE stmt;
      DEALLOCATE PREPARE stmt;
      
      -- Add Default Vaues To Propery List
      PREPARE stmt FROM '
          Insert InTo standardpropertylist (StandardPropID,  StandardPropListName, IsActive, IsDeleted, AddUserID, AddUserTime ) 
          Select  ''1'' As StandardPropID, ''Andhra Pradesh Board of Secondary Education'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''1'' As StandardPropID, ''Andhra Pradesh open School society'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''1'' As StandardPropID, ''Board of Secondary Education, Assam'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''1'' As StandardPropID, ''Assam Higher Secondary Education Council'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''1'' As StandardPropID, ''Assam state open school'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''1'' As StandardPropID, ''Bihar Board of open schooling & Examination'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''1'' As StandardPropID, ''Bihar School Examination Board'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''1'' As StandardPropID, ''Board of Secondary Education Kant Shahjahanpur Uttar Pradesh'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''1'' As StandardPropID, ''Board of Secondary Education, Madhya Pradesh'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''1'' As StandardPropID, ''M P State open school'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''1'' As StandardPropID, ''Board of Secondary Education, Rajasthan'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''1'' As StandardPropID, ''Rajasthan state open school'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''1'' As StandardPropID, ''Chhattisgarh Board of Secondary Education'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''1'' As StandardPropID, ''Chhattisgarh state open school'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''1'' As StandardPropID, ''Central Board of Secondary Education'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''1'' As StandardPropID, ''Goa Board of Secondary & Higher Secondary Education'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''1'' As StandardPropID, ''Gujarat Secondary Education Board'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''1'' As StandardPropID, ''Gujarat state open school'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''1'' As StandardPropID, ''Haryana Board of School Education'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''1'' As StandardPropID, ''Haryana open school'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''1'' As StandardPropID, ''Himachal Pradesh Board of School Education'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''1'' As StandardPropID, ''Himachal Pradesh state open school'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''1'' As StandardPropID, ''Jammu and Kashmir State Board of School Education'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''1'' As StandardPropID, ''J & K state open school'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''1'' As StandardPropID, ''Karnataka Secondary Education Examination Board'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''1'' As StandardPropID, ''Karnataka state open school'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''1'' As StandardPropID, ''Kerala Higher Secondary Examination Board'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''1'' As StandardPropID, ''Kerala State open school'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''1'' As StandardPropID, ''Maharashtra State Board of Secondary and Higher Secondary Education'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''1'' As StandardPropID, ''Meghalaya Board of School Education'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''1'' As StandardPropID, ''Mizoram Board of School Education'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''1'' As StandardPropID, ''Nagaland Board of School Education'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''1'' As StandardPropID, ''National Institute of Open Schooling'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''1'' As StandardPropID, ''Orissa Board of Secondary Education'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''1'' As StandardPropID, ''Orissa Council of Higher Secondary Education'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''1'' As StandardPropID, ''Punjab School Education Board'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''1'' As StandardPropID, ''Tamil Nadu Board of Secondary Education'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''1'' As StandardPropID, ''Tripura Board of Secondary Education'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''1'' As StandardPropID, ''Telangana Board of Intermediate Education'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''1'' As StandardPropID, ''Telangana Board of Secondary Education'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''1'' As StandardPropID, ''Uttarakhand Board of School Education'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''1'' As StandardPropID, ''West Bengal Board of Madrasah Education'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''1'' As StandardPropID, ''West Bengal Board of Primary Education'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''1'' As StandardPropID, ''West Bengal Board of Secondary Education'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''1'' As StandardPropID, ''West Bengal Council of Higher Secondary Education'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''1'' As StandardPropID, ''West Bengal Council of Rabindra Open Schooling'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''1'' As StandardPropID, ''West Bengal State Council of Vocational Education and Training'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''1'' As StandardPropID, ''International Baccalaureate'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''1'' As StandardPropID, ''IGCSE (University of Cambridge)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''1'' As StandardPropID, ''CIE (University of Cambridge)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime  Union
                Select  ''1'' As StandardPropID, ''Other'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime  Union
                Select  ''2'' As StandardPropID, ''Andhra Pradesh Board of Intermediate Education, Hyderabad'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''2'' As StandardPropID, ''Andhra Pradesh Board of Secondary Education'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''2'' As StandardPropID, ''Andhra Pradesh open School society'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''2'' As StandardPropID, ''Board of Secondary Education, Assam'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''2'' As StandardPropID, ''Assam Higher Secondary Education Council, Bamunimaidan,Guwahati'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''2'' As StandardPropID, ''Assam Board of Secondary Education, Guwahati'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''2'' As StandardPropID, ''Bihar Intermediate Education Council, Patna'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''2'' As StandardPropID, ''Bihar Board of open schooling & Examination'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''2'' As StandardPropID, ''Bihar School Examination Board'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''2'' As StandardPropID, ''Chhatisgarh Board of Secondary Education, Raipur'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''2'' As StandardPropID, ''Goa Board of Secondary & Higher Secondary Education, Goa'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''2'' As StandardPropID, ''Gujarat Secondary & Higher Secondary Education Board, Gandhi Nagar'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''2'' As StandardPropID, ''Haryana Board of Education, Hansi Road, Bhiwani'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''2'' As StandardPropID, ''Haryana Open School, Bhiwani'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''2'' As StandardPropID, ''Himachal Pradesh Board of School Education, Dharamshala'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''2'' As StandardPropID, ''J&K State Board of School Education, Jammu'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''2'' As StandardPropID, ''J&K State Open School, Srinagar'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''2'' As StandardPropID, ''Jharkhand Academic Council, Ranchi'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''2'' As StandardPropID, ''Karnataka Board of the Pre-University Education, Bangalore'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''2'' As StandardPropID, ''Karnataka Secondary Education Examination Borad, Bangalore'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''2'' As StandardPropID, ''Karnataka Open School, J.S.S. Maha Vidya Peeth, Mysore'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''2'' As StandardPropID, ''Kerala Board of Public Examinations, Pareeksha Bhawan,'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''2'' As StandardPropID, ''Kerala Board of Higher Secondary Education,'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''2'' As StandardPropID, ''Kerala State Open School, Thiruvananthapuram'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''2'' As StandardPropID, ''Maharashtra State Board of Secondary and Higher Secondary Education, Pune'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''2'' As StandardPropID, ''Madhya Pradesh Board of Secondary Education, Bhopal'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''2'' As StandardPropID, ''M.P. State Open School, Bhopal'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''2'' As StandardPropID, ''Manipur Council of Higher Secondary Education, Imphal'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''2'' As StandardPropID, ''Manipur Board of Secondary Education, Imphal'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''2'' As StandardPropID, ''Meghalaya Board of School Education, Meghalaya'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''2'' As StandardPropID, ''Mizoram Board of School Education Chaltlan, Aizawl'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''2'' As StandardPropID, ''Nagaland Board of School Education, Kohima'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''2'' As StandardPropID, ''Orissa Council of Higher Secondary Education Bhubaneswar'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''2'' As StandardPropID, ''Orissa Board of Secondary Education, Cuttack'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''2'' As StandardPropID, ''Punjab School Education Board, Mohali'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''2'' As StandardPropID, ''Rajasthan Board of Secondary Education, Ajmer'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''2'' As StandardPropID, ''Rajasthan State Open School, Jaipur'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''2'' As StandardPropID, ''Tamil Nadu Board of Secondary Education, Chennai'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''2'' As StandardPropID, ''Tamil Nadu Board of Higher Secondary Education, Chennai'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''2'' As StandardPropID, ''Tripura Board of Secondary Education, Agartala, Tripura West'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''2'' As StandardPropID, ''U.P. Board of High School & Intermediate Education, Allahabad'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''2'' As StandardPropID, ''Uttranchal Shiksha Evm Pariksha Parishad, Ram Nagar, Nainital'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''2'' As StandardPropID, ''West Bengal Board of Secondary Education, Calcutta'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''2'' As StandardPropID, ''West Bengal Council of Higher Secondary Education, Calcutta'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''2'' As StandardPropID, ''Rabindra Mukta Vidyalaya (W.B. State Open School)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''2'' As StandardPropID, ''West Bengal Board of Madarsa Education'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''2'' As StandardPropID, ''National Institute of Open Schooling (formarly National Open School), New Delhi'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''2'' As StandardPropID, ''Central Board of Secondary Education, Delhi'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''2'' As StandardPropID, ''Council for Indian School Certificate Examinations, New Delhi'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''2'' As StandardPropID, ''Rashtriya Sanskrit Sansthan, New Delhi.'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''2'' As StandardPropID, ''Gurukul Kangri Vishwavidyalaya, Haridwar,'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''2'' As StandardPropID, ''Directorate of Army Education, New Delhi.'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''2'' As StandardPropID, ''Aligarh Muslim University, Aligarh.'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''2'' As StandardPropID, ''Jamia Miliya Hamdard University.'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''2'' As StandardPropID, ''Banasthali Vidyapith, Banasthali, Rajasthan'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''2'' As StandardPropID, ''Jamia Millia Islamia, New Delhi'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''2'' As StandardPropID, ''IGCSE Programme from University of Cambridge,International Exam.'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                Select  ''2'' As StandardPropID, ''Other'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime UNION
                Select  ''3'' As StandardPropID, '' Acharya Nagarjuna University, Nagarjuna Nagar-522510, Dt. Guntur, Andhra Pradesh. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Adikavi Nannaya University, 25-7-9/1, Jayakrishnapuram, Rajahmundry – 533 105, East Godavari District, Andhra Pradesh. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Andhra University, Waltair, Visakhapatnam-530 003, Andhra Pradesh. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Damodaram Sanjivayya National Law University, Plot No. 116, Sector 11 MVP Colony,Visakhapatnam – 530 017, Andhra Pradesh. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Dr. B.R. Ambedkar University, Etcherla, Dt. Srikakulam-532410, Andhra Pradesh. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Dravidian University, Srinivasanam, -517 425, Chittoor District, Andhra Pradesh. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Dr. Y.S.R. Horticultural University, PO Box No. 7, Venkataramannagudem, West Godavari District– 536 101, Andhra Pradesh. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Dr. N.T.R. University of Health Sciences (Formerly Andhra Pradesh University of Health Sciences), Vijayawada-520 008, Andhra Pradesh. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Gandhi Institute of Technology and Management (GITAM), Gandhi Nagar Campus, Rushikonda,Visakhapatman – 530 045, Andhra Pradesh.(Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Jawaharlal Nehru Technological University, Anantpur-515 002, Andhra Pradesh (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Jawaharlal Nehru Technological University, Pithapuram Road, Kakinada-533003, East Godvari District, Andhra Pradesh.(State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Koneru Lakshmaiah Education Foundation, Greenfields, Kunchanapalli Post, Vaddeswaram,Guntur District-522002, Andhra Pradesh. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Krishna University, Andhra Jateeya Kalasala, Campus, Rajupeta, Machllipatanam – 521 001,Krishna District, Andhra Pradesh. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Rashtriya Sanskrit Vidyapeeth, Tirupati-517 507, Chittoor District, Andhra Pradesh. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Rayalaseema University, Pasupula Village, Nandyal Road, Kurnool – 518 002, Andhra Pradesh.(State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Sri Krishnadevaraya University, Anantapur-515 003, Andhra Pradesh. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Sri Padmavati Mahila Vishwavidyalayam, Tirupati-517 502, Andhra Pradesh. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Sri Sathya Sai Institute of Higher Learning, Prasanthinilayam, Anantapur-515 134, Andhra Pradesh. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Sri Venkateswara University, Tirupati-517 502, Andhra Pradesh. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Sri Venkateswara Vedic University, Alipiri-Chandragiri Bypass Road, Tirupati-517502, Andhra Pradesh. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Sri Venkateswara Veterinary University, Dr. YSR Bhavan, Tirupati – 517 502, Andhra Pradesh.(State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Sri Venkateswara Institute of Medical Sciences, Alipuri Road, Tirupati – 517 507, Andhra Pradesh. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Vignan''''s Foundation for Science, Technology and Research, Vadlamudi, Guntur District – 522213,, Andhra Pradesh. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Vikram Simhapuri University, Dargamitta, Nellore – 524 003, Andhra Pradesh. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Yogi Vemana University, Vemanapuram, Kadapa – 516 003, Andhra Pradesh. (State University)ARUNACHAL PRADESH'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Apex Professional University, Pasighat, District East Siang, Arunachal Pradesh - 791102. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Arunachal University of Studies, NH-52, Namsai, District Lohit – 792 103, Arunachal Pradesh.(Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Arunodaya University, E-Sector, Nirjuli, Itanagar, Distt. Papum Pare, Arunachal Pradesh-791109.'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Himalayan University, 401, Takar Complex, Naharlagun, Itanagar, Distt – Papumpare – 791110, Arunachal Pradesh. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' North East Frontier Technical University, Sibu-Puyi, Aalo (PO), West Siang (Distt.), Arunachal  Pradesh –791001.'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' North Eastern Regional Institute of Science & Technology, Nirjuli, Itanagar-791109, Arunachal Pradesh. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Rajiv Gandhi University, Rono Hills, PO Doimukh, Itanagar-791 112, Arunachal Pradesh. (Central University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' The Indira Gandhi Technological & Medical Sciences University, Ziro, Arunachal Pradesh. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Venkateshwara Open University, Itanagar, Arunachal Pradesh. (Private University)ASSAM'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Assam Agricultural University, Jorhat- 785 013, Assam. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Assam Don Bosco University, Azara, Guwahati-781017, Assam. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Assam Down Town University, Sankar Madhab Path, Gandhi Nagar, Panikhaiti, Guwahati – 781 036. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Assam University, PO Assam University, Silchar -788 011, Assam. (Central University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Assam Rajiv Gandhi University of Co-operative Management, 2nd Floor, Baruah Complex, Above SBI, Sivasagar-785040, Assam. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Assam Science & Technology University, Kahilipara, Guwahati – 19, Assam. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Assam Women’s University, Jorhat-785004, Assam. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Bodoland University, Debragaon, PO Rangalikhata, kokrajhar – 783 370, BTC, Assam. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Cotton College State University, Panbazar, Guwahati, Assam. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Dibrugarh University, Dibrugarh-786 004, Assam. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Gauhati University, Gopinath Bardoloi Nagar, Guwahati- 781 014, Assam. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Krishna Kanta Handique State Open University, Housefed Complex, Last Gate, Dispur, Guwahati – 781 006, Assam. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Kumar Bhaskar Varma Sanskrit & Ancient Studies University, Village – Namati, PO – Hati Namati, Dist. - Nalbari – 781 337, Assam. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Mahapurusha Srimanta Sankaradeva Viswavidyalaya, Srimanta Sankaradeva Sangha Complex, Haladhar Bhuyan Path, Kalongpar, Nagaon-782001, Assam. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' National Law University and Judicial Academy, NEJOTI Building, B.K. Kakati Road, Bholanath Mandir Path, Ulubari, Guwahati – 781 007, Assam. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Srimanta Sankaradeva University of Health Sciences, Narakasur Hilltop, Bhangagarh, Guwahati, Assam. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Tezpur University, Napaam, Sonitpur, Assam- 784 028 (Central University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' The Assam Kaziranga University, Jorhat, Assam. (Private University)BIHAR'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Aryabhatta knowledge University, 8, Off Polo Road, Patna – 800 001, Bihar (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Babasaheb Bhimrao Ambedkar Bihar University, Muzaffarpur-842 001, Bihar. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Bhupendra Narayan Mandal University, Laloo Nagar, Madhepura –852 113, Bihar. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Bihar Agricultural University, Sabour, Bhagalpur – 813210, Bihar. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Central University of South Bihar, BIT Campus, PO-B.V. College, Patna-800014. (Central University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Chanakya National Law University, Nyaya Nagar, Mithapur, Patna-800 001, Bihar. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Jai Prakash Vishwavidyalaya, Rahul Sankrityan Nagar, Chhapra –841 301, Bihar. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Kameshwara Singh Darbhanga Sanskrit Vishwavidyalaya, Kameshwar Nagar, Darbhanga-846008, Bihar. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Lalit Narayan Mithila University, Kameshwarnagar, Darbhanga- 846004, Bihar. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Magadh University, Bodh Gaya.-824 234, Bihar. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Mahatma Gandhi Central University, BIT Campus, PO-B.V. College, Patna-800014. (Central University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Maulana Mazharul Haque Arabic & Persian University, 34, Ali Imam Path (Harding Road), Near Raj Bhawan, Patna-800 001, Bihar. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Nalanda University, Rajgir, Dt. Nalanda, Bihar-803116. (Established under Central Act)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Nalanda Open University, Patna.-800 001 (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Nava Nalanda Mahavihara, Nalanda – 803 111. (Bihar) (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Patna University, Patna–800 005, Bihar. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Rajendra Agricultural University, Pusa, Samastipur- 848 125, Bihar. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' T.M. University, Bhagalpur- 812 007, Bihar. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Veer Kunwar Singh University, Arrah- 802 301, Bihar. (State University) CHHATTISGARH'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Amity University, Village-Manth, Tehsil-Tilda, Distt-Raipur, Chhattisgarh. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Ayush and Health Sciences University of Chhattisgarh, G.E. Road, Raipur-492 001, Chhattisgarh. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Bastar Vishwavidyalaya, Jagdalpur (Dharampura), Distt. – Bastar-494005, Chhattisgarh. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Bilaspur Vishwavidyalaya, Old High Court Building, Gandhi Chowk, Bilaspur – 495 001, Chhattisgarh. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Chhattisgarh Kamdhenu Vishwavidyalaya, Raipur College of Dairy Technology Campus, G.E. Road, Raipur, Chhattisgarh. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Chhattisgarh Swami Vivekanand Technical University, North Park Avenue, Sector-8, Bhilai, Dt. Durg-490009, Chhattisgarh. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Dr. C.V. Raman University, Kargi Road, Kota, Bilaspur-495113, Chhattisgarh. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Durg Vishwavidyalaya, Government Vasudev Vaman Patankar Girls’ PG College Campus, Raipur Naka, Durg, Chhattisgarh. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Guru Ghasidas Vishwavidyalaya, Koni, Bilaspur- 495 009, Chhattisgarh. (Converted State University to Central University) (Central University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Hidayatullah National Law University, Uparwara Post, Abhanpur, Raipur- 493661, Chhattisgarh.(State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' ICFAI University, NH-6, Raipur-Bhilai Road (Km Stone 20), Gram-Chorha, PO Kumhari, District Durg, Chhatttisgarh-490032. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Indira Gandhi Krishi Vishwavidyalaya, Krishak Nagar, Raipur- 492 012, Chhattisgarh. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Indira Kala Sangeet Vishwavidyalaya, Khairagarh, Dt. Rajnandgaon- 491 881, Chhattisgarh. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' ITM University, PH No. 137, Uparwara, Naya Raipur, Dt. Raipur – 493661, Chhattisgarh. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Kushabhau Thakre Patrakarita Avam Jansanchar Vishwavidyalaya, Kathadih, Post Office Sunder Nagar, Raipur – 492 013, Chhattisgarh. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Kalinga University, Raipur, Chhattisgarh. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Maharishi University of Management and Technology, Post: Mangla, Bilaspur – 495 001, Chhattisgarh (Private University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' MATS University, Arang Kharora Highway, Gram Panchayat: Gullu, Village: Gullu, Tehsil : Arang, District: Raipur-493441, Chhattisgarh (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' O.P. Jindal University, Knowledge Park, Gharghoda Road, Punjipathra, Raigarh-496001,Chhattisgarh (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Pt. Ravishankar Shukla University, Raipur-492 010, Chhattisgarh. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Pt. Sundarlal Sharma (Open) University, Village & PO Birkona, Koni-Birkona Road, Distt. Bilaspur-495009, Chhatisgarh. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Sarguja University, Darripara, Ambikapur, Sarguja-497001, Chhattisgarh (State University)GOA'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Goa University, Sub Post Office Goa University, Taleigao Plateau, Goa- 403 206. (State University)GUJARAT'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Ahmadabad University, AES Bungalow # 2, Near Commerce Six Roads, Navrangpura,Ahmedabad – 380 009, Gujarat. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Anand Agricultural Univerisity, Anand, Gujarat-388110. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' AURO University of Hospitality and Management, Surat, Gujarat. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Calorx Teacher’s University, Ahmadabad. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Central University of Gujarat, Sector-30, Gandhinagar-382030, Gujarat (Central University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Centre for Environmental Planning and Technology University, University Road, Narvrangpura Ahemdbad-380 009 (Gujarat) (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Charotar University of Science & Technology, Akshar Dham, 12, Surya Valley, Bakrol Lambhavel Road, Bakrol, Anand – 388315, Gujarat. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Children’s University, Subhash Chandra Bose Shikshan Sankul, Sector-20, Gandhinagar - 382020, Gujarat. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' C.U. Shah University, Surendranagar-Ahmedabad State Highway, Near Kothariya Village, Wadhwan City – 363030, Dt. Surendranagar, Gujarat. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Dharmsinh Desai University, Post Box No. 35, College Road, Nadiad-387 001, Gujarat.(converted from Deemed University to State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Dhirubhai Ambani Institute of Information and Communication Technology, Near Indroda Circle,Gandhinagar, Post Box No. 4, Gandhinagar-382 007, Gujarat. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Dr. Babasaheb Ambedkar Open University, R.C. Technical Institute Campus, Opp. Gujarat High Court, Sarkhej-Gandhinagar Highway, Sola, Ahmedabad – 380 060, Gujarat. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Ganpat University, Ganpat Vidyanagar, Mehsana, Goazaria Highway, Tal & District Mehsana – 384012, Gujarat. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' G.L.S. University, Gujarat Law Society Campus, Opp. Law Garden, Ellisbridge, Ahmedabad-380006, Gujarat. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' GSFC University, Vigyan Bhavan, PO Fertilizernagar – 391750, Dist. Vadodara, Gujarat. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Gujarat Agricultural University, Sardar Krushinagar, Banaskantha-385 506(State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Gujarat Ayurveda University, Chanakya Bhavan, Jamnagar-360 118, Gujarat. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Gujarat National Law University, Attalika Avenue, Knowledge Corridor, Koba, Gandhinagar,Gujarat – 382 007. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Gujarat Technlogical University, Near Vishwakarma Government Engineering College, Near Visat Three Roads, Visat-Gandhinagar Highway, Chandkheda, Ahmedabad-382414, Gujarat. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Gujarat University, Post Box 4010, Navrangpura, Ahmedabad- 380 009, Gujarat. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Gujarat University of Transplantation Sciences, IKDRC-ITS Premises, Civil Hospital Campus, Asarwa, Ahmedabad – 380016, Gujarat. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Gujarat Vidyapith, PO Navjivan, Ashram Road, Ahmedabad-380 014, Gujarat. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Gujarat Forensic Sciences University, Sector – 18/A, Near Police Bhavan, Gandhinagar – 382 007 Gujarat. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Hemchandracharya North Gujarat University, University Road, Patan-384 265, Gujarat. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Indian Institute of Public Health-Gandhinagar, Sardar Patel Institute of Economics and Social Research Campus, Drive-in-Road, Thaltej, Ahmedabad – 380054, Gujarat. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Indian Institute of Teacher Education, Government College Campus, Near Mahatma Mandir, G-4, Sector-15, Gandhinagar – 382 016, Gujarat. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Indus University, Indus Campus, Rancharda, Via-Thaltej, Ahmedabad – 382115, Gujarat. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Institute of Infrastructure Technology Research and Management, Near Khokhra Circle, Maninagar (East), Ahmedabad-380026, Gujarat. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Institute of Advanced Research, Institutional Area, Koba, Gandhinagar – 382007, Gujarat. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' ITM-Vocational University, Plot 6512, Ajwa Nimeta Road, Ravaal Taluka, Waghodia, Vadodara, Gujarat. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Junagarh Agricultural University, University Bhavan, Motibaug, Junagarh – 362001, Gujarat.(State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Kadi Sarva Vishwavidyalaya, Sector-15, Gandhinagar-382015, Gujarat. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Kamdhenu University, “Krushibhavan”, Sector 10 A, Block B, Podium Level, Gandhinagar – 382010, Gujarat. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Krantiguru Shyamji Krishna Verma Kachchh University, Mundra Road, Bhuj, Kachchh-370001, Gujarat. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Lakulish Yoga University, “Lotus View” Opp. Nirma University, S.G. Highway, Chharodi,Ahmedabad-382481, Gujarat. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Maharaja Krishnakumarsinji Bhavnagar University, S.V. Patel Campus, Gaurishanker Lake Road,Bhavnagar- 364 001, Gujarat. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Maharaja Sayajirao University of Baroda, Opp Foods & Drugs Laboratory, Fatehganj, Vadodara- 390 002, Gujarat. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Nirma University, Sarkhej-Gandhinagar Highway, Village-Chharodi, Ahmedabad-382481, Gujarat (Private University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Navrachana University, Vasna-Bhayli Road, Vadodara – 391410, Gujarat (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Pandit Deendayal Petroleum University, Knowledge Corridor, Raisan, Dist. Gandhinagar – 382007, Gujarat.(Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Parul University, PO Limda, Tal – Waghodia, Dist. Vadodara-391760, Gujarat. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Raksha Shakti University, New Mental Corner, Meghaninagar, Ahmedabad – 380 016, Gujarat.(State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' R.K. University, Rajkot-Bhavnagar Highway, Kasturbadham, Rajkot, Gujarat. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Rai University, Ahmedabad, Gujarat. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Sardar Patel University, Vallabh Vidyanagar, Dt. Anand – 388 120, Gujarat. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Saurashtra University, University Road, Rajkot- 360 005, Gujarat. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Shree Somnath Sanskrit University, Somnath-Veraval, District Junagarh-362265, Gujarat. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Sumandeep Vidyapeeth, Village Piparia, Taluka Waghodia, District Vadodara (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Swarnim Gujarat Sports University, PTC Building, Near Inquiry Office, Sector-19, Punit Van Road, Near – Suvidha Kendra, PTC Building Campus, Gandhinagar – 382 019, Gujarat. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Team Lease Skills University, Tarsali-Vadodara Road, Tarsali Bypass, Vadodara – 390009,Gujarat. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' UKA Tarsadia University, Maliba Campus, Gopal vidyanagar, Baroli-Mahuva Road, Tal. Mahuva, Dist. Surat-394350, Gujarat. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Veer Narmad South Gujarat University, University Campus, Udhna-Magdalla Road, Surat- 395007, Gujarat. (State University)HARYANA'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Al-Falah University, Faridabad, Haryana (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Amity University, Amity Education Valley, Panchgaon, Manesar, Distt. – Gurgaon-122 413,Haryana. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Ansal University, Guraon, Haryana. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Apeejay Stya University, Sohna-Palwal Road, Sohna, Gurgaon – 122 103, Haryana. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Ashoka University, Plot No. 2, Rajiv Gandhi Education City, Kundli, NCR, Sonepat, Haryana. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Bhagat Phool Singh Mahila Vishwavidyalaya, Khanpur Kalan, Sonipat-1313-5, Haryana. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Baba Mast Nath University, Rohtak, Haryana. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' BML Munjal University, 67th KM Stone, NH-8, Sidhrawali, Dist. Gurgaon – 123 413, Haryana.'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Central University of Haryana, Jant-Pali Villages, Mahendergarh, Haryana-123029. (Central University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Chaudhary Bansi Lal University, Bhiwani – 127021, Haryana. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Chaudhary Devi Lal University, Barnala Road, Sirsa-125055, Haryana. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Chaudhary Ranbir Singh University, Jind, Haryana. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Choudhary Charan Singh Haryana Agricultural University, Hisar-125 004, Haryana. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Deen Bandhu Chhotu Ram University of Science & Technology, Murthal, Sonepat-131039, Haryana. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' G.D. Goenka University, G.D. Goenka Education City, Gurgaon sohna Road, Gurgaon, Haryana – 122 103. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Guru Jambeshwar University of Science and Technology, Hisar,- 125 001, Haryana. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Indira Gandhi University, Meerpur, Rewari – 122502, Haryana. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Jagan Nath University, State Highway 22, Bahadurgarh-Jhajjar Road,Jhajjar – 124 507, Haryana.(Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' K.R. Mangalam University, Sohna Road, Gurgaon, Haryana – 122 103. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Kurukshetra University, Kurukshetra- 136 119, Haryana. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Lingaya’s University, Nachaull, Old Faridabad, Jasana Road, Faridabad – 121 002, Haryana. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Lala Lajpat Rai University of Veterinary & Animal Sciences, Premises of CCS HAU, Hisar – 125 004 Haryana. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Maharishi Dayanand University, Rohtak-124 001, Haryana. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Maharishi Markandeshwar Education Trust, Mullana, Ambala – 133003, Haryana. (Deemed University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Maharishi Markandeshwar University, Sadopur-Ambala, VPO Sadopur, Chandigarh Road, Ambala-134007, Haryana. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Manav Rachna International University, MRIU Aravali Campus, Sector 43, Surajkund-Delhi Road, Faridabad-121001, Haryana (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Manav Rachna University, Sector – 43, Delhi-Surajkund Road, Faridabad, Haryana. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' M.V.N. University, Palwal, Haryana. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' National Brain Research Centre, Gurgaon-122 001. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' National Dairy Research Institute, Karnal-132 001, Haryana. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' National Institute of Food Technology, Entrepreneurship & Management (NIFTEM), Plot No 97,Sector 56, HSIIDC Industrial Estate, Kundli, Dt. Sonepat-131038, Haryana. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' NIILM University, 9 KM Milestone, NH-65, Kaithal – 136 027, Haryana (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' O.P. Jindal Global University, Sonepat-Narela Road, Near Jagdishpur Village, Sonipat-131001,Haryana.(Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' PDM University, Post Box No. 15, Sector – 3A, Sarai Aurangabad, Bahadurgarh-124507,Haryana. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Pt. Bhagwat Dayal Sharma University of Health Sciences, Rohtak, Haryana (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Shree Guru Gobind Singh Tricentenary University, Farukh Nagar Road, Budhera, Distt. Gurgaon,Haryana. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' SRM University, Plot No. 39, Rajiv Gandhi Education City, Delhi-NCR, Sonepat-Kundli Urban Complex, Haryana – 131 029. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' State University of Performing and Visual Arts, Integrated Campus, Sector-6, Rohtak, Haryana.(State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' The Northcap University, HUDA Sector 23 A, Gurgoan-122107, Haryana. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' YMCA University of Science & Technology, Delhi-Mathura Road, Sector 6, Faridabad – 121 006,Haryana. (State University)HIMACHAL PRADESH'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Abhilashi University, Chailchowk (Chachiot), Distt. Mandi, Himachal Pradesh. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Arni University, Kathgarh, Tehsil Indora, Distt. Kangra-176401, Himachal Pradesh. (Private University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' A.P.G.(Alakh Prakash Goyal) University, Village – Pujarli, Shohgi Mehli Bypass Road, Near Panthaghati, Shimla-171009, Himachal Pradesh. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Baddi University of Emerging Sciences & Technology, Makhnumajra, BADDI, District – Solan,(Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Bahra University, VPO – Waknaghat, Tehsil – Kandaghat, Distt.- Solan, Himachal Pradesh (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Career Point University, Bhoranj (Tikker-Kharwarian), Hamirpur – 176 041, Himachal Pradesh. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Central University of Himachal Pradesh, PO Box No. 21, Dharamshala, Dist. Kangra, Himachal Pradesh-176215. (Central University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Chitkara University, HIMUDA Education Hub, Kallujhanda (Barotiwala), Distt. Solan – 174 103, Himachal Pradesh (Private University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Dr. Y.S.Parmar University of Horticulture & Forestry, Nauni- 173 230, District Solan, Himachal Pradesh. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Eternal University, Baru Sahib, Distt – Sirmour, Pin - 173101 Himachal. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Chaudhary Sarwan Kumar Himachal Pradesh Krishi Vishvavidyalaya, Palampur-176 062, District Kangra, Himachal Pradesh. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Himachal Pradesh University, Summer Hills, Shimla-171 005, Himachal Pradesh.(State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Himachal Pradesh Technical University, Gandhi Chowk, Hamirpur - 177001, Himachal Pradesh.(State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' ICFAI University, HIMUDA Education Hub, Kalujhinda, PO Mandhala, Via Barotiwala, Baddi,Solan Distt., Himachal Pradesh – 174 103. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' I.E.C. (India Education Centre) University, Plot No. 7 & 10, Atal Shiksha Kunj, Baddi, Dt. Solan, Himachal Pradesh. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Indus International University, V.P.O. Bathu, Tehsil Haroli, Distt. – Una, Himachal Pradesh – 174 301.(Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Jaypee University of Information Technology, PO Waknaghat, Tehsil Kandaghat, District-Solan- 173 234, Himachal Pradesh. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Maharishi Markandeshwar University, Sultanpur Road, Kumarhatti, Solan – 173 229, Himachal Pradesh.(Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Maharaja Agrasen University, Atal Shiksha Kunj, Distt – Solan – 174 103, Himachal Pradesh.(Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Manav Bharti University, Laddo, Sultanpur, Kumarhatti, Solan-173 229, Himachal Pradesh.(Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Shoolini University of Biotechnology and Management Sciences, Solan. H.P.(Private University)208. Sri Sai University, Palampur, Himachal Pradesh. (Private University) JAMMU & KASHMIR'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Baba Ghulam Shah Badshah University, Dhanour, Rajouri-185131, Jammu & Kashmir. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Central Institute of Buddhist Studies, Choglamsar, Leh (Ladakh), Jammu & Kashmir. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Central University of Kashmir, Transit Campus – Sonwar, Near GB Pant Hospital, Srinagar- 190005, Jammu & Kashmir. (Central University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Central University of Jammu, 8/8, Trikuta Nagar, Jammu-180012, Jammu & Kashmir. (Central University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Islamic University of Science & Technology University, 1, University Avenue, Awantipora, Pulwama – 192 122, Jammu & Kashmir. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Sher-e-Kashmir University of Agricultural Science & Technology, Shalimar, Srinagar-191121, Jammu & Kashmir. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Sher-e-Kashmir University of Agricultural Science & Technology, Chatha, Jammu – 180009, Jammu & Kashmir. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Shri Mata Vaishno Devi University, Sub-Post Office, Katra-182320, Jammu & Kashmir. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' University of Jammu, Babasaheb Ambedkar Road, Jammu -180 006, Jammu & Kashmir. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' University of Kashmir, Hazratbal, Srinagar-190 006, Jammu & Kashmir. (State University) JHARKHAND'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Birla Institute of Technology, Mesra, Ranchi-835 215, Jharkhand. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Birsa Agricultural University, Kanke, Ranchi-834 006, Jharkhand. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Central University of Jharkhand, Ratu-Lohardaga Road, Brambe, Ranchi-835205, Jharkhand (Central University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Indian School of Mines, Dhanbad-826 004, Jharkhand (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Jharkhand Rai University, Kamre, Ratu Road, Ranchi- 835222, Jharkhand. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Kolhan University, Chaibasa, West Singhbhum, Jharkhand – 833 201. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Nilamber-Pitamber University, Administrative Block, Nawatoli, Madininagar, Palamu – 822 101,Jharkhand. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' National University of Study & Research in Law, Polytechnic campus, BIT Mesra, Ranchi – 835 217 Jharkhand. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Ranchi University, Near Saheed Chowk, Ranchi-834 001, Jharkhand. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Sai Nath University, Ranchi, Jharkhand. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Sido Kanhu Murmu University, Santa Pargana, Dumka-814 101, Jharkhand. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' The Institute of Chartered Financial Analysts of India University, Ashok Nagar, Between Road No.1 & 2, Ranchi-834002, Jharkhand. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Vinoba Bhave University, PB No. 31, Hazaribagh-825 301, Bihar.(State University).KARNATAKA'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Alliance University, Bangalore (Karnataka) (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Azim Premji University, 134, Doddakanneli, Next to Wipro Corporate Office, Sarjapur Road, Bangalore, Karnataka.(Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' B.L.D.E. University, Bijapur, Karnataka (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Bangalore University, Jnanabharathi, Bangalore-560 056, Karnataka. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Central University of Karnataka, Kadaganchi, Aland Road, Aland Taluk, Gulbarga-585311, Karnataka (Central University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Christ College, Hosur Road, Bangalore – 560 029, Karnataka.(Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' CMR University, 2,3rd, ‘C’, 6th Main Road, 2nd Block, BRBR Layout, Kalyan Nagar, Bangalore – 560 043, Karnataka. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Davangere University, Shivagangothri, Davangere – 577 002, Karnataka.(State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Dayanand Sagar University, Shavige Malleshwara Hills, Kumaraswamy Layout, Bangalore-560078, Karnataka. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Gulbarga University, Jnana Ganga, Gulbarga-585 106, Gujarat. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Indian Institute of Science, Sir C.V. Raman Avenue, Bangalore-560 012, Karnataka. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Institute of Trans-Disciplinary Health Sciences and Technology, 74/2, Jarakabande Kaval, Yelahanka, Via Attur Post, Bangalore-560064, Karnataka. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' International Institute of Information Technology, 26/c, Opp. Infosys (Gate - 1), Electronic City, Hosur Road, Bangalore – 560 100, Karnataka (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Jagadguru Sri Shivarathreeswara University, Sri Shivarathreeshwara Nagar, Mysore-570015, Karnataka. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Jain University, Jain Global Campus, 45th Km, NH-209, Jakkasandra Post, Kanakapura Taluk, Ramanagara District-562112, Karnataka.(Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Jawaharlal Nehru Centre for Advanced Scientific Research, Jakkur Campus, Bangalore-560 064. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Karnataka Janapada Vishwavidyalaya, Gatagodi, NH-4, Taluk-Shiggaon, Dist-Haveri, Karnataka – 581197. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Kannada University, Hampi, Vidyaranya, Hospet Taluk, Bellary District-583 276, Karnataka.(State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Karnataka State Law University, Navanagar, Hubli – 580 025, Karnataka. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Karnataka State Open University, Muktha Gangotri, Mysore-570 006, Karnataka. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Karnataka State Women University, Jnana Shakti Campus, Athani Road, Bijapur-586 108, Karnataka. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Karnataka University, Pavate Nagar, Dharwad-580 003, Karnataka. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Karnataka Veterinary, Animal & Fisheries Science University, Nandinagar, PB No. 6, Bidar-585 401 (Karnataka) (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Karnataka Sanskrit University, Pampa Mahakavi Road, Chamarijpet, Bangalore-560018, Karnataka (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Karnataka Folklore University, Gotagodi – 581197, Shiggaon Taluk, Haveri District, Karnataka (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' KLE Academy of Higher Education and Research, JNMC Campus, Nehru Nagar, Belgaum – 590010, Karnataka. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' KLE Technological University, B.V. Bhoomaraddi College Campus, Vidyanagar, Hubballi – 580031, Karnataka. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' KSGH Music and Performing Arts University, LJB Road, Near Ashoka Circle, Lakshmipuram, Mysore – 570 004, Karnataka (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Kuvempu University, Jnana Sahyadri, Shankaraghatta-577 451, Shimoga District, Karnataka. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Mangalore University, Mangalagangothri, Mangalore-574 199, Karnataka. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Manipal Academy of Higher Education, University Building, Madhava Nagar, Manipal-576 104, Karnataka. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' M.S. Ramaiah University of Applied Sciences, Administrative Block, New BEL Road, MSRIT Post, Bangalore – 560 054, Karnataka. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' National law School of India University, Nagarbhavi, PB No. 7201, Bangalore-560 072,Karnataka. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' NITTE University, University Enclave, Medical Sciences Complex, Deralkatte, Mangalore 575018, Karnataka. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' PES University, 100 Feet Ring Road , BSK III Stage, Bangalore – 560 085 (Karnataka) (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Presidency University (Karnataka), Dibbur & Igalpur Village, Hesaraghatta Hobli, Bangalore(Karnataka). (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Rai Technology University, Doddaballapur Nelmangala Road, SH-74, Off Highway 207,Doddaballapur Taluk, Bangalore-561204 (Karnataka) (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Rajiv Gandhi University of Health Sciences, 4th T Block, Jayanagar, Bangalore-560 041, Karnataka. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Rani Channamma University, Vidyasangama, PB National Highway-04, Bhootramatti, Belagavi – 591 156, Karnataka. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Reva University, Kattigenhalli, Yelhanka, Bangalore – 560 064. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Sri Devraj Urs Academy of Higher Education and Research, Tamaka, Kolar, Karnataka (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Sri Siddhartha Academy of Higher Education, Tumkur district – 572 102, Karnataka. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Srinivas University, Srinivas Group of Colleges Campus, Srinivas Nagar, Mukka, Surathkal, Mangalore-574146, Karnataka. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Swami Vivekananda Yoga Anusandhana Samsthana, Bangalore. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Tumkur University, B.H. Road, Tumkur-572 103, Karnataka. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' University of Agricultural Sciences, GKVK Campus, Bangalore-560 065. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' University of Agricultural Sciences, Yettinagudda Campus, Krishinagar, Dharwad –580 005,Karnataka. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' University of Horticultural Sciences, Bagalkot, Udayanagiri, Near Seemikeri Cross, Bagalkot- 587104, Karnataka. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' University of Mysore, Crawford Hall, Mysore-570 006, Karnataka. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Visveswaraiah Technological University, “Jnana Sangama”, Belgaum-590 018, Karnataka. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Vijayanagara Sri Krishnadevaraya University, Jnana Sagara Campus, Vinayaka Nagar,Contonment, Bellary – 583 104 Karnataka. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Yenepoya University, Deralkatte, Mangalore-575018, Karnataka (Deemed University)KERALA'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' A.P.J. Abdul Kalam Technological University, CET Campus, Thiruvananthapuram – 695016,Kerala. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Central University of Kerala, BKM Towers, Nayanmar Moola, Vidyanagar PO, Kasargod-671123,Kerala (Central University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Cochin University of Science & Technology, Cochin University PO, Kochi-682 022, Kerala. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Indian Institute of Space Science and Technology, Valiamala PO, Thiruvananthapuram – 695547, Kerala. (Deemed University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Kannur University, Thavakkara, Civil Station Post, Kannur-670 002, Kerala. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Kerala Agricultural University, Vellanikkara, KAU Campus PO, Thrissur-680 656, Kerala. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Kerala Kalamandalam, Vallathol Nagar, Cheruthuruthy, Thrissur. (Deemed University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Kerala University of Fisheries & Ocean Studies, Panagad PO, Kochi-682506, Kerala (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Kerala University of Health Sciences, Medical College PO, M.G. Kavu, Thrissur-680 596, Kerala.(State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Kerala Veterinary & Animal Sciences University, Lakkidi Post, Pookode, Wayanad-673576,Kerala (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Mahatma Gandhi University, Priyadarshini Hills, Kottayam –686 560, Kerala. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' National University of Advanced Legal Studies (NUALS) NUALS Campus, HMT Colony, PO Kalamassery, Ernakulam-683503, Kerala. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Shree Sankaracharya University of Sanskrit, Sree Sankarapuram PO, Kalady-683 574, Dt.Ernakulam, Kerala. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Thunchath Ezhuthachan Malayalam University, Mohan Vilas, Pukayil PO, Tirur, Malappuram Distt., Kerala – 676 107. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' University of Calicut, Calicut University PO, Thenhipalam, Malappuram District-673635, Kerala.(State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' University of Kerala, Thiruvananthapuram –695 034, Kerala. (State University).MADHYA PRADESH'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' A.K.S. University, Satna, Madhya Pradesh. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Atal Bihari Vajpai Hindi Vishwavidyalaya, M.P. Bhoj (Open) University Campus, Kolar Road,Bhopal – 462016, Madhya Pradesh. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Awadesh Pratap Singh University, Rewa-486 003, Madhya Pradesh. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Amity University, Maharajpura Dang, Gwalior-474005, Madhya Pradesh. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' AISECT University, Bhopal-Chiklod Road, Near Bangrasia Chouraha, Bhopal, Madhya Pradesh'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, ''Bhopal-Chiklod Road, Near Bangrasia Chouraha, Bhopal, Madhya Pradesh (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Barkatullah University, Hoshangabad Road, Bhopal-462 026, Madhya Pradesh. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Devi Ahilya Vishwavidyalaya, “Nalanda Parisar”, 165, R.N. Tagore Marg, Indore.-452 001, Madhya Pradesh. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Dr. A.P.J. Abdul Kalam University, Indore-Devas Bypass Road, Village – Arandia, Post – Jhalaria, Madhya Pradesh – 452016. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Dr. B.R. Ambedkar University of Social Sciences, Dr. Ambedkar Nagar, Mhow – 453 441, Dist. – Indore, Madhya Pradesh. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Dr. Harisingh Gour Vishwavidyalaya, Sagar-470 003, Madhya Pradesh. (Converted from State University to Central University) (Central Unviersity)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' ITM University, ITM Campus, Opp. Sithouli Rly. Station, NH – 75, Jhansi Road, Gwalior-475 001,Madhya Pradesh. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Jagran Lakecity University, Gram Panchayat Mugaliya Chhap, Tehsil Huzur, Bhopal – 462 044,Madhya Pradesh. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Jawaharlal Nehru Krishi Vishwavidyalaya, Jabalpur-482 004 (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Jaypee University of Engineering & Technology, AB Road, Raghogarh, Distt. Guna – 473 226 (M.P.) (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Jiwaji University, Gwalior-474011 , Madhya Pradesh. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Lakshmibai National Institute of Physical Education, Shakti Nagar, Mela Road, Gwalior-474002,Madhya Pradesh. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' LNCT University, JK Town, Sarvadharam C Sector, Kolar Road, Bhopal – 462042, Madhya Pradesh. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Madhya Pradesh Medical Science University, NSCB Medical College Campus, Bhedaghat Road, Jabalpur, Madhya Pradesh. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Maharaja Chhatrasal Bundelkhand Vishwavidyalaya, Chhatarpur, Madhya Pradesh. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Mahatma Gandhi Chitrakoot Gramoday Vishwavidyalaya, Chitrakoot-485 331, District Satna, Madhya Pradesh. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' M.P.Bhoj (open) University, Raja Bhoj Marg, Kolar Road, Damkheda, Chunabhatti, Bhopal- 462016, Madhya Pradesh. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Maharishi Mahesh Yogi Vedic Vishwavidyalaya, Jabalpur-482 001 (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Maharishi Panini Sanskrit Evam Vedic Vishwavidyalaya, B.M. Birla Shodha Sansthan Parisar, Dewas Road, Ujjain-456010, Madhya Pradesh. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Makhanlal Chaturvedi Rashtriya Patrakarita National University of Journalism, B-38, Vikas Bhawan, M.P. Nagar, Sone I, Bhopal - 462 039, Madhya Pradesh. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Mandsaur University, Rewas Dewda Road, SH-31, Mandsaur – 458001, Madhya Pradesh.(Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Medi-Caps University, A.B. Road, Pigdamber, Rau, Indore-453331, Madhya Pradesh. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Nanaji Deshmukh Pashu Chikitsa Vigyan Vishwavidyalaya, Civil Lines, Jabalpur – 482 001 Madhya Pradesh. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' National Law Institute University, Bhahdbhada Road, Barkeri Kalan, Bhopal (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Oriental University, Opp. Rewati Range Gate No. 1, Sanwer Road, PO Box No. 311, Vijay Nagar Post Office, Indore – 452 010, Madhya Pradesh. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' People’s University, Bhanpur, Bhopal – 462 037, Madhya Pradesh. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' P.K. University, Village – Thanara, Tehsil – Karera, NH – 27, Shivpuri, Madhya Pradesh-473551.(Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Raja Mansingh Tomar Music & Arts University, Needam Road, Chandravadni Naka Chouraha,Gwalior – 474 009, Madhya Pradesh. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Rajiv Gandhi Prodoyogiki Vishwavidyalaya, Airport Road, Gandhi Nagar, Bhopal-462 033,Madhya Pradesh. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Rani Durgavati Vishwavidyalaya, Saraswati Vihar, Pachpedi, Jabalpur-482 001, Madhya Pradesh. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' RKDF University, By-Pass Road, Near RGPC Campus, Bhopal, Madhya Pradesh. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Rajmata Vijayaraje Scindia Krishi Vishwavidyalaya, Opp. Mela Ground, Race Cource Road, Gwalior – 474 002, Madhya Pradesh. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Sanchi University of Buddhist-Indic Studies, 2nd Floor, Institute of Good Governance & Poicy Analysys, Bhadbhada Square, Bhopal-462003, Madhya Pradesh. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Sarvepalli Radhakrishnan University, NH-12, Hoshangabad Road, Jatkhedi, Bhopal, Madhya Pradesh. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Shri Vaishnav Vidyapeeth Vishwavidyalaya, Sanwer Road, Indore-453111, Madhya Pradesh.(Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Sri Satya Sai University of Technology & Medical Sciences, Bhopal-Indore Road, Opposite Pachama Oil Fed Plant, Pachama, Sehore – 466001, Madhya Pradesh. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Swami Vivekananda University, Sagar, Madhya Pradesh. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Techno Global University, Lateri Road, Sironj (Near Gosala), Dist – Vidisha, Madhya Pradesh – 464 228. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' The Indira Gandhi National Tribal University, Amarkantak - 484886, Madhya Pradesh (Central University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Vikram University, Kothi Road, Ujjain-456 010, Madhya Pradesh. (State University)MAHARASHTRA'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Ajeenkya D.Y. Patil University, Charholi Badruk, Via Lohegaon, Pune-412105, Maharashtra.(Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Amity University, Mumbai - Pune Expressway, Bhatan, Post – Somathne, Panvel, Mumbai.Maharashtra – 410206.'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Bharati Vidyapeeth, Lal Bahadur Shastri Marg, Pune-411 030, Maharashtra. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Central Institute of Fisheries Education, Panch Marg, Off Yari Road, Versova, Andheri (West),Mumbai-400 061. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' D.Y. Patil Educational Society, 869 E, D.Y. Patil Vidyanagar, Kolhapur-416006. Maharashtra.(Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Datta Meghe Institute of Medical Sciences, Sawangi (Meghe), Wardha – 442004, Maharashtra.(Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Deccan College of Post-Graduate & Research Institute, Alandi Road, Yerwada, Pune-411 006,Maharashtra. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Dr. Babasaheb Ambedkar Marathwada University, University Campus, Near Soneri Mahal,Aurangabad-431 004, Maharashtra. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Dr. Babasaheb Ambedkar Technological University, Vidyavihar, Lonere-402 103, Dt. Raigad,Maharashtra. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Dr. D.Y. Patil Vidyapeeth, Sant Tukaram Nagar, Pimpri, Pune-411 018, Maharashtra. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Dr. Punjabrao Deshmukh Krishi Vidyapeeth, Krishi Nagar, Akola-444 104, Maharashtra. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Flame University, GAT No. 1270, Village Lavale, Taluka Mulshi, Pune-411042, Maharashtra(Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Gokhale Institute of Politics & Economics, 846, Shivajinagar, Deccan Gymkhana, BMC Road, Pune-411 004, Maharashtra. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Gondwana University, MIDC Road Complex, Gadhchiroli – 442 605, Maharashtra. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Homi Bhabha National Institute, Regd. Office: Knowledge Management Group, Bhabha Atomic Research Centre, Central Complex, Mumbai-400 085. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Indira Gandhi Institute of Development Research, Gen. A.K Vaidya Marg, Santosh Nagar,Goregaon (E), Mumbai-400065. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Institute of Armament Technology, Pune-411 025. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Institute of Chemical Technology, Matunga, Mumbai, Maharashtra. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' International Institute for Population Sciences, Govandi Station Road, Deonar, Mumbai-400088.(Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Kavi Kulguru Kalidas Sanskrit Vishwavidyalaya, Prashaskiya Bhavan, Mouda Road, Ramtek Dist., Nagpur-441 106, Maharashtra. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Konkan Krishi Vidyapeeth, Dapoli-415712, District Ratnagiri, Maharashtra. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Krishna Institute of Medical Sciences, Karad, Satara (M.S). (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Maharashtra Animal & Fishery Sciences University, Futala Lake Road, Nagpur-440 001, Maharashtra. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Maharashtra National Law University, Post Box No. 8338, Deonar, Mumbai – 400 088,Maharashtra. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Maharashtra University of Health Sciences, Mhasrul, Vani-Dindori Road, Nashik-424004, Maharashtra. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Mahatma Gandhi Antarrashtriya Hindi Vishwavidyalay, Post Box No. 16, Panchtila, Umri Village, Arvi Road, Wardha, Maharashtra.(Central University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Mahatma Phule Krishi Vidyapeeth, Rahuri-413 722, Dt. Ahmednagar, Maharashtra. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Marathwada Agricultural University, Parbhani-431 402, Maharashtra. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' MGM Institute of Health Sciences, MGM Campus, Sector – 18, Kamothe, Navi Mumbai (M.S.) – 410 209 (Deemed University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' MIT Art Design & Technology University, Rajbaug, Next to Hadapsar, Loni Kalbhor, Pune – 412201, Maharashtra. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Narsee Monjee Institute of Management Studies, V.L. Mehta Road, Vile Parle (West), Mumbai- 400056. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' North Maharashtra University, PB No. 80, Umavinagar, Jalgaon-425 001, Maharashtra. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Padmashree Dr. D.Y. Patil Vidyapeeth, Sector 7, Nerul, Navi Mumbai-400706, Maharashtra. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Pravara Institute of Medical Sciences, Loni, Tal – Rahata, District Ahmednagar-413 736,Maharashtra. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Savitribai Phule Pune University, Ganeshkhind, Pune-411 007, Maharashtra. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Sant Gadge Baba Amravati University, Tapovan Road, Amravati-444 602, Maharashtra. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Shivaji University, Vidyanagar, Kolhapur-416 004, Maharashtra. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Smt. Nathibai Damodar Thackersey Women’s University, 1, Nathibai Thackersey Road, New Marine Lines, Mumbai-400 020, Maharashtra. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Solapur University, Solapur, Solapur Pune National Highway, Kegaon, Solapur-413 255, Maharashtra. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Spicer Adventist University, Aundh Road, Gandshkhind Post, Pune-411004, Maharashtra.(Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Swami Ramanand Teerth Marathwada University, Dnayanteerth Vishnupuri, Nanded-431 606, Maharashtra. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' SYMBIOSIS International University, Gram Lavale, Tal Mulshi, Dt. Pune-412115, Maharashtra.(Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Tata Institute of Fundamental Research, Mumbai-400 005. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Tata Institute of Social Sciences, V.N. Purav Marg, Sion Trombay Road, Deonar, Mumbai-400088. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' The Rashtrasant Tukadoji Maharaj Nagpur University, Ravindranath Tagore Marg, Nagpur- 440001, Maharashtra. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Tilak Maharashtra Vidyapeeth, Vidyapeeth Bhavan, Mukundnagar, Pune-411 037, Maharashtra.(Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' University of Mumbai, M.G. Road, Fort, Mumbai-400032. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Yashwant Rao Chavan Maharashtra Open University, Dnyangangotri, Near Gangapur Dam,Nashik-422 222, Maharashtra. (State University).MANIPUR'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Central Agricultural University, PB No. 23, Iroisemba, PO Lamphelpat, Imphal-795 004, Manipur.(Central University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Manipur University, Canchipur, Imphal-795 003, Manipur. (Central University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Sangai International University, Churachandpur, Manipur. (Private University)MEGHALAYA'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' CMJ University, Shillong (Meghalaya) (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Martin Luther Christian University, Dongktieh, Nongrah, Block-1, Shillong – 793006, Meghalaya.(Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Mahatma Gandhi University, P.O. Araimile, Matchakolgre, Tura, West Garo Hills, Meghalaya(Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' North Eastern Hill University, NEHU Campus, Shilong-793 022, Meghalaya. (Central University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Techno Global University, Shillong Polytechnic Campus, Mawlai, Shillong – 793 022.(Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' The Institute of Chartered Financial Analysts of India University, Dankagre (Near BSF Camp), PO araimile, Tura, West Garo Hills – 794101, Meghalaya. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' University of Science & Technology, Meghalaya (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' University of Technology & Management, Shillong, Meghalaya (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' William Carey University, Zoram Villa, Bomfylde Road, Shillong – 793 001, Meghalaya. (Private University)MIZORAM'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Mizoram University, Post Box No. 190, Tanhril, Aizawal-796 012, Mizoram. (Central University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' The Institute of Chartered Financial Analysts of India University, Durtlong North, Aizawal – 796025, Mizoram. (Private University) NAGALAND'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Nagaland University, Lumami, Zunheboto, Nagaland-798627. (Central University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' The Global Open University, Wokha – 797 111, Nagaland (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' The Institute of Chartered Financial Analysts of India University, 6th Mile, Sovima Village,Kohima Road, Dimapur-797112, Nagaland. (Private University)ODISHA'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Berhampur University, Bhanja Bihar, Berhampur-760 007, Dt. Ganjam, Odisha. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Biju Patnaik University of Technology, UGIE Campus, Jail Road, Rourkela – 769004, Odisha.(State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Central University of Orissa, Central Silk Board Building, Landiguda, Koraput-764020, Odisha.(Central University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Centurion University of Technology and Management, Village Alluri Nagar, PO R. Sitapur, ViaUppalada,Paralakhemundi – 761 211, Dt. Gajapati, Odisha. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Fakir Mohan University, Vyasa Vihar, North Campus, Nuapadhi, Balasore-756020, Odisha. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Kalinga Institute of Industrial Technology, Patia, Bhubaneshwar-751 024, Odisha. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' National law University, P.O. Box-28, Cuttack – 753 001, Orissa. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' North Orissa University, Sri Ram Chandra Vihar, Takatpur, Baripada, District Mayurbhanj- 757003, Bhuabaneswar, Odisha. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Orissa University of Agriculture & Technology, Bhubaneswar-751 003, Odisha. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Rama Devi Women’s University, Bhubaneswar, Odisha. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Ravenshaw University, College Square, Cuttak – 753 003, Odisha. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Sambalpur University, Jyoti Vihar, Sambalpur-768 019, Odisha. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Shiksha ‘O’ Anusandhan, J-15, Khandagiri Square, Bhubaneswar-751030, Odisha. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Shri Jagannath Sanskrit Vishwavidyalaya, Srivihar, Puri-752 003, Odisha. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Sri Sri University, Bhubaneswar, Orissa. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Utkal University, Vani Vihar, Bhubaneswar-751 004, Odisha. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Utkal University of Culture, Sardar Patel Hall Complex, Unit II, Bhubaneswar-751 009, Odisha.(State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Veer Surendra Sai University of Technology, Burla-768018, Distt. Sambalpur, Odisha. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Xavier University, Xavier Square, Bhubaneswar, Odisha. (Private University)PUNJAB'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Adesh University, NH-7, Barnala Road, Bathinda, Punjab. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Akal University, Talwandi Sabo – 151302, District Bathinda, Punjab. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Baba Farid University of Health Sciences, Sadiq Road, Faridkot-151 203, Punjab. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Central University of Punjab, City Campus, Mansa Road, Bathinda-151001, Punjab. (Central University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Chandigarh University, Gharuan, The.-Kharar, Dt. Mohali – 140301, Punjab. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Chitkara University, Chandigarh-Patiala National Highway (NH-64), Village Jhansla, Tehsil Rajpura,Distt – Patiala, Panjab – 140 401. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' D.A.V. University, Jalandhar-Pathankot National Highway-44, Village-Sarmastpur, Jalandhar, Punjab. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Desh Bhagat University, Amloh Road, Mandi Gobindgarh, Punjab. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' GNA University, Village-Sri Hargobindgrh, Phagwara, Distt Kapurthala-144401, Punjab.(Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Guru Angad Dev Veterinary & Animal Sciences University, Ferozepur Road, Ludhiana – 141 004, Punjab. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Guru Kashi University, Talwandi Sabo, Dt. Bhatinda, Punjab. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Guru Nanak Dev University, G.T. Road, Amritsar-143 601, Punjab. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Guru Ravidas Ayurved University, Jodhamal Road, Hoshiarpur-146001, Punjab. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Lovely Professional University, Jalandhar-Delhi GT Road (NH-1), Near Chehru Railway Bridge, Phagwara-144411, Punjab. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Maharaja Ranjit Singh State Technical University, Dabwali Road, Bathinda-151001, Punjab.(State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Punjab Agricultural University, Ferozepur, Road, Ludhiana-141 004, Punjab. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Punjabi University, Rajpura Road, Patiala-147 002, Punjab. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Rayat Bahra University, VPO – Sahauran, Tehsil – Kharar, Distt. – Mohali, Punjab – 140105.(Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' RIMT University, Opposite Floating Restaurant, Sirhind Side, Mandi Gobindgarh-147301,Punjab. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Sant Baba Bhag Singh University, Village-Khiala, PO-Padhiana, Dist-Jalandhar-144030,Punjab. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Sant Longowal Institute of Engineering and Technology (SLIET), Village Longowal, District Sangrur-148106, Punjab. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Sri Guru Granth Sahib World University, Sri Lalgidhar Niwas, Plot No. 6, Madhya Marg, Sector – 27-B, Fatehgarh Sahib, Chandigarh (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Thapar Institute of Engineering & Technology, Thapar Technology Campus, Bhadson Road, Patiala-147 004, Punjab. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' The I.K. Gujaral Punjab Technical University, Jalandhar Kapurthala Highway, Kapurthala-144603.(State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' The Rajiv Gandhi National University of Law, Sidhuwal, Bhadson Road, Patiala – 147 001,Punjab. (State University). RAJASTHAN'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Amity University, Rajasthan NH-11C, Kant Kalwar, Jaipur – 303 002, Rajasthan.(Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Banasthali Vidyapith, PO Banasthali Vidyapith-304 022, Dt. Tonk, Rajasthan. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Bhagwant University, Post Box No. 87, Sikar Road, Ajmer – 305 004, Rajasthan (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Birla Institute of Technology & Science, Vidya Vihar, Pilani-333 031, Rajasthan. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Career Point University, Kota, Rajasthan. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Central University of Rajasthan, NH-8, Bandar Sindri, Dist – Ajmer-305801, Rajasthan. (Central University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Dr. Bhimrao Ambedkar Law University, 89, Royal House, Khwasji Ka Bagh, Durgapura, Tonk Road, Jaipur – 302018, Rajasthan. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Dr. K.N. Modi University, INS-1, RIICO Industrial Area Ph-II, PO Newai, Distt. Tonk , Rajasthan – 304 021.(Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Geetanjali University, Udaipur, Rajasthan. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Haridev Joshi University of Journalism & Mass Communication, Information Centre Complex,Sawai Ram Singh Road, Jaipur – 302 004, Rajasthan. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Homoeopathy University, Saipura, Sanganer, Jaipur – 302 029, Rajasthan. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' ICFAI University, Khasra No. 505/1, Village-Jamdoli, Agra Road, Jaipur – 302 031, Rajasthan.(Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' IIHMR University, 1, Prabhu Dayal Marg, Near Sanganer Airport, Jaipur -302 029, Rajasthan.'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' IIS University, Gurukul Marg, SFS, Mansarovar, Jaipur-302020, Rajasthan. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Institute of Advanced Studies in Education of Gandhi Vidya Mandir, Sardarshahr-331 403, Dt. Churu, Rajasthan. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Jagadguru Ramanandacharya Rajasthan Sanskrit University, Village – Madau, Post – Bhankrota, Jaipur - 302026, Rajasthan. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Jagan Nath University, NH-12, Chaksu Bypass, Tonk Road, Jaipur-303901, Rajasthan (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Jai Narain Vyas University, Jodhpur-342 011, Rajasthan. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Jain Vishva Bharati Institute, Tulsi Gram, PO Box No. 6, Ladnun-341 306, Nagaur, Rajasthan.(Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Jaipur National University, Near RTO Office, Jagatpura, Jaipur-302017, Rajasthan (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Janardan Rai Nagar Rajasthan Vidyapeeth, Airport Road, Pratapnagar, Udaipur-313 001,Rajasthan. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Jodhpur National University, Jhanwar Road, Narnadi (Boranada), Jodhpur – 342 001, Rajasthan.(Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Jayoti Vidyapeeth Women’s University, Vedant Gyan Valley, Village- Jharna, Mahala- Jabner,Link Road, Jaipur-Ajmer Expressway (NH-8), Jaipur-303007, Rajasthan (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' J.K. Lakshmipat University, Laliya Ka Vas, PO Mahapura, Ajmer Road, Jaipur – 302 026,Rajasthan. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' J.E.C.R.C. University, Jaipur, Rajasthan. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' LNM Institute of Information Technology, LNM Institute of Information Technology, Gram - Rupa ki Nagal, Post – Sumel, Via Kanata, Dist. – Jaipur – 303 012 (Rajasthan). (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Madhav University, Madhav University, “Madhav Hills”, Rajasthan – 307026. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Maharaja Ganga Singh University, National Highway No. – 15, Jaisalmer Road, Bikaner- 334003,Rajasthan. (Formerly - University of Bikaner, 23, Civil Lines, Bikaner ) (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Maharana Pratap University of Agriculture & Technology, University Campus, Udaipur - 313 001,Rajasthan. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Maharishi Dayanand Saraswati University, Kayad Road, Pushkar Bye Pass, Ajmer-305 009,Rajasthan. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Mahatma Jyoti Rao Phule University, SP-2 &3, Kant Kalwar, RIICO Industrial Area, Tala Mod,NH-I, Achrol, Jaipur (Private Unviersity)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Mahatma Gandhi University of Medical Sciences & Technology, RIICO Institutional Area, Sitapur,Tonk Road, Jaipur – 302 022, (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Maharaj Vinayak Global University, Jaipur, Rajasthan. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Maharaja Surajmal Brij University, M.S.J. College Premises, Bharatpur-321001 (Rajasthan)(State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Maharishi Arvind University, Mundiaramsar, Near Bindayaka Industrial Area, Jaipur-302012,Rajasthan. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Manipal University, Vatika Infotech City, Near GVK Toll Plaza, Jaipur ajmer Experss Way, Post – Thikaria, Jaipur – 302 026, Rajasthan. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Maulana Azad University, Village-Buzawad, Tehsil – Luni, Jodhpur – 342802, Rajasthan.(Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Mewar University, NH 79, Gangrar, Chittorgarh-312901, Rajasthan (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Mody Institute of Technology and Science, Lakshmangarh, District Sikar Rajasthan,.(Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Mohan Lal Sukhadia University, Pratapnagar, Udaipur-313 001, Rajasthan. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' National Law University, NH65, Nagaur Road, Mandore, Jodhpur-342 304, Rajasthan. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' NIMS University, Shobha Nagar, Jaipur-Delhi Highway, Jaipur – 303 121, Rajasthan (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' NIIT University, Neemrana, Rajasthan. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' OPJS University, Rawatsar, Kunjila, Tehsil-Rajgarh, Distt. – Churu, Rajasthan. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Pacific Academic of Higher Education & Research University, (PAHER), Pacific Hills, Airport Road, Pratap Nagar Extension, Debari, Udaipur – 313 024, Rajasthan. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Pacific Medical University, Bhilo Ka Bedla, Bye Pass, National Highway 27, Udaipur, Rajasthan. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Poornima University, Ramchandrapura, Sitapura Extension, Jaipur, Rajasthan. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Pratap University, Sunderpura (Chandwaji), Amer, Delhi-Mumbai Highway, Jaipur, Rajasthan (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Raffles University, Japanese Zone, National Highway 8, Neemrana-201 705, Rajasthan. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Rajasthan Agricultural University, Beechwal, Srinagangar Road, Bikaner-334 006, Rajasthan.(State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Rajasthan Ayurveda University, Jodhpur (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Rajasthan Technical University, Akelgarh, Rawat bhata Road, Kota – 324 010, Rajasthan. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Rajasthan University of Health Sciences, B – 1, Swai Man Singh Road (Opp SMS Hospital),Jaipur (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Rajasthan University of Veterinary & Animal Sciences, Bikaner, Rajasthan. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Raj Rishi Bhartrihari Matsya University, Girls Hostel Building, Babu Shobharam Government Arts College Campus, Alwar, Rajasthan. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' R.N.B. Global University, RNB Global City, Ganganagar Road, Bikaner-334601, Rajasthan. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Sangam University, Bhilwara, Rajasthan. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Sardar Patel University of Police, Security & Criminal Justice, Jodhpur, Rajasthan. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Shekhawati University, Girls Hostel Building, Behind Shri Kalyan Government College, Sikar – 332001, Rajasthan. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Shri Jagdish Prasad Jhabarmal Tibrewala University, Vidya Nagari, Jhunjhunu-Churu Road, Chudela, District Jhunjhunu-333001, Rajasthan. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Shridhar University, Pilani Chirawa Road, Pilani Rajasthan - 333 031. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Singhania University, Pacheribari, Dt. Jhunjunu - 333515, Rajasthan. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Sir Padmapat Singhania University, Bhatewar Udaipur– 313 601, Rajasthan (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Suresh Gyan Vihar University, Mahal, Jagatpura, Jaipur-302017, Rajasthan. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Sunrise University, Bagad Rajput, Tech. Ramgarh, Alwar, Rajasthan (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Tantia University, Hanumangarh Road, Sri Ganganagar – 335 002, Rajasthan (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' University of Kota, Near Kabir Circle, MBS Marg, Kota-324005, Rajasthan. (Rajasthan) (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' University of Engineering & Management, Jaipur, Rajasthan. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' University of Rajasthan, JLN Marg, Jaipur-302 004, Rajasthan. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Vardhman Mahaveer Open University, Rawat Bhata Road, Kota-324 010, Rajasthan. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Vivekananda Global University, Sector-36, NRI Road, Sisyawas, Jagatpura, Jaipur – 303012, Rajasthan. (Private University) SIKKIM'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Eastern Institute for integrated Learning in Management University (EIILM), 8th Mile, Malbasey,Budang, West Sikkim-737121 (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Sikkim- Manipal University, 5th mile, PO Tadong, Gangtok-737 102, Sikkim. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Sikkim University, 6th Mile, Samdur, PO Tadong, Gangtok, Sikkim – 737102 (Central University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Shri Ramasamy Memorial University, 5th Mile, Tadong, Ranipool PO, Gangtok, Sikkim – 737 102.(Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' The Institute of Chartered Financial Analysts of India University, (ICFAI) Ranka Road, Lower Sichey, Gangtok-737101, Sikkim. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Vinayaka Missions Sikkim University, Plot No. 438, N-312 Sang Phatak Road, Middle Tadong, PO Daragaorn, Tadong, East Sikkim – 237 102. (Private University)TAMILNADU'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Academy of Maritime Education and Training, 135, East Coast Road, Kanathur, Chennai-603112,Tamil Nadu. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Alagappa University, Alagappapuram, Karaikudi-630003, Sivaganga District, Taml Nadu. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Amrita Vishwa Vidyapeetham, Amritanagar, Ettimadai, Coimbatore-641 112, Tamil Nadu. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Anna University, Sardar Patel Road, Guindy, Chennai-600 025, Tamil Nadu. (State University)#'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Annamalai University, Annamalainagar-608 002, Chidambaram Tk, Tamil Nadu. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Avinashilingam Institute for Home Science & Higher Education for Women, Coimbatore-641 043,Tamil Nadu. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' B.S. Abdur Rahman Institute of Science and Technology, Seethakathi Estate, GST Road, Vandalur, Chennai – 600 048, Tamil Nadu. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Bharath Institute of Higher Education & Research, 173, Agharam Road, Selaiyur, Chennai- 600073, Tamil Nadu. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Bharathiar University, Maruthamalai Main Road, Coimbatore-641 046, Tamil Nadu. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Bharathidasan University, Palkalaiperur, Tiruchirappalli-620 024, Tamil Nadu. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Central University of Tamil Nadu, C/o Collectorate Annexe, Tiruvarur – 610 001, Tamil Nadu (Central University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Chennai Mathematical Institute, Plot Nos. D-19 & D-20, SIPCOT IT Park, Padur Post, Siruseri – 603 103, Tamil Nadu.(Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Chettinad Academy of Research and Education (CARE), Rajiv Gandhi Salai, Padur,Kelambakkam, Kancheepuram District, Tamil Nadu.(Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Gandhigram Rural Institute, Gandhigram-624 302, Dindigul District, Tamil Nadu. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Hindustan Institute of Technology and Science (HITS), No. 1, Gandhi Salai (Old Mahabalipuram Road), Padur, Kelamballam, Chennai-603103, Tamil Nadu. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Indian Maritime University, East Coast Road, Uthandi, Chennai – 600 119, Tamil Nadu. (Central University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Kalasalingam Academy of Research and Higher Education, Anand Nagar, Krishnankoil, Virudhunagar – 626 190, via Srivilliputhrur, Tamilnadu. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Karpagam Academy of Higher Education, Pollachi Main Road, Coimbatore, (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Karunya Institute of Technology and Sciences, Karunya Nagar, Coimbatore-641 114, Tamil Nadu. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' M.G.R. Educational and Research Institute, Periyar, EVR High Road, (NH-4 Chennai Bangalore Highway), Maduravoyal, Chennai-600 095, Tamil Nadu. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Madurai Kamraj University, Palkalai Nagar, -625 021, Tamil Nadu.(State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Manonmaniam Sundarnar University, Abishekapatti, Thirunelveli-627 012, Tamil Nadu. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Meenakshi Academy of Higher Education and Research, No. 12, Vebuliammal Koil Street, West KK Nagar, Chennai-600078, Tamil Nadu. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Mother Teresa Women’s University, Anandhagiri IV Street, Kodaikanal, Dindigul Dt.-624 102, Tamil Nadu. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Noorul Islam Centre for Higher Education, Kumaracoil, Thuckalay, Kanyakumari District, Tamil Nadu – 629 175. (Deemed University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Periyar Maniammai Institute of Science & Technology (PMIST), Periyar Nagar, Vallam, Thanjavur -613 403, Tamil Nadu (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Periyar University, Periyar Palkalai Nagar, Salem-636 011, Tamil Nadu. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Ponnaiyah Ramajayam Institute of Science & Technology (PRIST), Yagappa Chavadi, Thanjavur – 614 904, Tamilnadu. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' S.R.M. Institute of Sciences and Technology, SRM Nagar, Kattankulathur-603203, Kancheepuram District, Tamil Nadu. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Sathyabama Institute of Science and Technology, Jeppiaar Nagar, Rajiv Gandhi Salai, Chennai- 600 119, Tamil Nadu. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Saveetha Institute of Medical and Technical Sciences, No. 162, Poonamalle High Road, Velappanchavadi, Chennai-600 077, Tamil Nadu. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Shanmugha Arts, Science, Technology, Research & Academy (SASTRA), Thirumalaisamudram, Thanjavur-613 401, Tamil Nadu. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Sri Chandrasekharandra Saraswati Vishwa Mahavidyalaya, Enathur, Kancheepuram-631 561, Tamil Nadu. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Sri Ramachandra Medical College and Research Institute, 1, Ramachandra Nagar, Porur, Chennai-600 116, Tamil Nadu. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' St. Peter’s Institute of Higher Education and Research, Chennai. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Tamil Nadu Teacher Education University, Lady Willingdon College Campus, Kamarajar Salai,Chennai – 600 005, Tamil Nadu. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Tamil University, Thanjavur-613 010, Tamil Nadu. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Tamilnadu Agricultural University, Coimbatore-641 003 (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Tamilnadu Dr. Ambedkar Law University, “Poompozhil, #5, Dr. D.G.S. Dhinakaran Salai,Chennai-600 028, Tamil Nadu. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Tamilnadu Dr. M.G.R. Medical University, No. 69, Anna Salai, Guindy, Chennai-600 032, Tamil Nadu. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Tamilnadu Fisheries University, First Linebeach Road, Nagapattinam – 611001, Tamilnadu.(State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Tamilnadu Music and Fine Arts University, Dr. D.G.S. Dinakaran Salai, Chennai – 600028. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Tamilnadu National Law School, Navalur Kuttapattu, Srirangam Taluk, Tiruchirapalli – 620 009, Tamilnadu. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Tamilnadu Open University, No. 577, Anna Salai, Saidapet, Chennai-600 015, Tamil Nadu. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Tamilnadu Physical Education and Sports University, 8th Floor, EVA Sampat Maaligai, College Road, Chennai, Tamil Nadu. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Tamilnadu Veterinary & Animal Sciences University, Madhavaram Milk Colony, Chennai-600051, Tamil Nadu. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Thiruvalluvar University, Serkkadu, Vellore-632 115, Tamil Nadu. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' University of Madras, Chepauk, Chennai-600 005, Tamil Nadu. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Vel Tech Rangarajan Dr. Sagunthala R & D Institute of Science and Technology, 42, Avade-VelTech Road, Avadi, Chennai-600062, Tamilnadu. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Vel’s Institute of Science, Technology & Advanced Studies (VISTAS), Velan Nagar, P.V. Vaithiyalingam Road, Pallavaram, Chennai-600117, Tamilnadu. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Vellore Institute of Technology, Katpadi Thiruvalam Road, Vellore-632 014, Tamil Nadu.(Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Vinayaka Mission’s Research Foundation, Sankari Main Road, NH 47, Ariyanoor, Salem-636308, Tamil Nadu. (Deemed University) TELANGANA'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Acharya N.G. Ranga Agricultural University, Rajendranagar, Hyderabad-500 030, Telangana. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Dr. B.R. Ambedkar Open University, Prof. G. Ram Reddy Marg, Road No. 46, Jubilee Hills, Hyderabad-500 033, Telangana. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' ICFAI Foundation for Higher Education, Dontanapalli, Shankarapally Road, Hyderabad-501203, Telangana. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' International Institute of Information Technology, Prof. C.R. Road, Gachibowli, Hyderabad- 500032, Telangana. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Jawaharlal Nehru Architecture and Fine Arts University, Mahaveer Marg, Masab Tank, Hyderabad – 500 028, Telangana. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Jawaharlal Nehru Technological University, Kukatpally, Hyderabad-500 085, Telangana. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Kakatiya University, Vidyaranyapuri, Hanamkonda, Warangal-506 009, Andhra Pradesh. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Mahatma Gandhi University, Yellareddyugudem, Nalgonda – 508254, Andhra Pradesh. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Maulana Azad National Urdu University, Gachibowli, Hyderabad-500032. (Central University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' NALSAR University of Law, ‘Justice’, Shameerpet, R.R. Dist., Hyderabad-500101, Telangana. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Nizam’s Institute of Medical Sciences, Punjagutta, Hyderabad – 500082, Telangana. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Osmania University, Administratiave Building, Hyderabad-500 007, Telangana. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Palamuru University, Ayyappa Complex, Opp. Police Head Quarters, Mahabubnagar – 509 001 Andhra Pradesh. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Potti Sreeramulu Telugu University, Lalitha Kala Kshetram, Public Gardens, Nampally, Hyderabad-500 004, Telangana. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Professor Jayashankar Telangana State Agricultural University, Rajendranagar, Hyderabad – 500030, Telangana. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Rajiv Gandhi University of Knowledge Technologies, Hyderabad. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Satavahana University, Malkapur X Road, Chinthakunta, Karimnagar – 505 001, Telangana. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Sri Konda Laxman Telangana State Horticultural University, Rajendranagar, Hyderabad-500030, Telangana. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Telangana University, Dichpally, Nizamabad – 503 322, Telangana. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' The English and Foreign Languages University, Osmania University Campus, Hyderabad-500007. (Central University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' University of Hyderabad, Hyderabad-500 046. (Central University)TRIPURA'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Institute of Chartered Financial Analysts of India, (ICFAI), PO Kamalghat, Agartala-Simna Road,  Mohanpur-799210, Tripura. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Maharaja Bir Bikram University, Agartala, Tripura. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Tripura University, Suryamaninagar, Agartala-799 130, Tripura. (Central University) UTTAR PRADESH'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Aligarh Muslim University, Aligarh-202 002. (Central University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Amity University, Noida, Uttar Pradesh (Private University).(The matter of Amity University is pending in the Hon’ ble Supreme Court of India) (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Babasaheb Bhimrao Ambedkar University, Vidya Vihar, Raebareilly Road, Lucknow-226 025,Uttar Pradesh. (Central University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Banaras Hindu University, Varanasi-221 005, Uttar Pradesh. (Central University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Bhatkhande Music Institute, Kaiserbag, Lucknow-226 001 (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Bundelkhand University, Kanpur Road, Jhansi-284 128, Uttar Pradesh.(State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Babu Banarasi Das University, 55, Babu Banarasi Das Nagar, Lucknow, Uttar Pradesh.(Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Central Institute of Higher Tibetan Studies, Sarnath, Varanasi-221 007. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Chandra Shekhar Azad University of Agriculture & Technology, Nawab Ganj, Kanpur-208 002, Uttar Pradesh. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Chatrapati Shahuji Maharaj Kanpur University, Kalynpur, Kanpur-208 024, Uttar Pradesh. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Choudhary Charan Singh University, Meerut-250 004, Uttar Pradesh. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Dayalbagh Educational Institute, Dayalbagh, Agra-282 005, Uttar Pradesh. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Deen Dayal Upadhyay Gorakhpur University, Gorakhpur-273 009, Uttar Pradesh. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Dr Ram Manohar Lohia Awadh University, Allahabad Road, Faizabad-224 001, Uttar Pradesh.(State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Dr. B.R. Ambedkar University, Paliwal Park, Agra-282 002, Uttar Pradesh. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Dr. Ram Manohar Lohiya National Law University, Sector –D-1, L.D.’A’, Kanpur Road Scheme, Lucknow-226012, Uttar Pradesh. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' G.L.A. University, 17 Km Stone, NH-2, Delhi-Mathura Road, PO Chaumuhan, Mathura-281406,Uttar Pradesh. (Private University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Galgotias University, Plot No. 2, Sector 17 A, Yamuna Expressway, Greater Noida-201203, Dt.Gautam Budh Nagar, Uttar Pradesh. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Gautam Buddha University, Greater Noida, District-Gautam Budh Nagar, Uttar Pradesh – 201 308. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Indian Veterinary Research Institute, Izatnagar-243 122, Uttar Pradesh. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' IFTM University, Lodhipur Rajput, Delhi Road, Moradabad – 244 102, Uttar Pradesh. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Integral University, Dasauli, PO Bas-ha, Kursi Road, Lucknow-226 026, Uttar Pradesh. (Private University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Invertis University, Invertis Village, Bareilly-Lucknow National Highway-24, Bareilly-243123, Uttar Pradesh. ( Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Jagadguru Rambhadracharya Handicapped University, Chitrakoot-210 204, Uttar Pradesh. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Jaypee Institute of Information Technology, A-10, Sector 62, Nodia-201 307, Uttar Pradesh.(Deemed University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Jaypee University, Aligarh Road, Anoopshahar, Dist. Bulandshahar – 203 390, Uttar Pradesh.(Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' J.S. University, Shikohabad, Firozabad, Uttar Pradesh. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Khwaja Moinuddin Chishti Urdu, Arabi~Farsi University, Sitapur-Hardoi Bypass Road, Near IIM,Lucknow, Uttar Pradesh-226013. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' King George Medical University, Lucknow-226 003 (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Madan Mohan Malviya University of Technology, Gorakhpur – 273010, Uttar Pradesh. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' M.J.P.Rohilkhand University, Dori Lal Agarwal Marg, Pilibhit Byepass Road, Bareilly-243 006 , Uttar Pradesh. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Mahatma Gandhi Kashi Vidyapeeth, Varanasi-221 002, Uttar Pradesh. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Maharishi University of Information Technology, Maharishi Bal Vidya Mandir & University Campus, Sitapur Road, Post-Diburia, Lucknow – 226 020, Uttar Pradesh. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Mangalayatan University, 33rd Milestone, Aligarh-Mathura Highway, PO Beaswan, Aligarh- 202145, Uttar Pradesh. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Mohammad Ali Jauhar University, Rampur, UP. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Monad University, Kastla, PO Pilkhua, Kasmabad, Dt. Hapur-245101, Uttar Pradesh. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Narendra Deo University of Agriculture & Technology, Narendra Nagar, Faizabad-224 229, Uttar Pradesh. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Nehru Gram Bharati Vishwavidyalaya, Kotwa – Jamunipur, Dubwali Distt., Allahabad – 221505,Uttar Pradesh (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Noida International University, Plot No.1, Sector 17-A, Yamuna Expressway, Gautam Budh Nagar-201301, Uttar Pradesh. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Rajiv Gandhi National Aviation University, Fursatganj, Dt. Raebareli, Uttar Pradesh. (Central University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Rama University, Rama City, G.T. Road, Mandhana, Kanpur – 209217, Uttar Pradesh. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Rani Lakshmi Bai Central Agricultural University, NH-75, Near Pahuj Dam, Gwalier Road, Jhansi (Utter Pradesh) – 284 003. (Central University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Sam Higginbottom Institute of Agriculture, Technology & Sciences (Formerly Allahabad Agricultural Institute), P.O. Agricultural Institute, Rewa Road, Allahabad – 211 007, Uttar Pradesh. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Sampurnanand Sanskrit Vishwavidyalaya, Varanasi-221 002, Uttar Pradesh. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Santosh University, Santosh Nagar, Ghaziabad, U.P. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Sardar Vallabh Bhai Patel University of Agriculture & Technology, Meerut-250 110 (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Sharda University, Plot No. 32-34, Knowledge Park 3, Greater Noida-201306, Gautam Budh Nagar, Uttar Pradesh (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Shiv Nadar University, Dadri, Gautham Budh Nagar, Uttar Pradesh (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Shobit Institute of Engineering & Technology, NH-58, Modipuram, Roorkee Road, Meerut – 250110, Uttar Pradesh. (Deemed University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Shobhit University, Adarsh Institutional Area, Babu Vijendra Marg, Gangoh, Distt. – Saharanpur – 247 341, (Uttar Pradesh) (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Shri Ramswaroop Memorial University, Hadauri, Deva-Lucknow Road, Dt. Barabanki, Uttar Pradesh. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Swami Vivekanand Subharti University, Subhartipuram, NH-58, Delhi-Haridwar Meerut By Pass Road, Meerut-250005, Uttar Pradesh. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Shri Venkateshwara University, NH-24, Rajabpur, Gajraula, J.P. Nagar, Uttar Pradesh (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Teerthanker Mahaveer University, NH-24, Delhi Road, Moradabad-244001, Uttar Pradesh. (Private University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' The Glocal University, Delhi-Yamunautri Marg, Akbarpur, Mizapur Pole, Tehsil – Behat,Saharanpur – 247001, Uttar Pradesh. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' University of Lucknow, Lucknow-226 007, Uttar Pradesh. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' U.P. King George’s University of Dental Science, Lucknow-226 003, Uttar Pradesh (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Uttar Pradesh Pandit Deen Dayal Upadhyaya Pashu Chikitsa Vigyan Vishwavidyalaya Evam GoAnusandhan Sansthan, Mathura, Uttar Pradesh. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' U.P. Rajarshi Tandon Open University, University Campus, Shantipuram (Sector F), Phaphamau,Allahabad-211 013, Uttar Pradesh. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Uttar Pradesh Technical University, Institute of Engineering and Technology Campus, Sitapur Road, Lucknow-226021, Uttar Pradesh. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Uttar Pradesh Viklang Uddhar Dr. Shakuntala Misra University, Mohan Road, Lucknow-226017, Uttar Pradesh. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' University of Allahabad, Allahabad-211 002, Uttar Pradesh. (Central University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Veer Bahadur Singh Purvanchal University, Jaunpur-222 002, Uttar Pradesh. (State University).UTTARAKHAND'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Dev Sanskriti Vishwavidyalaya, Gayatrikunj, Shantikunj, Hardwar-249 411, Uttarakhand. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' DIT University, Mussoorie Diversion Road, Dehradun – 248 009, Uttarakhand. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Doon University, Mothrowala Road, Kedarpur, PO Ajabpur, Dehradun - 248001.(State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Forest Research Institute, PO IPE, Kaulagarh Road, Dehradun-248 195, Uttarakhand. (DeemedUniversity)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' G.B. Pant University of Agriculture and Technology, Pantnagar-263 145, District Udham Singh Nagar, Uttarakhand. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Graphic Era University, 566/6 Bell Road, Clement Town, Dehradun-248 002, Uttarakhand. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Graphic Era Parvatiya Vishwavidyalaya, 600, Bell Road, Clement Town, Dehradun – 248 002, Uttarakhand. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Gurukul Kangri Vishwavidyalaya, PO Gurukul Kangri, Hardwar-249 404, Uttarakhand. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Hemwati Nandan Bahuguna Garhwal University, Srinagar-246 174, Dt. Garhwal,Uttarakhand.(Converted from State University to Central University) (Central University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Hemwati Nandan Bahuguna Medical Education University, 124, Ganga Vihar, Opposite Roadways Workshop, Haridwar Road, Dehradun – 248 001, Uttarakhand. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Himgiri Zee University, Sheeshambada, PO-Sherpur, Chakrata Road, Via-Sahaspur, Dehradun- 248197, Uttarakhand. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' IMS Unison University, Makkawala Greens, Mussoorie Diversion Road, Dehradun – 248 009, Uttarakhand. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Institute of Chartered Financial Analysts of India (ICFAI), Rajawala Road, Central Hope Town, Selaqui, Dehradun-248197, Uttarakhand. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Kumaun University, Mallital, Nainital-263 001, Uttarakhand. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Motherhood University, Village – Karondi, Post – Bhagwanpur, Roorkee, Distt. Hardwar,Uttarakhand. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Sri Dev Suman Uttarakhand Vishwavidyalay, Badshahithaul, Tehri Garhwal, Uttarakhand- 249199. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Swami Rama Himalayan University, Swami Ram Nagar, Jolly Grant, PO – Doiwala, Dehradun, Uttarakhand. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' University of Patanjali, Patanjali Yogpeeth, Haridwar (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' University of Petroleum and Energy Studies, Bidholi Campus, Energy Acres, P.O Bidholi (Via Prem Nagar) Dehradun – 248 006, Uttarakhand. (Private University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Uttarakhand Ayurved University, Railway Station Road, Harrawala, Dehradun – 248 009,Uttarakhand. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Uttarakhand Open University, Teenpani Bypass Road, Behind Transport Nagar, PO Industrial Estate, Haldwani, District Nainital-263139, Uttarakhand. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Uttarakhand Sanskrit University, Delhi-Haridwar National Highway, PO Bahadrabad, Haridwar- 249 402, Uttrakhand (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Uttrakhand Technical University, Post Office Chandavari, Suddhowala, Dehradun-248007,Uttrakhand (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Veer Chandra Singh Garhwali Uttarakhand University of Horticulture & Forestry, Bharsar, Dt.Pauri Garhwal-246123, Uttarakhand. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Uttaranchal University, Arcadia Grant, PO Chandanwari, Premnagar, Dehradun – 248 007,Uttarakhand. (Private University)WEST BENGAL'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Adamas University, Barasat, Barrackpore Road, Barberia, PO Jagannathpur, PS Barasat,Kolkata – 700126, West Bengal. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Aliah University, Salt Lake Campus, DN-41, Sector-V, Salt Lake City, Kolkata-700091, West  Bengal. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Amity University, Rajarhat, New Town, Dist. North 24 Parganas, West Bengal. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Bankura University, Puabagan Camp Office, PO Bhagabandh, Dist. Bankura-722146, West Bengal. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Bidhan Chandra Krishi Vishwavidyalaya, PO Krishi Vishwavidyalaya, Mohanpur, District Nadia- 741 252, West Bengal. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Brainware University, 398, Ramkrishnapur Road, Barasat, Kolkata – 700 124, North 24 Pgs,West Bengal. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Cooch Behar Panchanan Barma University, Vibekananda Road, Cooch Behar – 736101, WestBengal. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Diamond Harbour Women’s University, c/o Fakir Chand College, Diamond Harbour, South 24 Parganas, West Bengal – 743331. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Gaur Banga University, Rabindra Avenue, Malda College Campus, P.O. & Dist- Malda – 732 101, (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Jadavpur University, 188, Raja S.C. Mallik Road, PO Jadavpur, Kolkata-700 032. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' JIS University, Agarpara, District North 24 Parganas, West Bengal. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Kazi Nazrul University, Old ADDA Office Building (behind Asansol Girls College), PO – Asansol-713304, Dist – Burdwan, West Bengal. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Maulana Abul Kalam Azad University of Technology, BF-142, Salt Lake, Sector 1, Bidhannagar,Kolkata-700064, West Bengal. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Netaji Subhash Open University, DD-26, Sector-I, Salt Lake City, Kolkata-700 064. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Presidency University, 86/1 College Street, Kolkata – 700 073, West Bengal (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Rabindra Bharati University, Emerald Bower Campus, 56-A, BT Road, Kolkata-700 050. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Raiganj University, PO-Raiganj, Dist. Uttar Dinajpur-733134, West Bengal. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Ramakrishna Mission Vivekananda Educational and Research Institute, Belur Math, Howrah,West Bengal (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Seacom Skills University, Village – Kendradanga, PO – Sattore, PS – Panrui, Dist. – Birbhum- 731236, West Bengal. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Sidho-Kanho-Birsha University, Administrative Building, Purulia Zilla Parishad, Jubilee Compound, Purulia – 723101, West Bengal. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Techno India University, EM – 4, Sector-V, Salt Lake, Kolkata – 700 091, West Bengal. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' The Neotia University, Jhinga, Sarisa, D.H. Road, 24 Parganas (S), West Bengal-743368.(Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' The West Bengal National University of Juridical Science, NUJS Bhava, 12 LB Block, Sector-III,Salt Lake City, Kolkata (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' The West Bengal University of Health Sciences, DD-36, Secotor-1, Salt Lake, Kolkata-700 064 (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' The West Bengal University of Teachers’ Training, Education Planning and Administration, 25/2 & 25/3, Ballygunge Circular Road, Kolkata – 700019, West Bengal. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' University of Burdwan, Rajbati, Burdwan-713 104, West Bengal. (State University). Burdwan University, Rajbati, Burdwan-713 104, West Bengal. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' University of Calcutta, 87/1, College Street, Kolkata-700 073. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' University of Engineering and Management, University Area, Plot No. III-B/5, Main Arterial Road (East-West), New Town, Action Area-III, Kolkata-700156, West Bengal. (Private University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' University of Kalyani, Kalyani-741 235, Nadia, West Bengal. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' University of North Bengal, Raja Ram Mohanpur, PO North Bengal University-734013, District Darjeeling, West Bengal. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Uttar Banga Krishi Vishwavidyalaya, District-Cooch Behar-736 165 (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Vidyasagar University, West Midnapore-721 102, West Bengal. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Vishwa Bharati University, Shantiniketan-731 235, West Bengal. (Central University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' West Bengal State University, Berunanpukuria, Malikapur Barasat, 24 Parganas (North), Kolkata – 700126, West Bengal.(State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' West Bengal University of Animal and Fishery Sciences, 68, Khudiram Bose Sarani, Kolkata- 700037, West Bengal. (State University).NCT OF DELHI'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Bharat Ratna Dr. B.R. Ambedkar University, Lothian Road, Kashmere Gate, Delhi – 110 006. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Delhi Pharmaceutical Sciences & Research University, DIPSAR Campus, Sector-III, Pushp Vihar, New Delhi. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Delhi Technological University, Shahbad Daultapur, Bawana Road, Delhi -110042. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Guru Gobind Singh Indraprastha Vishwavidyalaya, Sector 16 C, Dwarka, Delhi-110 078. (State University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Indian Agricultural Research Institute, Pusa, New Delhi-110 012. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Indian Institute of Foreign Trade, IIFT Bhawan, Qutab Industrial Area, New Delhi-110 016. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Indian Law Institute, Bhagwandas Road, New Delhi-110 001 (Deemed University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Indira Gandhi National Open University, Maidan Garhi, New Delhi-110 068. (Central University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Indira Gandhi Delhi Technical University for Women, Kashmere Gate, Delhi – 110 006. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Indraprastha Institute of Information Technology, Near Govindpuri Metro Station, Okhla Industrial Estate, Phase –III, New Delhi-110020. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Institute of Liver and Biliary Sciences (ILBS), D-1 Vasant Kunj, New Delhi-110 070. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Jamia Hamdard, Hamdard Nagar, New Delhi-110 062. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Jamia Mallia Islamia University, Maulana Mohammad Ali Jauhar Marg, Jamia Nagar, Okhla, New Delhi-110 025. (Central University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Jawaharlal Nehru University, New Mehrauli Road, New Delhi-110 067. (Central University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' National Institute of Educational Planning and Administration, 17-B, Sri Aurobindo Marg, New Delhi – 110 016.(Deemed University).'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' National Law University, Sector, 14, Dwarka, New Delhi-110078. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' National Museum Institute of History of Art, Conservation and Museology, Janpath, New Delhi- 110 011. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Rashtriya Sanskrit Sansthana, 56-57, Institutional Area, Janak Puri, New Delhi-110 058. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Shri Lal Bahadur Shastri Rashtriya Sanskrit Vidyapith, B-4, Qutub Institutiona Area, Katwaria Sarai, New Mehrauli Road, New Delhi-110 016. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' South Asian University, Akbar Bhawan Campus, Chanakyapuri, New Delhi – 110 021. (Established under Central Act)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' TERI School of Advanced Studies, Plot No. 10, Institutional Area, Vasant Kunj, New Delhi- 110070. (Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' University of Delhi, Delhi-110007. (Central University)UT OF CHANDIGARH'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Panjab University, Sector 14, Chandigarh-160 014. (State University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Punjab Engineering College, Chandigarh-160 009. (Deemed University) PONDICHERRY'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Pondicherry University, R. Venkataraman Nagar, Kalapet, Puducherry - 605 014. (Central University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Sri Balaji Vidyapeeth, Mahatma Gandhi Medical College Campus, Pondy-Cuddalore Main Road, Pillaiyarkuppam, Pondicherry – 607 402(Deemed University)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''3'' As StandardPropID, '' Other'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime UNION
                      Select  ''4'' As StandardPropID, ''B.A'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''4'' As StandardPropID, ''B.Arch'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''4'' As StandardPropID, ''BCA'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''4'' As StandardPropID, ''B.B.A'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''4'' As StandardPropID, ''B.COM'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''4'' As StandardPropID, ''B.ED'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''4'' As StandardPropID, ''BDS'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''4'' As StandardPropID, ''BHM'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''4'' As StandardPropID, ''B.Pharm'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''4'' As StandardPropID, ''B.Sc'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''4'' As StandardPropID, ''B.Tech / B.E'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''4'' As StandardPropID, ''LLB'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''4'' As StandardPropID, ''MBBS'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''4'' As StandardPropID, ''Diploma'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''4'' As StandardPropID, ''BVSC'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''4'' As StandardPropID, ''Other'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime UNION
                      Select  ''5'' As StandardPropID, ''2020'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''2019'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''2018'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''2017'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''2016'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''2015'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''2014'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''2013'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''2012'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''2011'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''2010'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''2009'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''2008'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''2007'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''2006'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''2005'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''2004'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''2003'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''2002'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''2001'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''2000'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''1999'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''1998'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''1997'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''1996'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''1995'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''1994'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''1993'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''1992'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''1991'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''1990'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''1989'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''1988'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''1987'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''1986'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''1985'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''1984'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''1983'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''1982'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''1981'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''1980'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''1979'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''1978'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''1977'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''1976'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''1975'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''1974'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''1973'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''1972'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''1971'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''1970'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''1969'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''1968'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''1967'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''1966'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''1965'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''1964'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''1963'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''1962'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''1961'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''1960'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''1959'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''1958'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''1957'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''1956'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''1955'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''1954'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''1953'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''1952'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''1951'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''1950'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''1949'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''1948'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''1947'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''1946'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''1945'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''1944'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''1943'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''1942'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''1941'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''5'' As StandardPropID, ''1940'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime UNION
                      Select  ''6'' As StandardPropID, ''Aptech N Power Hardware & Networking'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''NIIT Ltd'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Seed Infotech'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''BEE Education'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Sami Infotech'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Jija BAI ITI'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Ravi Computer Training Institute'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Iborderless India Pvt Ltd'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Indian Institute Of Tourism & Travel Mgmt'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Expert Computer Education'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Mech Ci CADD'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Lalani Computer Academy'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Prafulla Kanan, Kolkata, West Bengal - 700101,India'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Gateway Technologies'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''ShineIT Training Institute Hyderabad'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''CADD Centre'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Image Multimedia'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Apollo Computer Education'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Aurus Network Infotech Pvt Ltd'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Shah Faisal Entertainment & Acting Institute'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Shareware Technologies'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''St Angelos Professional Education'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Deepak Computer & Management Institute'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Kennis Training Institute'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Cat Education Pvt Ltd'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Ativs Asian Technical Institute For Vocational Studies'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''ClassTimes'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''K M S Educational Consultants Pvt Ltd'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Institute Of Robotics And Automation'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''NIIT Barrackpore Centre'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Accura Infotech'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Computer Centre For Information Tech'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Design Academy'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Aptech Ltd'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Jspiders'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Besant Technologies'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Apec Computer Education'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''W B Govt Youth Computer Training Centre'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Jadhav Computer Institute'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''CMC LTD'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''NITS COMPUTERS EDUCATION'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Guidance Computer Training Institution'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''TalentHome Solutions Pvt. Ltd.'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Sla'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''M S World IT Training Centre'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Grand Computer Education Pvt Ltd'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Datapro'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Keerti Computer Institute'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Uttara Infosolutions Pvt Ltd'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Softwarewala'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Niit Ltd'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Setwin Institute Of Management & Computers'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Sharada Computer Education'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Royal Infotech'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Balc Cadd'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''LAL Bahadur Shastri Training Institute'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Ssg Solutions Pvt Ltd'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Broadlight Info Solutions PVT LTD'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Future Tense Computer Education'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''BEE Education'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Analytics Training Institute'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Winnersit'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''COMPUTER NET STUDY CIRCLE'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Dum Dum Institute Study Of Information Technology'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Setwin Institute Of Management'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''George Telegraph Training Institute'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''G E Infotech Pvt Ltd'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''SUNRAYS TECHNOLOGIES'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Innoware Technology PVT LTD'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Ducat'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''IIHT'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Epsilon Infotech Computer Institute'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Talent Sprint Private Limited'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Badruka Junior College For Girls'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Super Computer Institute'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''ATI Software Education'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Innovent Engineering Solutions Pvt Ltd (Forma'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Sqtl Camp'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''CSC Computer Education'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Hcl Career Development Centre'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Incomp Software Technologies Pvt Ltd'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Kpm Institute Of Technology And Multimedia'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''NCIT'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Visa Computer Institute'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Keerti Computer Classes'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Aptech Computer Education'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''IP Expert India Inc'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Thinkdesk'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Ativs Asian Technical Institute For Vocational Studies'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''AP Electronics DEV Corp LTD'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Infinity'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Orator Education Pvt Ltd'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Zed Career Academy'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Csc Computer Education'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Deccans IT Hub'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''AVENTURES INSTITUTE OF STUDIES'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''SAI Info Solution'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Srm Infotech'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''NVIT'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''M J Dance Studio'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''NIIT'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Technova Solutions'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Cadd Centre'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Alphatronics Solutions'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Accura Infotech'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Vira Freelance Coaching'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Indumatis Bites Computer Education'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Systems Domain'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Gnitt Computer Education'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Cadd Centre'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''GTTI'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Niit Ltd'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Nice Infotech Computer Centre'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Raj Computers Academy'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Vins India Pvt Ltd'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Niit Ltd'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Infohub World Towords Excellence'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Educadd'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Fratello InnoTech'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''C M C Ltd'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''NIIT Noida Sector 62 Centre'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Rec Computer Education & Spoken English'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''CSC Computer Education'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Linus Computers'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Ceit Computer Institute'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Bluebay Soft Solutions'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''HCL CDC'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Tamanna IT Solutions PVT LTD'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''ECIL-ECIT Andul'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Dey Computer Of Technology'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Technocorp Solutions Pvt Ltd'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Aimclear Technologies'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''N S C T Computer Academy'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Brainware'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Geoinsyssoft'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Aptech Computer Education'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Cranes Softwares International Limited'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Apollo Computer Education Ltd'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Ria Institute Of Technology'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''CMC Academy A Tata Enterprise'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''NIIT Ltd'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Raj Computer Academy'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Srm Infotech'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''M C TRAINING CENTRE'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Me Consultant'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''F Tec Computer Education'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Centre For Development Of Advanced Computing'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Madras Computer Academy'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Aniisoft'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Mkt Computers'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Kedar Centre'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Robo Edutech India Pvt Ltd'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Niit Ltd'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Infohub World Towords Excellence'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''SBL Computer Education'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Niit Ltd'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Global Career Academy'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Soft Tech Computer'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''CMC Limited'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Oxford Software Institute'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Ducat'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Oyster Solutions'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Keerti Computer Institute'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Career Point Computer Institute'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Transed Software Education'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Jayam Computer Centre'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Catalyst Softwares & Solutions'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Shrikant Computers'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Aakruthi Educational Academy'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Technova Solutions'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Cadd Focus'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''KUBE Technologies'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''STC Technologies'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Novasoft Solutions'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Shree Sharda Technical Institute'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Aroha Technologies'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Velankar Group Of Classes'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Vepsun Technologies Pvt Ltd'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Lal Bahadur Shastri Training Institute'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Micro Computer Associates'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Aditya Computer Institute'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Roys Infotech'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Computer Coaching Classes'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Capital Computers'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Xenitis Technolab PVT LTD Corp Office'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Pragat Computer Education'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Lal Bahadur Shastri Training Institute'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''GLOBALComputer Education'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Grand Computer Education Pvt Ltd'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Sri Krishna Computers'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Dekrinsofttechnologies'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''VSIT'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Kmr Software Services'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Aptech Computer Education'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Niit Delhi Kalkaji Tughlkabad Extension Centre'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Lal Bahadur Shastri Training Institute'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Vintech Computer Institute (Registered Office)'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Csc Computer Education'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Sunrise Institute Of Technology'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''MICE Computer Education'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Varehouse Infotech Pvt Ltd'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Accel Academy Limited'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Bitech Computer Education'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Disha Classes'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Shah Faisal Entertainment & Acting Institute'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Image Array'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Pradeep Classes'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Sol Vel Training Solutions'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Matrix Info Academy'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Niit Ltd'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Digiscape Gallery'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Faustine Computer Academics'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Competency Center Software Quality'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Indus IT Valley'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Winnersit'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Prognoz Technologies Pvt Ltd'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Animatix Computer Education'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Java Training Center'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Frequency Computer Institute FCI'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Career Point Computer Institute'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Profound Edutech Pvt Ltd'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Aprameyah Technologies Pvt Ltd'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Hurray'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Gt Infotech'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Arione Consulting Pvt Ltd'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''V Tech Computer Education'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''High Technologies Solutions'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''National Institute Of Computer Technology'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Compro Computer Education'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''FACT COMPUTER EDUCATION'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''A I I M'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Supreme Computer Solutions'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Artech Computer Training Institute'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''CMC Ltd'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Prabhu Computers'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Arizona Infotech'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Indgen Life Technologies Pvt Ltd'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''SaiTech Manpower Pvt. Ltd.'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Infyinfotech Training & Development Solutions Pvt Ltd'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Aptech Computer Educational Institute'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Aptech Computer Education'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Tally Academy'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Infogenex Technologies PVT LTD'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Iprimed Education Solutions Pvt Ltd'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Ap Electronics Development & Computers Society'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Mitcon E School'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Stc Technologies'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''I Tech Media'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''A Square Soft Solutions'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Computer Coaching Centre'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''6'' As StandardPropID, ''Dey Computer Of Technology'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime UNION
                      Select  ''6'' As StandardPropID, ''Other'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime UNION
                      Select  ''7'' As StandardPropID, ''Application Developer'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''7'' As StandardPropID, ''Application Support Analyst'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''7'' As StandardPropID, ''Applications Engineer'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''7'' As StandardPropID, ''Associate Developer'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''7'' As StandardPropID, ''Computer and Information Systems Manager'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''7'' As StandardPropID, ''Computer Systems Manager'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''7'' As StandardPropID, ''Customer Support Administrator'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''7'' As StandardPropID, ''Customer Support Specialist'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''7'' As StandardPropID, ''Data Center Support Specialist'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''7'' As StandardPropID, ''Data Quality Manager'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''7'' As StandardPropID, ''Database Administrator'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''7'' As StandardPropID, ''Desktop Support Manager'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''7'' As StandardPropID, ''Desktop Support Specialist'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''7'' As StandardPropID, ''Developer'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''7'' As StandardPropID, ''Director of Technology'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''7'' As StandardPropID, ''Front End Developer'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''7'' As StandardPropID, ''Help Desk Specialist'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''7'' As StandardPropID, ''Help Desk Technician'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''7'' As StandardPropID, ''Information Technology Coordinator'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''7'' As StandardPropID, ''Information Technology Director'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''7'' As StandardPropID, ''Information Technology Manager'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''7'' As StandardPropID, ''IT Support Manager'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''7'' As StandardPropID, ''IT Support Specialist'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''7'' As StandardPropID, ''IT Systems Administrator'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''7'' As StandardPropID, ''Java Developer'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''7'' As StandardPropID, ''Junior Software Engineer'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''7'' As StandardPropID, ''Management Information Systems Director'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''7'' As StandardPropID, ''.NET Developer'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''7'' As StandardPropID, ''Network Architect'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''7'' As StandardPropID, ''Network Engineer'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''7'' As StandardPropID, ''Network Systems Administrator'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''7'' As StandardPropID, ''Programmer'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''7'' As StandardPropID, ''Programmer Analyst'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''7'' As StandardPropID, ''Security Specialist'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''7'' As StandardPropID, ''Senior Applications Engineer'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''7'' As StandardPropID, ''Senior Database Administrator'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''7'' As StandardPropID, ''Senior Network Architect'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''7'' As StandardPropID, ''Senior Network Engineer'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''7'' As StandardPropID, ''Senior Network System Administrator'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''7'' As StandardPropID, ''Senior Programmer'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''7'' As StandardPropID, ''Senior Programmer Analyst'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''7'' As StandardPropID, ''Senior Security Specialist'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''7'' As StandardPropID, ''Senior Software Engineer'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''7'' As StandardPropID, ''Senior Support Specialist'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''7'' As StandardPropID, ''Senior System Administrator'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''7'' As StandardPropID, ''Senior System Analyst'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''7'' As StandardPropID, ''Senior System Architect'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''7'' As StandardPropID, ''Senior System Designer'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''7'' As StandardPropID, ''Senior Systems Analyst'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''7'' As StandardPropID, ''Senior Systems Software Engineer'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''7'' As StandardPropID, ''Senior Web Administrator'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''7'' As StandardPropID, ''Senior Web Developer'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''7'' As StandardPropID, ''Software Architect'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''7'' As StandardPropID, ''Software Developer'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''7'' As StandardPropID, ''Software Engineer'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''7'' As StandardPropID, ''Software Quality Assurance Analyst'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''7'' As StandardPropID, ''Support Specialist'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''7'' As StandardPropID, ''Systems Administrator'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''7'' As StandardPropID, ''Systems Analyst'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''7'' As StandardPropID, ''System Architect'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''7'' As StandardPropID, ''Systems Designer'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''7'' As StandardPropID, ''Systems Software Engineer'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''7'' As StandardPropID, ''Technical Operations Officer'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''7'' As StandardPropID, ''Technical Support Engineer'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''7'' As StandardPropID, ''Technical Support Specialist'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''7'' As StandardPropID, ''Technical Specialist'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''7'' As StandardPropID, ''Telecommunications Specialist'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''7'' As StandardPropID, ''Web Administrator'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''7'' As StandardPropID, ''Web Developer'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''7'' As StandardPropID, ''Webmaster'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime Union
                      Select  ''7'' As StandardPropID, ''Other'' As StandardPropListName, ''1'' As IsActive, ''0'' As IsDeleted, ''1'' As AddUserID, CURRENT_TIMESTAMP As AddUserTime                 
              ; 
        ';
      EXECUTE stmt;
      DEALLOCATE PREPARE stmt;  