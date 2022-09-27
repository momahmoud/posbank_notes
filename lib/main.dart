import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pospank_notes/core/app_theme.dart';
import 'package:pospank_notes/dependency_injection_container.dart' as di;

import 'package:pospank_notes/features/notes/presentation/bloc/insert_update_clear/insert_update_clear_bloc.dart';
import 'package:pospank_notes/features/notes/presentation/pages/notes_page.dart';

import 'features/notes/presentation/bloc/notes/notes_bloc.dart';
import 'features/users/presentation/bloc/user/user_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => di.sl<NotesBloc>()..add(GetAllNotesEvent())),
        BlocProvider(
          create: (_) => di.sl<InsertUpdateClearNoteBloc>(),
        ),
        BlocProvider(
          create: (_) => di.sl<UserBloc>()..add(GetAllUserEvent()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'POSBANK_NOTES',
        theme: appTheme,
        home: const NotesPage(),
      ),
    );
  }
}
