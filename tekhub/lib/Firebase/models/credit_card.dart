class CreditCard {
  CreditCard({
    required this.cardNumber,
    required this.fullName,
    required this.expirationDate,
    required this.cvv,
  });

  final String cardNumber;
  final String fullName;
  final String expirationDate;
  final String cvv;
}
