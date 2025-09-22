import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:image_picker/image_picker.dart';

class UpdateJournal extends StatefulWidget {
  final String initTitle;
  final dynamic initContent;

  UpdateJournal({super.key, required this.initTitle, required this.initContent});

  @override
  State<UpdateJournal> createState() => _UpdateJournalState();
}

class _UpdateJournalState extends State<UpdateJournal> {
  late final TextEditingController titleController;
  late final quill.QuillController _quillController;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.initTitle);

    quill.Document doc;
    try {
      doc = quill.Document.fromJson(widget.initContent ?? [{'insert': '\n'}]);
    } catch (_) {
      doc = quill.Document();
    }

    _quillController = quill.QuillController(
      document: doc,
      selection: TextSelection.collapsed(offset: 0),
    );
  }

  Future<void> _insertImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final index = _quillController.document.length;
      _quillController.document.insert(index, '\n');
      _quillController.document.insert(index + 1, quill.BlockEmbed.image(pickedFile.path));
      _quillController.updateSelection(
        TextSelection.collapsed(offset: _quillController.document.length),
        quill.ChangeSource.local,
      );
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    _quillController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEBEEF5),
      appBar: AppBar(
        title: Text(
          "Edit Journal",
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600, color: Color(0xFF555555)),
        ),
        backgroundColor: Color(0xFFF3EFEE),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(top: 12, bottom: 5, right: 12),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF666666),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
              ),
              onPressed: () {
                Navigator.pop(context, {
                  "title": titleController.text,
                  "content": _quillController.document.toDelta().toJson(),
                });
              },
              child: Text("Save", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Journal Title", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF555555))),
          SizedBox(height: 8),
          TextField(
            controller: titleController,
            decoration: InputDecoration(
              hintText: "Update your journal title...",
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.white, width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.white, width: 2),
              ),
            ),
          ),
          SizedBox(height: 20),

          Row(
            children: [
              Expanded(child: quill.QuillSimpleToolbar(controller: _quillController)),
              IconButton(
                icon: Icon(Icons.image, color: Colors.black87),
                onPressed: _insertImage,
              ),
            ],
          ),

          SizedBox(height: 10),
          Text("Journal Description", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF555555))),
          SizedBox(height: 8),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: quill.QuillEditor.basic(
                controller: _quillController,
                config: quill.QuillEditorConfig(),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
