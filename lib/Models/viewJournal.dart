import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:noteapp/Models/updatePage.dart';

class ViewJournal extends StatelessWidget {
  final Map<String, dynamic> journal;
  final int? index;
  final void Function(Map<String, dynamic>)? onUpdate;
  final void Function(int)? onDelete;

  ViewJournal({
    required this.journal,
    this.index,
    this.onUpdate,
    this.onDelete,
    Key? key,
  }) : super(key: key);

  quill.Document _loadDocument(dynamic raw) {
    if (raw == null) return quill.Document()..insert(0, '\n');
    try {
      if (raw is String) return quill.Document.fromJson(jsonDecode(raw));
      return quill.Document.fromJson(raw);
    } catch (_) {
      return quill.Document()..insert(0, raw.toString());
    }

  }

  @override
  Widget build(BuildContext context) {
    final title = journal['title'] ?? '';
    final contentRaw = journal['content'];
    final doc = _loadDocument(contentRaw);

    final controller = quill.QuillController(
      document: doc,
      selection:  TextSelection.collapsed(offset: 0),
    )..readOnly = true;


    return Scaffold(
      backgroundColor: Color(0xFFEBEEF5),
      appBar: AppBar(
        title: Text(
          "Journal",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black87),
        actions: [
          if (onUpdate != null)
            IconButton(
              icon: Icon(Icons.edit_outlined, color: Colors.black87),
              onPressed: () async {
                final updated = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => UpdateJournal(
                      initTitle: title,
                      initContent: contentRaw,
                    ),
                  ),
                );
                if (updated != null && onUpdate != null) {
                  onUpdate!(updated);
                  Navigator.of(context).pop();
                }
              },
            ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Title Section
            Container(
              margin: EdgeInsets.only(bottom: 16),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "TITLE",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),

            // Description Section
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color(0xFFF7F7F7),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "DESCRIPTION",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 6),
                    Expanded(
                      child: quill.QuillEditor(
                        controller: controller,
                        focusNode: FocusNode(),
                        scrollController: ScrollController(),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            // Delete Button
            if (onDelete != null && index != null)
              Center(
                child: TextButton.icon(
                  onPressed: () {
                    onDelete!(index!);
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.delete, color: Colors.red),
                  label: Text(
                    "Delete",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
