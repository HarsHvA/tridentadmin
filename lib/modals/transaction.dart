class TransactionsModel {
  final int amount;
  final int mobileNo;
  final String status;
  final String mode;
  final String uid;
  final String transactionId;

  TransactionsModel(
      {this.amount,
      this.mobileNo,
      this.mode,
      this.status,
      this.uid,
      this.transactionId});
}
