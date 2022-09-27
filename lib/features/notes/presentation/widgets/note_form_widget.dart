import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pospank_notes/features/notes/domain/entities/note.dart';
import 'package:pospank_notes/features/notes/presentation/bloc/insert_update_clear/insert_update_clear_bloc.dart';

class NoteFormWidget extends StatefulWidget {
  final bool isUpdate;
  final Note? note;
  const NoteFormWidget({Key? key, required this.isUpdate, this.note})
      : super(key: key);

  @override
  State<NoteFormWidget> createState() => _NoteFormWidgetState();
}

class _NoteFormWidgetState extends State<NoteFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _noteTextController = TextEditingController();

  @override
  void initState() {
    if (widget.isUpdate) {
      _noteTextController.text = widget.note!.text;
    }
    super.initState();
  }

  void validateFormThenInsertOrUpdate() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      final note = Note(
        text: _noteTextController.text,
        id: widget.isUpdate ? widget.note!.id : null,
        placeDateTime: '2021-11-18T09:39:44',
        userId: '2',
      );
      if (widget.isUpdate) {
        BlocProvider.of<InsertUpdateClearNoteBloc>(context)
            .add(UpdateNoteEvent(note: note));
      } else {
        BlocProvider.of<InsertUpdateClearNoteBloc>(context)
            .add(InsertNoteEvent(note: note));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: TextFormField(
              controller: _noteTextController,
              validator: (val) => val!.isEmpty ? "Note Con't be empty" : null,
              maxLines: 7,
              minLines: 3,
              decoration: InputDecoration(
                hintText: 'Type Note...',
                labelText: 'Note',
                floatingLabelStyle: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.bold,
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
          ),
          IconButton(
              onPressed: () {
                validateFormThenInsertOrUpdate();
              },
              icon: const Icon(
                Icons.save_outlined,
                size: 28,
              )),
        ],
      ),
    );
  }
}
