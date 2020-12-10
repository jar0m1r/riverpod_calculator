import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_calculator/business_logic/calculator/calculator_provider.dart';
import 'package:riverpod_calculator/business_logic/notes/notes_logic.dart';
import 'package:riverpod_calculator/business_logic/notes/notes_provider.dart';
import 'package:riverpod_calculator/business_logic/secretword/secretword_provider.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Riverpod Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyNotesScreen(),
    );
  }
}

class MyNotesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Consumer(builder: (context, watch, _) {
        NotesViewModel model = watch(notesViewModelProvider);
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.lightBlue,
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 4,
                child: Center(
                  child: Text(
                    model.name,
                    style: TextStyle(fontSize: 48),
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  children: model.notes
                      .map(
                        (note) => Card(
                          elevation: 4,
                          margin: EdgeInsets.all(8.0),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              note,
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 6,
                child: Center(child: SecretwordGameView()),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 6,
                child: Center(child: TimeoutCounter()),
              ),
            ],
          ),
        );
      }),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () => context.read(notesViewModelProvider).addNote(),
          ),
          FloatingActionButton(
            child: Icon(Icons.play_arrow),
            onPressed: () => context.read(secretwordSolverProvider).startGame(),
          ),
        ],
      ),
    );
  }
}

class TimeoutCounter extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final counter = watch(counterProvider);
    return Container(
      child: counter.when(
          loading: () => CircularProgressIndicator(),
          data: (value) => Text('$value'),
          error: (o, error) => Text('error $o $error')),
    );
  }
}

class SecretwordGameView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final game = watch(secretwordSolverProvider);
    final gameState = watch(secretwordSolverProvider.state);
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: gameState.word
            .map((letter) => Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(game.isPlayerInput(letter) ? letter : '.',
                      style: TextStyle(fontSize: 32)),
                ))
            .toList(),
      ),
    );
  }
}
