class Ticket {
  final String orderID;


Ticket({
  required this.orderID,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      orderID: json['orderID'],
    );
  }
}