import 'package:flutter/material.dart';
import 'package:pospank_notes/features/notes/domain/entities/note.dart';
import 'package:pospank_notes/features/notes/presentation/pages/note_add_update_page.dart';

class NoteListWidget extends StatelessWidget {
  final List<Note> note;
  const NoteListWidget({Key? key, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: note.length,
      itemBuilder: (context, index) {
        return ListTile(
          trailing: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.edit,
                size: 25,
              )),
          title: Text(
            note[index].text,
            maxLines: 2,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NoteAddUpdatePage(
                  note: note[index],
                  isUpdate: true,
                ),
              ),
            );
          },
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(
          thickness: 1.3,
        );
      },
    );
  }
}
