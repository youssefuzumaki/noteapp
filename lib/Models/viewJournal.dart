import 'package:flutter/material.dart';
import 'JournalyList.dart';

class viewJournal extends StatefulWidget {

  late final String title;
  late final String description;

  viewJournal({required this.title,required this.description});


  @override
  State<viewJournal> createState() => _viewJournalState();
}


class _viewJournalState extends State<viewJournal> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Journal",
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Color(0xFF666666)),
        ),
        backgroundColor: const Color(0xFFF3EFEE),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Title",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              widget.title,
              style: const TextStyle(fontSize: 24, color: Color(0xFF333333)),
            ),
            const SizedBox(height: 20),
            const Text(
              "Description",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  widget.description,
                  style: const TextStyle(fontSize: 20, color: Color(0xFF777777)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


