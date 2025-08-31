import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/pages/notes/notes_controller.dart';

class NotesPage extends GetView<NotesController> {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController textEditingController = TextEditingController();
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              color: Colors.grey.shade800,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: TextField(
                  controller: textEditingController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hint: Text(
                      'Hayallerinizi Yazın...',
                      style: GoogleFonts.abel(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade800,
              ),
              onPressed: () {
                controller.addNote(textEditingController.text);
                textEditingController.clear();
              },
              child: Text('Kaydet', style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 20),
            Divider(),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: controller.notes.length,
                  itemBuilder: (context, index) {
                    final note = controller.notes[index];
                    return Card(
                      color: Colors.grey.shade800,
                      margin: EdgeInsets.symmetric(vertical: 5.0),
                      child: ListTile(
                        title: Text(
                          note.content,
                          style: TextStyle(color: Colors.white),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                controller.pinNote(note.id);
                              },
                              icon: Icon(Icons.push_pin, color: Colors.white60),
                            ),
                            IconButton(
                              onPressed: () {
                                controller.removeNote(note.id);
                              },
                              icon: Icon(
                                Icons.delete_outline,
                                color: Colors.redAccent,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
