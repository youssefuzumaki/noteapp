import 'package:flutter/material.dart';

import 'SignupPage.dart';
class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  
  final emailcontroller=TextEditingController();
  final passwordcontroller=TextEditingController();
  bool  _obscurePassword=true;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Login to The Note",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
                padding:const EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("The Note",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontSize: 30,color: Colors.black
                  ),

                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20,),
                  Text("Login to The Note",
                  style: TextStyle(fontSize: 20,color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Email",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight:FontWeight.bold ,
                        color: Colors.black87
                      ),
                      )
                    ],

                  ),
                  const SizedBox(height: 8,),
                  TextField(
                    controller: emailcontroller,
                    decoration: InputDecoration(
                      hintText: 'Enter your Email',
                      hintStyle: TextStyle(color: Colors.black),
                      filled: true,
                      fillColor: Colors.white10,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      )
                    ),
                    style: TextStyle(color: Colors.black),
                  ),
              SizedBox(height: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Password",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight:FontWeight.bold ,
                        color: Colors.black87
                    ),
                  )
                ],
              ),
                const SizedBox(height: 8,),

                TextField(
                controller: passwordcontroller,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  hintText: ' Enter your Password',
                  hintStyle: TextStyle(color: Colors.black),
                  filled: true,
                  fillColor: Colors.white10,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                style: TextStyle(color: Colors.black),
              ),

                  SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () {
                      print('Email: ${emailcontroller.text}');
                      print('Password: ${passwordcontroller.text}');
                    },
                    child: Text('Login',
                      style: TextStyle(color: Colors.white,fontSize: 22.5),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                      foregroundColor: Colors.black,

                      padding: EdgeInsets.symmetric(vertical: 7.5),
                    ),
                  ),

                  const SizedBox(height: 40,),
                  OutlinedButton.icon(
                    icon: const Icon(Icons.g_mobiledata_outlined),
                    onPressed: (){},
                      label : const Text("Log in with Google",),
                  ),
                  const SizedBox(height: 8,),
                  OutlinedButton.icon(
                    icon: const Icon(Icons.apple_outlined),
                      onPressed: (){},
                      label: const Text("Log in with Apple"),
                  ),
                  const SizedBox(height: 25,),
                  TextButton(
                      onPressed: (){
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context)=>const Signuppage()),
                        );

                      },
                    child: const Text("don't have an account ? Create an account",
                    style: TextStyle(color: Colors.red),
                    ),
                  ),


                ],
                
              ),
                ),
            
          )
      ),
      
      
    );
  }
}
