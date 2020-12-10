import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_calculator/business_logic/notes/notes_logic.dart';
import 'package:riverpod_calculator/business_logic/notes/notes_provider.dart';
import 'package:riverpod_calculator/ui/smart_widgets/timer.dart';

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
        ],
      ),
    );
  }
}
