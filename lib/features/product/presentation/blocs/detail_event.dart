abstract class DetailEvent {}

class LoadProductByID extends DetailEvent {
  final String id;

  LoadProductByID(this.id);
}