class Good {
  int id;
  String title;
  String content;
  int price;
  String? filePath;
  int amount;
  Good({
    required this.id,
    required this.title,
    required this.content,
    this.price = 0,
    this.filePath,
    this.amount = 1
  });

}
