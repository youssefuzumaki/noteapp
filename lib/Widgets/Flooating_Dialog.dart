import 'package:flutter/material.dart';
import 'package:noteapp/consts/Const_Color.dart';

class FlooatingDialog extends StatefulWidget {
  /// إذا تم تمرير title/content يعني فتح ملاحظة موجودة للعرض/تعديل
  final String? initialTitle;
  final String? initialContent;

  const FlooatingDialog({super.key, this.initialTitle, this.initialContent});

  @override
  State<FlooatingDialog> createState() => _FlooatingDialogState();
}

class _FlooatingDialogState extends State<FlooatingDialog> {
  late final TextEditingController _titleCtrl;
  late final TextEditingController _contentCtrl;
  final _formKey = GlobalKey<FormState>();

  /// إذا true => نعرض حقول قابلة للتحرير، وإلا نعرض النص فقط مع زر Edit
  late bool _isEditing;

  @override
  void initState() {
    super.initState();
    _titleCtrl = TextEditingController(text: widget.initialTitle ?? '');
    _contentCtrl = TextEditingController(text: widget.initialContent ?? '');
    // لو ما تمش تمرير بيانات => إنشاء جديد => نبدأ في وضع التحرير
    _isEditing = (widget.initialTitle == null && widget.initialContent == null);
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _contentCtrl.dispose();
    super.dispose();
  }

  void _onSave() {
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.of(context).pop({
        "title": _titleCtrl.text.trim(),
        "content": _contentCtrl.text.trim(),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 360, maxHeight: 400),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.98),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 12, offset: const Offset(0, 6)),
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.initialTitle == null
                          ? "New Note"
                          : (_isEditing ? "Edit Note" : "Note"),
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Title: editable or read-only
                  _isEditing
                      ? TextFormField(
                          controller: _titleCtrl,
                          maxLines: 1,
                          maxLength: 50,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                            border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                            labelText: "   Title",
                            labelStyle: TextStyle(fontSize: 12, color: Colors.grey[700]),
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
                          validator: (v) => (v == null || v.trim().isEmpty) ? 'Please enter title' : null,
                        )
                      : Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            _titleCtrl.text.isEmpty ? "(No title)" : _titleCtrl.text,
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),

                  const SizedBox(height: 12),

                  // Content area
                  // IMPORTANT: removed 'expands: true' to avoid assertion:
                  // when expands == true, minLines and maxLines must be null.
                  // Instead we keep minLines and let the surrounding Expanded control height.
                  Expanded(
                    child: _isEditing
                        ? TextFormField(
                            controller: _contentCtrl,
                            minLines: 4,
                            maxLines: 5, // allow growing
                            // expands removed intentionally
                            maxLength: 300,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                              border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(14))),
                              labelText: "   You can write content here...",
                              labelStyle: TextStyle(fontSize: 12, color: Colors.grey[700]),
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: const BorderSide(color: Colors.grey, width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: BorderSide(color: BlueLight, width: 1),
                              ),
                            ),
                            validator: (v) => (v == null || v.trim().isEmpty) ? 'Please enter content' : null,
                          )
                        : SingleChildScrollView(
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade50,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.grey.shade200),
                              ),
                              child: Text(
                                _contentCtrl.text.isEmpty ? "(No content)" : _contentCtrl.text,
                                style: const TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                  ),

                  const SizedBox(height: 12),

                  // Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: _isEditing
                        ? [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(null),
                              child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
                            ),
                            const SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: _onSave,
                              style: ElevatedButton.styleFrom(backgroundColor: BlueLight),
                              child: const Text("Save", style: TextStyle(color: Colors.black)),
                            ),
                          ]
                        : [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text("Close"),
                            ),
                            const SizedBox(width: 8),
                            OutlinedButton(
                              onPressed: () => setState(() => _isEditing = true),
                              child: const Text("Edit"),
                            ),
                          ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Returns Map<String,String> or null if cancelled.
/// Optional parameters let you open the dialog pre-filled for viewing/editing.
Future<Map<String, String>?> showFloatingDialog(BuildContext context, {String? title, String? content}) {
  return showGeneralDialog<Map<String, String>?>(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Dismiss',
    barrierColor: Colors.black26,
    transitionDuration: const Duration(milliseconds: 180),
    pageBuilder: (ctx, anim1, anim2) {
      return Material(
        color: Colors.transparent,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            if (Navigator.of(ctx).canPop()) Navigator.of(ctx).pop();
          },
          child: Center(
            child: GestureDetector(onTap: () {}, child: FlooatingDialog(initialTitle: title, initialContent: content)),
          ),
        ),
      );
    },
    transitionBuilder: (context, anim, secondaryAnim, child) {
      return FadeTransition(opacity: anim, child: child);
    },
  );
}
