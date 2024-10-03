import 'package:hive/hive.dart';



@HiveType(typeId: 1)
class SearchHistory {
  @HiveField(0)
  String query;
  @HiveField(1)
  DateTime date;

  SearchHistory({required this.query, required this.date});
}


// Adapter cho SearchHistory
class SearchHistoryAdapter extends TypeAdapter<SearchHistory> {
  @override
  final int typeId = 1;

  @override
  SearchHistory read(BinaryReader reader) {
    final query = reader.readString();
    final date = reader.read() as DateTime; // Sử dụng reader.read() cho DateTime
    return SearchHistory(query: query, date: date);
  }

  @override
  void write(BinaryWriter writer, SearchHistory obj) {
    writer.writeString(obj.query);
    writer.write(obj.date); // Sử dụng writer.write() cho DateTime
  }
}
