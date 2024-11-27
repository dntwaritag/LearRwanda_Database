import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class CourseService {
  final CollectionReference courseCollection =
      FirebaseFirestore.instance.collection('courses');

  // Create a course
  Future<void> addCourse(Map<String, dynamic> courseData) async {
    await courseCollection.add(courseData);
  }

  // Read courses
  Stream<QuerySnapshot> getCourses() {
    return courseCollection.snapshots();
  }

  // Update a course
  // Future<void> updateCourse(
  //     String courseId, Map<String, dynamic> courseData) async {
  //   await courseCollection.doc(courseId).update(courseData);
  // }

  Future<void> updateCourse(String courseId, Map<String, dynamic> courseData) async {
  await courseCollection.doc(courseId).update(courseData);
}


  // Delete a course
  Future<void> deleteCourse(String courseId) async {
    await courseCollection.doc(courseId).delete();
  }
}

final CourseService courseService = CourseService();

class course extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.black),
          onPressed: () {
            showSidebar(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage(
                  'assets/avatar2.png'), // Replace with actual avatar image path
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello,',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                'You.!',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
              SizedBox(height: 7),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search your course...",
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 6),
                  IconButton(
                    icon: Icon(Icons.filter_list, color: Colors.blue),
                    onPressed: () {},
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                'Enrolled Courses',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(children: [
                    Image.asset('assets/learn4.jpg',
                        width: 80), // Replace with actual course image path
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Mobile App Development',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text('5/17 Lessons'),
                          ElevatedButton(
                            onPressed: () {},
                            child: Text('Continue'),
                          ),
                        ],
                      ),
                    )
                  ])),
              SizedBox(height: 16),
              Text(
                'Explore your course',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) =>
                        AddCourseDialog(courseService: courseService),
                  );
                },
                child: Text('Add Course'),
              ),
              SizedBox(height: 10),
              StreamBuilder<QuerySnapshot>(
                stream: courseService.getCourses(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error loading courses'));
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('No courses available'));
                  }

                  final courses = snapshot.data!.docs;

                  return Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: courses.map((doc) {
                      final course = doc.data() as Map<String, dynamic>;

                      return CourseCard(
                       courseId: doc.id,
                        title: course['title'] ??
                            'Untitled Course', // Fallback for title
                        description: course['description'] ??
                            'No description available', // Fallback for description
                        imageUrl: 'assets/imag11.png', // Default image URL
                      );
                    }).toList(),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  // Method to show the sidebar as a modal
  void showSidebar(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Align(
          alignment: Alignment.centerLeft,
          child: Container(
            width: MediaQuery.of(context).size.width *
                0.5, // 50% of the screen width
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                CircleAvatar(
                  radius: 40,

                  backgroundImage: AssetImage(
                      'assets/avatar2.png'), // Replace with actual profile image path
                ),
                SizedBox(height: 16),
                Text(
                  "Marco Sardido",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 30),
                ListTile(
                  leading: Icon(Icons.people),
                  title: Text("About Us"),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/about');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.star),
                  title: Text("My Courses"),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.explore),
                  title: Text("Explore Courses"),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text("My Account"),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/account');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text("Address"),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/address');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text("Settings"),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.report_problem),
                  title: Text("Report Problem"),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.help_outline),
                  title: Text("Help"),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Center(
                    child: Text(
                      "Marco Sardido | 131-4",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// CourseCard widget to display individual courses
class CourseCard extends StatelessWidget {
  final String courseId; // Add courseId to identify the course
  final String title;
  // final String lessons;
  final String description;
  // final int totalLessons;
  final String imageUrl;

  const CourseCard({
    required this.courseId,
    required this.title,
    // required this.lessons,
    required this.description,
    //  required this.totalLessons,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              imageUrl,
              height: 80,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(color: Colors.grey[600]),
                ),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => EditCourseDialog(
                        courseId: courseId,
                        title: title,
                        description: description,
                        imageUrl: imageUrl,
                        courseService: courseService,
                      ),
                    );
                  },
                  child: Text('Edit Course'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AddCourseDialog extends StatefulWidget {
  final CourseService courseService;

  AddCourseDialog({required this.courseService});

  @override
  _AddCourseDialogState createState() => _AddCourseDialogState();
}

class _AddCourseDialogState extends State<AddCourseDialog> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  File? _imageFile;

  // Image picker
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<String> _uploadImage(File imageFile) async {
    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('course_images')
          .child(DateTime.now().toString() + '.jpg');

      await ref.putFile(imageFile);
      final imageUrl = await ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Course'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(labelText: 'Course Title'),
          ),
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(labelText: "Course Description"),
          ),
          SizedBox(height: 10),
          // Button to pick image
          ElevatedButton(
            onPressed: _pickImage,
            child: Text('Pick Image'),
          ),
          SizedBox(height: 10),
          _imageFile == null
              ? Text('No image selected')
              : Image.file(_imageFile!, height: 100),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            String imageUrl = '';
            if (_imageFile != null) {
              imageUrl = await _uploadImage(_imageFile!);
            }

            final courseData = {
              'title': titleController.text,
              'description': descriptionController.text,
              'imageUrl': imageUrl,
            };
            widget.courseService.addCourse(courseData);
            Navigator.pop(context);
          },
          child: Text('Add Course'),
        ),
      ],
    );
  }
}


class EditCourseDialog extends StatefulWidget {
  final String courseId;
  final String title;
  final String description;
  final String imageUrl;
  final CourseService courseService;

  EditCourseDialog({
    required this.courseId,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.courseService,
  });

  @override
  _EditCourseDialogState createState() => _EditCourseDialogState();
}

class _EditCourseDialogState extends State<EditCourseDialog> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  File? _imageFile;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.title;
    descriptionController.text = widget.description;
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<String> _uploadImage(File imageFile) async {
    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('course_images')
          .child(DateTime.now().toString() + '.jpg');

      await ref.putFile(imageFile);
      final imageUrl = await ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Course'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(labelText: 'Course Title'),
          ),
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(labelText: 'Course Description'),
          ),
        
      
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
          
            final courseData = {
              'title': titleController.text,
              'description': descriptionController.text,
              // 'imageUrl': imageUrl,
            };

            await widget.courseService.updateCourse(widget.courseId, courseData);
            Navigator.pop(context);
          },
          child: Text('Update Course'),
        ),
      ],
    );
  }
}
