import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pospank_notes/features/users/domain/entities/user.dart';
import 'package:pospank_notes/features/users/presentation/bloc/user/user_bloc.dart';

import '../../../../core/app_widgets/loading_widget.dart';
import '../../../../core/app_widgets/message_display_widget.dart';

class AssignUserField extends StatelessWidget {
  const AssignUserField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is LoadingUserState) {
          return const LoadingWidget();
        } else if (state is LoadedUserState) {
          return RefreshIndicator(
            onRefresh: () {
              return _onRefresh(context);
            },
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Container(
                    // width: 80,
                    padding: const EdgeInsets.only(left: 15),
                    height: 25,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black26,
                            blurRadius: 2,
                            spreadRadius: 2,
                            offset: Offset(0, 3)),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: DropdownButton(
                      underline: Container(),
                      value: state.user,
                      borderRadius: BorderRadius.circular(20),
                      elevation: 2,
                      items: state.user.map((User user) {
                        return DropdownMenuItem(
                          value: state.user,
                          child: Text(user.username),
                        );
                      }).toList(),
                      onChanged: (value) {},
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (state is ErrorUserState) {
          return Column(
            children: [
              _buildRefreshButton(context, 'Refresh'),
              MessageDisplayWidget(message: state.message),
            ],
          );
        }
        return const LoadingWidget();
      },
    );
  }

  Future<void> _onRefresh(
    BuildContext context,
  ) async {
    BlocProvider.of<UserBloc>(context).add(RefreshUserEvent());
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
}
