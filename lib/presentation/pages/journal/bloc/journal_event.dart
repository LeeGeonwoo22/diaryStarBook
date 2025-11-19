
import '../../../../domain/models/journal.dart';

abstract class JournalEvent {}

class LoadJournals extends JournalEvent {}

class AddJournal extends JournalEvent {
  final String title;
  final String content;

  AddJournal(this.title,this.content);
}

class DeleteJournal extends JournalEvent{
  final String id;

  DeleteJournal(this.id);
}

class UpdateJournal extends JournalEvent {
  final Journal updatedJournal;
  UpdateJournal(this.updatedJournal);
}