import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateJob extends StatefulWidget {
  const CreateJob({super.key});

  @override
  State<CreateJob> createState() => _CreateJobState();
}

class _CreateJobState extends State<CreateJob> {

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();
  final TextEditingController _skillsController = TextEditingController();

  void saveJobDetails() {
    String title = _titleController.text.trim();
    String company = _companyController.text.trim();
    String location = _locationController.text.trim();
    String duration = _durationController.text.trim();
    String type = _typeController.text.trim();
    String salary = _salaryController.text.trim();
    String about = _aboutController.text.trim();
    String skills = _skillsController.text.trim();

    if (title.isNotEmpty &&
        company.isNotEmpty &&
        location.isNotEmpty &&
        duration.isNotEmpty &&
        type.isNotEmpty &&
        salary.isNotEmpty &&
        about.isNotEmpty &&
        skills.isNotEmpty) {
      FirebaseFirestore.instance.collection('jobs').add({
        'title': title,
        'company': company,
        'location': location,
        'duration': duration,
        'type': type,
        'salary': salary,
        'about': about,
        'skills': skills,
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Job details saved successfully')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('All fields are required')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                alignment: Alignment(0.0, -0.40),
                color: Colors.white,
                height: 100.0,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: const Text(
                    "Create a new job post",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(25.0, 90.0, 25.0, 0.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 1.0,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.fromLTRB(20.0, 25.0, 5.0, 5.0),
                          child: const Text(
                            "YOU HAVE",
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                              fontFamily: 'Quicksand',
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(30.0, 40.0, 5.0, 15.0),
                          child: const Text(
                            "16",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 40.0,
                              fontFamily: 'Quicksand',
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 50.0,
                      width: 125.0,
                      decoration: BoxDecoration(
                        color: Colors.greenAccent[100]?.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: InkWell(
                          onTap: () {},
                          child: const Text(
                            "Job Posts",
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                              fontFamily: 'Quicksand',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 30.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(_titleController, 'Title', Icons.title),
              _buildTextField(_companyController, 'Company Name', Icons.business),
              _buildTextField(_locationController, 'Location', Icons.location_on),
              _buildTextField(_durationController, 'Duration', Icons.calendar_today),
              _buildTextField(_typeController, 'Type', Icons.work),
              _buildTextField(_salaryController, 'Salary', Icons.attach_money),
              _buildTextField(_aboutController, 'About', Icons.info),
              _buildTextField(_skillsController, 'Skills', Icons.list),
              SizedBox(height: 20.0),
              Center(
                child: ElevatedButton(
                  onPressed: saveJobDetails,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60.0),
                    child: Text('Create',style: TextStyle(fontFamily: "Quicksand", fontWeight: FontWeight.bold),),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 40.0),
        ],
      ),
    );
  }
}

Widget _buildTextField(TextEditingController controller, String labelText, IconData prefixIcon) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
    child: TextField(
      controller: controller,
      style: TextStyle(fontFamily: 'Quicksand'),
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(prefixIcon),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey), // Normal border color
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black), // Focused border color
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    ),
  );
}



