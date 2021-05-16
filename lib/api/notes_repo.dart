import 'package:supabase/supabase.dart';

import 'package:supabase_notes/models/models.dart';

class NotesRepoError implements Exception {
  NotesRepoError({this.message});
  final String? message;
}

class NotesRepo {
  NotesRepo({required this.supabaseClient});
  final SupabaseClient supabaseClient;
  Future<List<Note>> fetch({int from = 0, int to = 10}) async {
    final res = await supabaseClient
        .from('notes')
        .select()
        .eq('user_id', supabaseClient.auth.currentUser!.id)
        .range(from, to)
        .execute();
    if (res.error != null)
      throw Exception(res.error!.message);
    else
      return List.from(res.data).map((e) => Note.fromMap(e)).toList();
  }

  Future<Note> insert(Note note) async {
    final res = await supabaseClient
        .from('notes')
        .insert(note
            .copyWith(
              user_id: supabaseClient.auth.currentUser!.id,
            )
            .toMap())
        .execute();
    if (res.error != null)
      throw NotesRepoError(message: res.error!.message);
    else
      return Note.fromMap(List.from(res.data)[0]);
  }

  Future<void> update(Note note) async {
    final res = await supabaseClient
        .from('notes')
        .update(note
            .copyWith(
                user_id: supabaseClient.auth.currentUser!.id,
                updatedAt: DateTime.now())
            .toMap())
        .eq('user_id', supabaseClient.auth.currentUser!.id)
        .eq('id', note.id)
        .execute();
    if (res.error != null) throw Exception(res.error!.message);
  }

  Future<void> delete(Note note) async {
    final res = await supabaseClient
        .from('notes')
        .delete()
        .eq('user_id', supabaseClient.auth.currentUser!.id)
        .eq('id', note.id)
        .execute();
    if (res.error != null) throw Exception(res.error!.message);
  }
}
