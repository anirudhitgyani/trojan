<html>
   
   <head>
      <title>Sending HTML email using PHP</title>
   </head>
   
   <body>
      
      <?php
         $to = "shaikh.avwal@gmail.com";
         $subject = "Welcome to the IT Gyani program.";
         $message = "<b>Dear ".$user_name."</b>";
         $message .= "<p>Welcome to the IT Gyani program.<br/>
This program ensures that you have the requisite skills -both technical and soft- to secure a job in the IT industry.</p><br/>
			<p>There are 4 broad parts to the program..</p><br/>
			<p>1. In foundation courses you will be exposed to the world of IT careers and basic communication skills. <br/>
			2. In counseling you will be evaluated psychometrically and based on your choice and performance you will guided to a career track based on industry requirements <br/>
			3. In Career track you will be taught complete stack courses for the career along with Advanced soft skills like interview techniques etc. <br/>
			4. Live environment will be provided for hands in experience in your tech stack
The duration of the course will be around 6 months if you are an average student and spend about 2 hours on the site, however it will vary as it is online and the number of tracks you do.
You will have access to the libraries and courses as long as you wish...
Through the program you can also Chat with counselors, instructors and course mates online.
Apart from this you can enjoy the following benefits as part of the program. </p>

			<p><a href='".$active_link."'>Please Activate Your Account </a></p>

			<p>
				(Other benefits from website not mentioned here)
				<br/>
				The IT Gyani program is also currently offering 100% job guarantee, which means we will refund your entire fees if you don't secure a job within 6 months after you graduate.
				<br/><br/>
				Warm regards 
				<br/>
				Team IT Gyani<br/>
				www.itgyani.com";
         
		 
		 $email = "support@itgyani.com";
		 
         $header = "From:$email \r\n";
         //$header .= "Cc:anirudh272@gmail.com \r\n";
         $header .= "MIME-Version: 1.0\r\n";
         $header .= "Content-type: text/html\r\n";
         
         $retval = mail ($to,$subject,$message,$header);
         
         if( $retval == true ) {
            echo "Message sent successfully...";
         }else {
            echo "Message could not be sent...";
         }
      ?>
      
   </body>
</html>