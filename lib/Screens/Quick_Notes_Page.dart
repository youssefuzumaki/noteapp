import 'package:flutter/material.dart';
import 'package:noteapp/Widgets/Flooating_Dialog.dart';
import 'package:noteapp/consts/Const_Color.dart';

class QuickNotesPage extends StatefulWidget {
  const QuickNotesPage({super.key});

  @override
  State<QuickNotesPage> createState() => _QuickNotesPageState();
}

class _QuickNotesPageState extends State<QuickNotesPage> {
  final List<Map<String, String>> _notes = [];

  // card background colors
  final List<Color> cardColors = [
    const Color(0xFFE8DEE6), // PinkLight
    const Color(0xFFDAE2D8), // GreenLight
    const Color(0xFFE0E3EB), // BlueLight
    const Color(0xFFF1E7D4), // YellowLight
    const Color(0xFFF3E9FF),
  ];

  // vertical stripe colors (separate list)
  final List<Color> stripeColors = [
    Colors.purple, // matches example
    Colors.green,
    Colors.blue,
    Colors.yellow,
  ];

  // separate counters to assign colors in round-robin; stored per-note to keep stable
  int _nextCardColorIndex = 0;
  int _nextStripeColorIndex = 0;

  final TextEditingController _searchCtrl = TextEditingController();

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  // فتح dialog لإنشاء ملاحظة جديدة
  Future<void> _openAddDialog() async {
    final result = await showFloatingDialog(context);
    if (result != null && result["title"] != null && result["content"] != null) {
      final assignedCardIndex = _nextCardColorIndex % cardColors.length;
      _nextCardColorIndex = (_nextCardColorIndex + 1) % cardColors.length;

      final assignedStripeIndex = _nextStripeColorIndex % stripeColors.length;
      _nextStripeColorIndex = (_nextStripeColorIndex + 1) % stripeColors.length;

      setState(() {
        _notes.add({
          "title": result["title"]!,
          "content": result["content"]!,
          "_colorIndex": assignedCardIndex.toString(),
          "_lineColorIndex": assignedStripeIndex.toString(),
        });
      });
    }
  }

  // فتح dialog لعرض/تعديل ملاحظة موجودة
  Future<void> _openViewEditDialog(int originalIndex) async {
    final note = _notes[originalIndex];
    final result = await showFloatingDialog(context, title: note["title"], content: note["content"]);

    if (result != null && result["title"] != null && result["content"] != null) {
      setState(() {
        _notes[originalIndex]["title"] = result["title"]!;
        _notes[originalIndex]["content"] = result["content"]!;
        // لون الملاحظة يحتفظ به كما هو (indices مخزّنة مسبقًا)
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final query = _searchCtrl.text.trim().toLowerCase();
    final filtered = query.isEmpty
        ? _notes
        : _notes.where((n) {
            final title = (n["title"] ?? "").toLowerCase();
            final content = (n["content"] ?? "").toLowerCase();
            return title.contains(query) || content.contains(query);
          }).toList();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 15.0, right: 15.0),
          child: Material(
            elevation: 5,
            shape: const CircleBorder(
              side: BorderSide(width: 0, style: BorderStyle.solid, color: Colors.transparent),
            ),
            clipBehavior: Clip.antiAlias,
            child: FloatingActionButton(
              onPressed: _openAddDialog,
              backgroundColor: BlueLight,
              child: Icon(Icons.add, color: textColor),
            ),
          ),
        ),
        backgroundColor: backgroundColor,
        appBar: AppBar(
          title: const Text("Quick Notes"),
          backgroundColor: BlueLight,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              TextField(
                controller: _searchCtrl,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                  labelText: "Search your notes",
                  prefixIcon: const Icon(Icons.search),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.grey, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: BlueLight, width: 1),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: filtered.isEmpty
                    ? Center(
                        child: Text(
                          _notes.isEmpty ? "No notes yet — اضغط + لإضافة" : "No results",
                          style: const TextStyle(color: Colors.grey),
                        ),
                      )
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: filtered.length,
                        itemBuilder: (context, index) {
                          final note = filtered[index];

                          // parse stored indices (fallback to 0)
                          final colorIndex = int.tryParse(note["_colorIndex"] ?? "") ?? 0;
                          final stripeIndex = int.tryParse(note["_lineColorIndex"] ?? "") ?? 0;

                          final cardColor = cardColors[colorIndex % cardColors.length];
                          final stripeColor = stripeColors[stripeIndex % stripeColors.length];

                          // originalIndex في _notes (مهم عشان نعدّل العنصر الصحيح حتى لو في حالة فلترة)
                          final originalIndex = _notes.indexOf(note);

                          return Card(
                            elevation: 3,
                            color: cardColor,
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17.5)),
                            clipBehavior: Clip.antiAlias,
                            child: IntrinsicHeight(
                              child: Row(
                                children: [
                                  // vertical stripe: حجم واضح وشكل capsule
                                  Container(
                                    width: 15,
                                    decoration: BoxDecoration(
                                      color: stripeColor,
                                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(14), bottomLeft: Radius.circular(14)),
                                    ),
                                  ),

                                  // content
                                  Expanded(
                                    child: ListTile(
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                      title: Text(
                                        note["title"] ?? "",
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                      ),
                                      subtitle: Padding(
                                        padding: const EdgeInsets.only(top: 6.0),
                                        child: Text(
                                          note["content"] ?? "",
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      onTap: () async {
                                        // افتح الديالوج للعرض، ومنه تقدر تضغط Edit لتتحول لتحرير
                                        await _openViewEditDialog(originalIndex);
                                      },
                                      trailing: IconButton(
                                        icon: const Icon(Icons.delete_outline),
                                        onPressed: () {
                                          setState(() {
                                            _notes.removeAt(originalIndex);
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
