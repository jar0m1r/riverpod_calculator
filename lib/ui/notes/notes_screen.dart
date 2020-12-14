import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_calculator/business_logic/notes/notes_provider.dart';
import 'package:riverpod_calculator/business_logic/notes/notes_state.dart';
import 'package:riverpod_calculator/models/note.dart';

class MyNotesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: ProviderListener<NotesState>(
        provider: notesNotifierProvider.state,
        onChange: (context, state) {
          if (state is NotesErrorState)
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
        },
        child: Consumer(builder: (context, watch, child) {
          final state = watch(notesNotifierProvider.state);

          if (state is NotesInitialState) {
            return _buildInitial();
          } else if (state is NotesLoadingState) {
            return _buildLoading();
          } else if (state is NotesLoadedState) {
            return _buildLoaded(state.notes);
          } else {
            return _buildInitial();
          }
        }),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () async => await context
                .read(notesNotifierProvider)
                .addNote(Note('new note', 'this is a test')),
          ),
        ],
      ),
    );
  }

  Widget _buildInitial() {
    return Container();
  }

  Widget _buildLoading() {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildLoaded(List<Note> notes) {
    return Container(
      color: Colors.lightBlue,
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: notes
                  .map(
                    (note) => Card(
                      elevation: 4,
                      margin: EdgeInsets.all(8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          note.title,
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
