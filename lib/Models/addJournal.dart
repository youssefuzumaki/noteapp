import 'package:flutter/material.dart';

class journalPage extends StatefulWidget {

  @override
  State<journalPage> createState() => _journalPageState();
}

class _journalPageState extends State<journalPage> {

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Journal",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Color(0xFF666666)),),
        backgroundColor: Color(0xFFF3EFEE),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context, {
                  "title": titleController.text,
                  "content": descController.text,
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF666666),
              ),
              child: const Text(
                "Save",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 15.0, vertical: 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(
              "Journal Title",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
             SizedBox(height: 8),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: "Write your journal title...",
                hintStyle: TextStyle(color: Color(0xFF999999)),

                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide:  BorderSide(
                    color: Color(0xFF888888),
                    width: 1.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide:  BorderSide(
                    color: Color(0xFF777777),
                    width: 2.0,
                  ),
                ),
                contentPadding:  EdgeInsets.all(12),
              ),
            ),
             SizedBox(height: 20),
             Text(
              "Journal Description",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
             SizedBox(height: 8),
            TextField(
              controller: descController,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                hintText: "start by writing what’s on your mind, \n "
                    "describe how you feel, and note any events \n "
                    "or thoughts you want to remember...",
                hintStyle: TextStyle(color: Color(0xFF999999)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:  BorderSide(
                    color: Color(0xFF888888),
                    width: 1.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide:  BorderSide(
                    color: Color(0xFF777777),
                    width: 2.0,
                  ),
                ),
                contentPadding:  EdgeInsets.all(12),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

