class MedicalService {
  final String title;
  final String price;
  final String duration;
  int amount;

  MedicalService({
    required this.title,
    required this.price,
    required this.duration,
    this.amount = 0,
  });
}