abstract class HistoryEvent {}

class GetHistorySearch extends HistoryEvent {
}
class SaveHistorySearch extends HistoryEvent {
  String query;

  SaveHistorySearch(this.query);
}
class RemoveHistorySearch extends HistoryEvent {
  String query;

  RemoveHistorySearch(this.query);
}

class RemoveAllHistorySearch extends HistoryEvent {
}
