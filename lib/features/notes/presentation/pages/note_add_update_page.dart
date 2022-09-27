import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pospank_notes/core/app_widgets/loading_widget.dart';
import 'package:pospank_notes/core/utils/snackbar_message.dart';
import 'package:pospank_notes/features/notes/domain/entities/note.dart';
import 'package:pospank_notes/features/notes/presentation/bloc/insert_update_clear/insert_update_clear_bloc.dart';

import 'package:pospank_notes/features/notes/presentation/pages/notes_page.dart';
import 'package:pospank_notes/features/notes/presentation/widgets/note_form_widget.dart';
import 'package:pospank_notes/features/users/presentation/view/assign_user_field.dart';

import '../bloc/notes/notes_bloc.dart';

class NoteAddUpdatePage extends StatelessWidget {
  final Note? note;
  final bool isUpdate;
  const NoteAddUpdatePage({Key? key, this.note, required this.isUpdate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: false,
      title: Text(
        isUpdate ? 'Edit Note' : 'Add Note',
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.save_outlined,
              size: 28,
            )),
      ],
    );
  }

  Widget _buildBody() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child:
            BlocConsumer<InsertUpdateClearNoteBloc, InsertUpdateClearNoteState>(
                builder: (context, state) {
          if (state is LoadingAddDeleteUpdateNoteState) {
            return const LoadingWidget();
          }
          return Column(
            children: [
              NoteFormWidget(isUpdate: isUpdate, note: isUpdate ? note : null),
            ],
          );
        }, listener: (context, state) {
          if (state is SuccessMessageAddDeleteUpdateNoteState) {
            SnackBarMessage.showSnackBar(context, state.message);
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const NotesPage()),
                (route) => false);
          } else if (state is ErrorAddDeleteUpdateNoteState) {
            SnackBarMessage.showSnackBar(context, state.message);
          }

          BlocProvider.of<NotesBloc>(context).add(RefreshNotesEvent());
        }),
      ),
    );
  }
}
