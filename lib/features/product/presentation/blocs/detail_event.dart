abstract class DetailEvent {}

class LoadProductByID extends DetailEvent {
  final int id;

  LoadProductByID(this.id);
}