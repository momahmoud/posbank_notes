import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pospank_notes/features/notes/presentation/bloc/notes/notes_bloc.dart';
import 'package:pospank_notes/features/notes/presentation/widgets/note_list_widget.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/app_widgets/loading_widget.dart';
import '../../../../core/app_widgets/message_display_widget.dart';
import '../../domain/entities/note.dart';
import '../bloc/insert_update_clear/insert_update_clear_bloc.dart';
import 'note_add_update_page.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: BlocBuilder<NotesBloc, NotesState>(
        builder: (context, state) {
          if (state is LoadingNotesState) {
            return const LoadingWidget();
          } else if (state is LoadedNotesState) {
            return RefreshIndicator(
              onRefresh: () {
                return _onRefresh(context);
              },
              child: state.notes.isEmpty
                  ? _buildRefreshButton(context, 'No Notes Yet')
                  : Column(
                      children: [
                        _buildTopSectionBody(),
                        const SizedBox(
                          height: 10,
                        ),
                        Expanded(child: NoteListWidget(note: state.notes)),
                      ],
                    ),
            );
          } else if (state is ErrorNotesState) {
            return Column(
              children: [
                _buildRefreshButton(context, 'Refresh'),
                MessageDisplayWidget(message: state.message),
              ],
            );
          }
          return const LoadingWidget();
        },
      ),
    );
  }

  Future<void> _onRefresh(
    BuildContext context,
  ) async {
    BlocProvider.of<NotesBloc>(context).add(RefreshNotesEvent());
  }

// #6200ED
  Widget _buildFloatingActionButton(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 60,
      child: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NoteAddUpdatePage(
                isUpdate: false,
              ),
            ),
          );
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            const Icon(
              Icons.add,
            ),
            Positioned(
              bottom: -7,
              right: -8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    color: secondaryColor.withOpacity(.1),
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: false,
      title: const Text(
        'Notes',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.person_add,
              size: 28,
            )),
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.settings,
              size: 28,
            )),
        IconButton(
            onPressed: () {
              BlocProvider.of<InsertUpdateClearNoteBloc>(context)
                  .add(ClearNoteEvent());
              BlocProvider.of<NotesBloc>(context).add(RefreshNotesEvent());
            },
            icon: const Icon(
              Icons.clear_all,
              size: 28,
            )),
      ],
    );
  }

  Widget _buildRefreshButton(BuildContext context, String text) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text(text)),
          IconButton(
              onPressed: () {
                _onRefresh(context);
              },
              icon: const Icon(
                Icons.refresh,
                size: 25,
              )),
        ],
      ),
    );
  }

  Widget _buildTopSectionBody() {
    return Row(
      children: <Widget>[
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.filter_list,
              size: 25,
            )),
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              size: 25,
            )),
      ],
    );
  }
}
