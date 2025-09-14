import 'package:flutter/material.dart';
import 'package:noteapp/Models/addJournal.dart';
import 'package:noteapp/Models/viewJournal.dart';


class journalList extends StatefulWidget {
  const journalList({super.key});

  @override
  State<journalList> createState() => _journalListState();
}

class _journalListState extends State<journalList> {
  final List<Map<String, String>> journals = [];
  final List<Color> cardColors = [
    const Color(0xFFE8DEE6), // PinkLight
    const Color(0xFFDAE2D8), // GreenLight
    const Color(0xFFE0E3EB), // BlueLight
    const Color(0xFFF1E7D4), // YellowLight
  ];

  int colorIndex = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Journals",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF666666),
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFFF3EFEE),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.85,
          ),
          itemCount: journals.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return GestureDetector(
                onTap: () async {
                  final newJournal = await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (c) {
                        return journalPage();
                      },
                    ),
                  );
                  setState(() {
                    journals.add({
                      "title": newJournal["title"],
                      "content": newJournal["content"],
                    });
                  });
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
                onTap: (){
                      Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (c) {
                          return viewJournal(
                            title: journal["title"]!,
                            description: journal["content"]!,
                          );
                        },
                      ),
                    );
                    },
                child: Card(
                  color: cardColors[(index - 1) % cardColors.length],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 1,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          journal["title"]!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Color(0xFF333333),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 8),
                        Text(
                          journal["content"]!,
                          style: TextStyle(
                            fontSize: 20,
                            color: Color(0xFF777777),
                          ),
                          maxLines: 4,
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
