class Money {
  int id;
  String title;
  String price;
  String date;
  bool isReceived;
  Money(
      {required this.id,
      required this.price,
      required this.date,
      required this.isReceived,
      required this.title});
}
