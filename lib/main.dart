import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp_state/blocs/counter/counter_bloc.dart';
import 'package:tp_state/blocs/chat/chat_bloc.dart';
import 'package:tp_state/repositories/chat_repository.dart';
import 'package:tp_state/ui/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CounterBloc()),
        BlocProvider(create: (context) => ChatBloc(chatRepository: ChatRepository())),
      ],
      child: MaterialApp(
        title: 'TP State BLoC',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
