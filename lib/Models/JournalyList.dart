import 'package:flutter/material.dart';
import 'package:noteapp/Models/addJournal.dart';
import 'package:noteapp/Models/viewJournal.dart';


class JournalList extends StatefulWidget {
  @override
  State<JournalList> createState() => _JournalListState();
}

class _JournalListState extends State<JournalList> {
  final List<Map<String, dynamic>> journals = [];

  final List<Color> cardColors = [
    Color(0xFFEC729C), // Soft Bright Pink
    Color(0xFF81C784), // Soft Bright Green
    Color(0xFF64B5F6), // Soft Bright Blue
    Color(0xFFFFD54F), // Soft Bright Yellow
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEBEEF5),
      appBar: AppBar(
        title: Text(
          "My Journals",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF666666),
            fontSize: 30,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFFF3EFEE),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.85,
          ),
          itemCount: journals.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              // "New Journal" card
              return GestureDetector(
                onTap: () async {
                  final newJournal = await Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => JournalPage()),
                  );
                  if (newJournal != null) {
                    setState(() {
                      journals.add({
                        "title": newJournal["title"],
                        "content": newJournal["content"], // raw Delta JSON
                        "image": newJournal["image"], // ✅ save image path
                      });
                    });
                  }
                },
                child: Card(
                  color: Colors.blue[50],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add, size: 40, color: Colors.blue),
                        SizedBox(height: 8),
                        Text(
                          "New Journal",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            } else {
              final journal = journals[index - 1];

              return InkWell(
                onTap: () async {
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ViewJournal(
                        journal: journal,
                        index: index - 1,
                        onUpdate: (updatedData) {
                          setState(() {
                            journals[index - 1] = updatedData;
                          });
                        },
                        onDelete: (delIndex) {
                          setState(() {
                            journals.removeAt(delIndex);
                          });
                        },
                      ),
                    ),
                  );
                },
                child: Card(
                  color: cardColors[(index - 1) % cardColors.length],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 5,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          journal["title"] ?? "",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Color(0xFF333333),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Tap to view details...",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
