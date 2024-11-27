# **LearnRwanda Mobile Application**  

## **Overview**  
LearnRwanda is a cutting-edge mobile application designed to transform Rwanda’s education landscape. The app provides a comprehensive, equitable learning platform for students, teachers, parents, and government stakeholders. With offline learning resources, personalized learning paths, and dashboards for performance tracking, LearnRwanda empowers users to achieve educational excellence.  

---

## **Features**  
### **For Students:**  
- **Offline Learning Resources:** Access downloadable textbooks, video lessons, and quizzes aligned with Rwanda’s national curriculum.  
- **Interactive Learning Modules:** Gamified lessons and quizzes for engaging and effective learning.  
- **Personalized Learning Paths:** Tailored recommendations based on performance and progress.  

### **For Teachers and Parents:**  
- **Dashboards:** Monitor student performance, provide feedback, and assign supplemental materials.  
- **Analytics Tools:** Identify learning gaps and track attendance or homework completion.  

### **For Administrators and Policymakers:**  
- **Nationwide Monitoring:** Real-time insights into student performance and curriculum implementation.  
- **Integration with National Goals:** Supports the Education Sector Strategic Plan (ESSP) and UN Sustainable Goal 4.  

---

## **Technology Stack**  
- **Frontend:** Flutter (for cross-platform development on Android and iOS).  
- **Backend:** Firebase (Firestore, Authentication, Cloud Storage).  
- **Database:** Firestore (NoSQL).  

---

## **Setup Instructions**  
### **Prerequisites:**  
- Flutter installed ([Installation Guide](https://flutter.dev/docs/get-started/install)).  
- Firebase account with an active project ([Firebase Console](https://console.firebase.google.com)).  

### **Steps to Set Up the Project:**  
1. **Clone the Repository:**  
   ```bash
   git clone https://github.com/yourusername/learnrwanda.git
   cd learnrwanda
   ```

2. **Install Dependencies:**  
   ```bash
   flutter pub get
   ```

3. **Firebase Configuration:**  
   - Download `google-services.json` (for Android) and `GoogleService-Info.plist` (for iOS) from your Firebase project.  
   - Place them in the appropriate directories (`android/app` and `ios/Runner`).  

4. **Run the Application:**  
   ```bash
   flutter run
   ```

---

## **Database Structure**  
### **Firestore Collections:**  
1. **users**  
   Stores user profiles and roles.  
   ```json
   {
     "uid": "unique-user-id",
     "name": "John Doe",
     "email": "john.doe@example.com",
     "role": "student",
     "profilePicture": "URL-to-profile-picture"
   }
   ```

2. **lessons**  
   Holds details about learning modules.  
   ```json
   {
     "lessonId": "unique-lesson-id",
     "title": "Introduction to Algebra",
     "description": "Learn basic algebra concepts.",
     "language": "English",
     "mediaURL": "URL-to-video-or-resource"
   }
   ```

3. **progress**  
   Tracks student progress.  
   ```json
   {
     "progressId": "unique-progress-id",
     "userId": "user-id",
     "lessonId": "lesson-id",
     "completionStatus": true,
     "score": 85
   }
   ```

---

## **Security Rules**  
1. **User Data:**  
   - Only authenticated users can access their own data.  
   ```json
   ![User-access](https://github.com/user-attachments/assets/68efb3f7-1126-4994-96cb-93a6b8b3760b)

   ```

2. **Lessons Data:**  
   - Readable by all authenticated users.  
   - Writable by admin users only.  
   ```json
   ![Lesson_Access](https://github.com/user-attachments/assets/0fe4866b-9022-43ac-9465-98f2ddaa7428)

   ```

3. **Progress Data:**  
   - Users can only access their own progress.  
   ```json
   ![image](https://github.com/user-attachments/assets/ffada77b-b7f2-4cd1-9fb8-8dbf63208ef3)

   ```

---

## **Key Features Implementation**  
- **Authentication:**  
  - Secure Email/Password and Google Sign-In using Firebase Authentication.  
- **Offline Support:**  
  - Downloadable resources for areas with limited internet connectivity.  
- **Real-time Data Sync:**  
  - Firestore for instant updates across devices.  
- **Interactive Modules:**  
  - Quizzes and gamified assessments for improved learning outcomes.  

---

## **Testing and Quality Assurance**  
- **Beta Testing:** Conducted with students and teachers to refine usability.  
- **Device Compatibility:** Tested on a range of Android and iOS devices.  
- **Performance Optimization:** Offline caching and indexed queries for faster data retrieval.  

---

## **Future Enhancements**  
1. Expand content to cover professional development for teachers.  
2. Integrate AI-based adaptive learning recommendations.  
3. Launch in other East African markets with localized curricula.  
4. Add push notifications for lesson reminders and updates.  

---

## **Contributing**  
We welcome contributions to enhance LearnRwanda!  
### **How to Contribute:**  
1. Fork the repository.  
2. Create a new branch:  
   ```bash
   git checkout -b feature-name
   ```
3. Commit your changes:  
   ```bash
   git commit -m "Add your message"
   ```
4. Push to the branch:  
   ```bash
   git push origin feature-name
   ```
5. Submit a pull request.  

---

## **Contact**  
- **Email:** (d.ntwaritag@alustudent.com)  
- **GitHub Repository:** (https://github.com/dntwaritag/LearRwanda_Database.git)   

Thank you for exploring **LearnRwanda**! Together, let's empower education in Rwanda.  
