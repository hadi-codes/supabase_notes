import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:supabase_notes/models/models.dart';
import 'package:supabase_notes/routes/pages.dart';
import 'package:supabase_notes/screens/home/bloc/notes_list_bloc.dart';
import 'package:supabase_notes/screens/noteEditor/note.dart';
import 'package:supabase_notes/services/services.dart';
import 'package:animations/animations.dart';
import 'package:supabase_notes/theme/theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotesListBloc()..add(NotesListInit()),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(
                FeatherIcons.logOut,
                color: Colors.red,
              ),
              onPressed: () {
                context.read<AuthCubit>().logout();
              },
            ),
          ],
        ),
        body: BlocBuilder<NotesListBloc, NotesListState>(
          builder: (context, state) {
            if (state is NotesListData) {
              return Scaffold(
                body: StaggeredGridView.countBuilder(
                  itemCount: state.notes.length,
                  itemBuilder: (context, index) =>
                      _NoteItem(note: state.notes[index]),
                  primary: false,
                  crossAxisCount: 4,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 5,
                  padding: const EdgeInsets.all(10),
                  staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
                ),
              );
            } else if (state is NotesListError) {
              return const Text('err');
            } else
              return const Center(
                child: CircularProgressIndicator(),
              );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Get.toNamed(Routes.noteEditor),
          child: const Icon(FeatherIcons.plus),
        ),
      ),
    );
  }
}

class _NoteItem extends StatelessWidget {
  const _NoteItem({Key? key, required this.note}) : super(key: key);
  final Note note;
  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedColor: AppTheme.gray1,
      openColor: Colors.transparent,
      openBuilder: (context, action) => NoteEditorPage(
        note: note,
      ),
      closedShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      closedBuilder: (context, action) => Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).accentColor, width: 2),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            note.title != null ? Text(note.title!) : const SizedBox.shrink(),
            SizedBox(height: note.title != null ? 5 : 0),
            Text(
              note.body ?? '',
              maxLines: 10,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
