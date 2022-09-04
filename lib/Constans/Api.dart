class Api{

  //************************************************************************************************
  static const String first_key="RoyalBoardSecret_Token_for_First_Time_Connectino";
  static const String main_url="https://als-af.com/public/";
   //  static const String main_url="http://192.168.0.179/learning_platform/public/";
   // static const String main_url="http://192.168.43.226/learning_platform/public/";
   static const String image=main_url+"uploads/images/";
   static const String pdf=main_url+"uploads/files/pdf/";
   static const String voice=main_url+"uploads/files/voice/";
   static const String Firster=main_url+"Firster/";
   static const String teacherFirster=Firster+"teachers/";
   static const String teacherUrl=main_url+"royal_teachers/";
   static const String CustomerUrls=main_url+"royalboard/";
   static const String gamesurls=main_url+"royalboard/games/";
   //************************************************************************************************
   //Launchs Urls

   static const String Countries_Url=Firster+"secret_countries_uu";

   //Auth urls

   static const String teachers_login_url=Firster+"teachers/login";
   static const String login=Firster+"login";
   static const String Register=Firster+"register";

   //************************************************************************************************


   //Customer Subjects
   static const String subject = CustomerUrls+"subJects";
   static const String bestStudents = CustomerUrls+"bestStudents";
   //************************************************************************************************
   //Anki  urls
   static const String ankiGroup=CustomerUrls+"Anki/";
   static const String ankiSubjects=ankiGroup+"all";
   static const String ankiChapters=ankiGroup+"ankiChapters/";
   static const String ankiElements=ankiGroup+"ankiElements/";
   static const String buyAnki=ankiGroup+"buy/";

   // ************************************************************************************************
   //customers urls
   static const String fcm = CustomerUrls+"RoyalBoardFcm";
   static const String customerRefresh = CustomerUrls+"userRefresh";
   static const String customerUpdate = CustomerUrls+"updateuserinfo";
   static const String feedback = CustomerUrls+"feedback";
   //************************************************************************************************

   //Lesson urls
   static const String like=CustomerUrls+"likeLesson";
   static const String rating=CustomerUrls+"ratingLesson";
   static const String lessonPostComment=CustomerUrls+"lessonPostComment";
   static const String allLessonComments=CustomerUrls+"allLessonComments/";
   static const String commentLike=CustomerUrls+"commentLike";
   static const String deleteComment=CustomerUrls+"deleteComment";
   static const String lookAtComment=CustomerUrls+"lookAtComment";

   //************************************************************************************************

   //Replies urls
   static const String commentReplies=CustomerUrls+"commentReplies/";
   static const String createCommentReplay=CustomerUrls+"createCommentReplay/";
   static const String removeCommentReplay=CustomerUrls+"removeCommentReplay/";
   static const String allCommentsComments=CustomerUrls+"allCommentsComments/";


   //************************************************************************************************

   //games urls
   static const String infogameslevels=gamesurls+"infogame";
   static const String postAnswerUrl=gamesurls+"customeranswer";

   //************************************************************************************************


//all grades
static const String allGrades=CustomerUrls+"secret_grades";
static const String postGrades=CustomerUrls+"postGrades";

  //************************************************************************************************

  /// Customer Exams
  static const String customerExams=CustomerUrls+"exams";
  static const String customeranswerExam=CustomerUrls+"answerExam";
  static const String customerSubjectExams=CustomerUrls+"examsOfSubjects";

  /// Customer Results Urls
  static const String studentResults=CustomerUrls+"studentResults";

//Company Notification
  static const companyNotification=CustomerUrls+"company_notification";
  static const schoolNotification=CustomerUrls+"school_notification";
  static const gradeNotification=CustomerUrls+"grade_notification";

  //************************************************************************************************


  /// Teacher Api Constants Section
  ///
  static const teacherLogin=teacherFirster+"login";

  static const String teacherCompanyNotification=teacherUrl+"company_notification";
  static const String getGradeNotifications=teacherUrl+"getGradeNotifications";
  static const String updateTeacher=teacherUrl+"update";
  static const String createExam=teacherUrl+"createExam";
  static const String deleteExam=teacherUrl+"deleteExam";
  static const String deleteQuickExam=teacherUrl+"deleteQuickExam";
  static const String updateFcm=teacherUrl+"updateFcm";
  static const String refreshTeacher=teacherUrl+"refresh";
  static const String updatePassword=teacherUrl+"updatePassword";
  static const String missions=teacherUrl+"missions";
  static const String allExams=teacherUrl+"allExams/";
  static const String correctAnswer=teacherUrl+"correctAnswer";
  static const String examAnswers=teacherUrl+"examAnswers/";
  static const String quickexamAnswers=teacherUrl+"quickexamAnswers/";

  //************************************************************************************************




  // Api Methods
 static  headers({String token}){
      return {
         'Content-Type': 'application/json',
         'Accept': 'application/json',
         'Authorization': 'Bearer ${token??first_key}',
      };
   }





}