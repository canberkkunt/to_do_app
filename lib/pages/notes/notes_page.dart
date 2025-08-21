import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:to_do_app/pages/notes/notes_controller.dart';

class NotesPage extends GetView<NotesController> {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController textEditingController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  controller: textEditingController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: 'Hayallerinizi yazın!',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                controller.addNote(textEditingController.text);
                textEditingController.clear();
              },
              child: Text('Kaydet'),
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
                      margin: EdgeInsets.symmetric(vertical: 5.0),
                      child: ListTile(
                        title: Text(note.content),

                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                controller.pinNote(note.id);
                              },
                              icon: Icon(Icons.push_pin, color: Colors.grey),
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
