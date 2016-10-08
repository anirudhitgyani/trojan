<html>
   
   <head>
      <title>Sending HTML email using PHP</title>
   </head>
   
   <body>
        
      <?php
         $to = "boraste.sagar123@gmail.com";
         $subject = "Welcome to the IT Gyani program.";
         $message = "<b>Dear  </b>";
         $message .= "<p>Success with ITGyani</p>";
         
                  
         $header = "From:support@itgyani.com \r\n";
         $header .= "Cc:anirudh272@gmail.com \r\n";
         $header .= "MIME-Version: 1.0\r\n";
         $header .= "Content-type: text/html\r\n";
         
         $retval = mail ($to,$subject,$message,$header);
         
         if( $retval == true ) {
            // echo "Message sent successfully...";
         }else {
            echo "Message could not be sent...";
         }
      ?>
      
   </body>
</html>