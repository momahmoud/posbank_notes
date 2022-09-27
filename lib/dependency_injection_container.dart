import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:pospank_notes/features/notes/data/repositories_impl/notes_repo_impl.dart';
import 'package:pospank_notes/features/notes/domain/repositories/notes_repo.dart';
import 'package:pospank_notes/features/notes/domain/use_cases/clear_notes.dart';
import 'package:pospank_notes/features/notes/domain/use_cases/get_all_notes.dart';
import 'package:pospank_notes/features/notes/domain/use_cases/insert_note.dart';
import 'package:pospank_notes/features/notes/domain/use_cases/update_note.dart';
import 'package:pospank_notes/features/notes/presentation/bloc/insert_update_clear/insert_update_clear_bloc.dart';
import 'package:pospank_notes/features/notes/presentation/bloc/notes/notes_bloc.dart';
import 'package:pospank_notes/features/users/data/data_sources/local_data_source.dart';
import 'package:pospank_notes/features/users/data/data_sources/remote_data_source.dart';
import 'package:pospank_notes/features/users/data/repositories_impl/user_repo_impl.dart';
import 'package:pospank_notes/features/users/domain/repositories/user_repo.dart';
import 'package:pospank_notes/features/users/domain/usecases/get_all_interests.dart';
import 'package:pospank_notes/features/users/domain/usecases/get_all_users.dart';
import 'package:pospank_notes/features/users/domain/usecases/insert_user.dart';
import 'package:pospank_notes/features/users/presentation/bloc/user/user_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'core/network/network_info.dart';

import 'package:http/http.dart' as http;

import 'features/notes/data/data_sources/local_data_source.dart';
import 'features/notes/data/data_sources/remote_data_source.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features => posts

  //=> Blocs
  sl.registerFactory<NotesBloc>(() => NotesBloc(getAllNotes: sl()));
  sl.registerFactory<InsertUpdateClearNoteBloc>(() => InsertUpdateClearNoteBloc(
        clearNotes: sl(),
        insertNote: sl(),
        updateNote: sl(),
      ));
  sl.registerFactory<UserBloc>(() => UserBloc(
        getAllInterests: sl(),
        getAllUser: sl(),
        insertUser: sl(),
      ));

  //=> Usecases
  sl.registerLazySingleton<GetAllNotesUseCases>(
      () => GetAllNotesUseCases(sl()));
  sl.registerLazySingleton<ClearNotesUseCase>(() => ClearNotesUseCase(sl()));
  sl.registerLazySingleton<UpdateNoteUseCase>(() => UpdateNoteUseCase(sl()));
  sl.registerLazySingleton<InsertNoteUseCase>(() => InsertNoteUseCase(sl()));

  sl.registerLazySingleton<GetAllUserUseCases>(() => GetAllUserUseCases(sl()));
  sl.registerLazySingleton<InsertUserUseCase>(() => InsertUserUseCase(sl()));
  sl.registerLazySingleton<GetAllInterestsUseCase>(
      () => GetAllInterestsUseCase(sl()));

  //=> Repositories
  sl.registerLazySingleton<NotesRepo>(() => NotesRepoImpl(
        remoteDataSource: sl(),
        networkInfo: sl(),
        localDataSource: sl(),
      ));
  sl.registerLazySingleton<UserRepo>(() => UserRepoImpl(
        localDataSource: sl(),
        networkInfo: sl(),
        remoteDataSource: sl(),
      ));

  //=> Data Sources
  sl.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(dio: sl()));
  sl.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<RemoteDataSourceUser>(
      () => RemoteDataSourceUserImpl(dio: sl()));
  sl.registerLazySingleton<LocalDataSourceUser>(
      () => LocalDataSourceUserImpl(sharedPreferences: sl()));

  //=> core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //=> External Packages
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton<InternetConnectionChecker>(
      () => InternetConnectionChecker());
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => Dio());
}
