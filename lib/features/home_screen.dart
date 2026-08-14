import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled4/features/auth/user_cubit.dart';
import 'package:untitled4/features/auth/user_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<UserCubit>().getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserCubit, UserState>(
        builder: (BuildContext context, state) {
          if (state is UserLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is UserComplete) {
            return ListView.builder(
              itemCount: state.userModel.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(state.userModel[index].address.toString()),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Divider(height: 1),
                    ),
                  ],
                );
              },
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
