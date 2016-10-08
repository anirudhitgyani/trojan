CALL PrepareInsertStatement('itgyaniv01','profiletopic');

CALL ManageProfileDefaultCourse('1');
CALL GetProfileCourse('1');
CALL ManagePortalSignIn('text','yes');

Insert InTo profiletopic (ProfileCourseID,  IsCurrent, TopicID, TopicSRNO, URL01, URL01Locked, URL01Status, URL02, URL02Locked, URL02Status, URL03, URL03Locked, URL03Status, URL04, URL04Locked, URL04Status, Doc01, Doc01Locked, Doc01Status, Doc02, Doc02Locked, Doc02Status, Doc03, Doc03Locked, Doc03Status, Doc04, Doc04Locked, Doc04Status ) 
SELECT PC.ProfileCourseID, TP.TopicID, TP.TopicSRNO, '0' As IsCurrent,
       TP.URL01,TP.URL01Locked ,   CASE LENGTH( TRIM( TP.URL01)) WHEN  0 THEN '1' ELSE '0' End As URL01Status, 
       TP.URL02,TP.URL02Locked ,   CASE LENGTH( TRIM( TP.URL02)) WHEN  0 THEN '1' ELSE '0' End As URL02Status,
       TP.URL03,TP.URL03Locked ,   CASE LENGTH( TRIM( TP.URL03)) WHEN  0 THEN '1' ELSE '0' End As URL03Status,
       TP.URL04,TP.URL04Locked ,   CASE LENGTH( TRIM( TP.URL04)) WHEN  0 THEN '1' ELSE '0' End As URL04Status,
       TP.Doc01,TP.URL01Locked ,   CASE LENGTH( TRIM( TP.Doc01)) WHEN  0 THEN '1' ELSE '0' End As Doc01Status, 
       TP.Doc02,TP.URL02Locked ,   CASE LENGTH( TRIM( TP.Doc02)) WHEN  0 THEN '1' ELSE '0' End As Doc02Status,
       TP.Doc03,TP.URL03Locked ,   CASE LENGTH( TRIM( TP.Doc03)) WHEN  0 THEN '1' ELSE '0' End As Doc03Status,
       TP.Doc04,TP.URL04Locked ,   CASE LENGTH( TRIM( TP.Doc04)) WHEN  0 THEN '1' ELSE '0' End As Doc04Status
FROM profilecourse PC INNER JOIN topic TP On PC.CourseID = TP.CourseID WHERE PC.ProfileID = 1 And PC.CourseID = 1
      AND TP.TopicID = (Select MIN(topic.TopicID) FROM topic WHERE PC.CourseID = 1);


Insert InTo profiletopic (ProfileCourseID,  IsCurrent, TopicID, TopicSRNO, URL01, URL01Locked, URL01Status, URL02, URL02Locked, URL02Status, URL03, URL03Locked, URL03Status, URL04, URL04Locked, URL04Status, Doc01, Doc01Locked, Doc01Status, Doc02, Doc02Locked, Doc02Status, Doc03, Doc03Locked, Doc03Status, Doc04, Doc04Locked, Doc04Status ) 
              SELECT PC.ProfileCourseID, TP.TopicID, TP.TopicSRNO, '1' As IsCurrent,
                     TP.URL01,TP.URL01Locked ,   CASE LENGTH( TRIM( TP.URL01)) WHEN  0 THEN '1' ELSE '0' End As URL01Status, 
                     TP.URL02,TP.URL02Locked ,   CASE LENGTH( TRIM( TP.URL02)) WHEN  0 THEN '1' ELSE '0' End As URL02Status,
                     TP.URL03,TP.URL03Locked ,   CASE LENGTH( TRIM( TP.URL03)) WHEN  0 THEN '1' ELSE '0' End As URL03Status,
                     TP.URL04,TP.URL04Locked ,   CASE LENGTH( TRIM( TP.URL04)) WHEN  0 THEN '1' ELSE '0' End As URL04Status,
                     TP.Doc01,TP.URL01Locked ,   CASE LENGTH( TRIM( TP.Doc01)) WHEN  0 THEN '1' ELSE '0' End As Doc01Status, 
                     TP.Doc02,TP.URL02Locked ,   CASE LENGTH( TRIM( TP.Doc02)) WHEN  0 THEN '1' ELSE '0' End As Doc02Status,
                     TP.Doc03,TP.URL03Locked ,   CASE LENGTH( TRIM( TP.Doc03)) WHEN  0 THEN '1' ELSE '0' End As Doc03Status,
                     TP.Doc04,TP.URL04Locked ,   CASE LENGTH( TRIM( TP.Doc04)) WHEN  0 THEN '1' ELSE '0' End As Doc04Status
              FROM profilecourse PC INNER JOIN topic TP On PC.CourseID = TP.CourseID WHERE PC.ProfileID = 1 And PC.CourseID = 2 ORDER BY TP.TopicID asc Limit 1 ;