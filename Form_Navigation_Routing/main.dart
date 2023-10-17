import 'package:flutter/material.dart';
import 'package:form1/SuccessPage.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 108, 39, 226),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyHomeState();
  }
}

class MyHomeState extends State<MyHomePage> {
  TextEditingController dateInput = TextEditingController();

  @override
  void initState() {
    dateInput.text = "";
    super.initState();
  }

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController ucontroller = TextEditingController();
  TextEditingController pcontroller = TextEditingController();
  TextEditingController econtroller = TextEditingController();
  String _selectedGender = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home Page")),
      backgroundColor: const Color.fromARGB(255, 246, 244, 244),
      body: Padding(
        padding:const EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 20)        ,
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: 500,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 248, 247, 247).withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
              child: Form(
                
                key: formkey,
                child: Padding(
                   padding:const EdgeInsets.only(top: 10, right: 10, left: 10, bottom: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      const Center(
                        child: Text(
                          "Create an Account",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
          
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: ucontroller,
                        decoration: const InputDecoration(
                          labelText: "Username",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your Name!";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: econtroller,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field is required!';
                          }
            
                          if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                            return "Please enter a valid email address!";
                          }
            
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: pcontroller,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: "Password",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field is required!';
                          }
                          return null;
                        },
                      ),
                        const SizedBox(height: 10),
                       DropdownButtonFormField<String>(
                        items: const [
                          DropdownMenuItem(value: "male", child: Text("Male")),
                          DropdownMenuItem(value: "female", child: Text("Female")),
                          DropdownMenuItem(value: "neutral", child: Text("Neutral")),
                          DropdownMenuItem(value: "other", child: Text("Other")),
                        ],
                        onChanged: (String? value) {
                          setState(() {
                            _selectedGender = value!;
              
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            _selectedGender = "Not Selected";

                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Gender',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: dateInput,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.calendar_today),
                          labelText: "Date Of Birth",
                          border: OutlineInputBorder(),
                        ),
                        
                        readOnly: true,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime(2000),
                            firstDate: DateTime(1950),
                            lastDate: DateTime(2100),
                          );
            
                          if (pickedDate != null) {
                            String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                            setState(() {
                              dateInput.text = formattedDate;
                            });
                          }
                        },
                         
                      ),
            
                      const SizedBox(height: 20),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            if (formkey.currentState!.validate()) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SuccessPage(
                                    username: ucontroller.text,
                                    password: pcontroller.text,
                                    email: econtroller.text,
                                    dob: dateInput.text,
                                    gender: _selectedGender,
                                  ),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.deepPurple,
                            onPrimary: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text("Create Account"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
