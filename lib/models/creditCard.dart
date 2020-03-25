class CreditCardModel {
  String cardHolderName;
  String cardNumber;
  String cVV;
  String expiryDate;

  CreditCardModel(
      {this.cardHolderName, this.cardNumber, this.cVV, this.expiryDate});

  CreditCardModel.fromJson(Map<String, dynamic> json) {
    cardHolderName = json['cardHolderName'];
    cardNumber = json['cardNumber'];
    cVV = json['CVV'];
    expiryDate = json['expirydte'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cardHolderName'] = this.cardHolderName;
    data['cardNumber'] = this.cardNumber;
    data['CVV'] = this.cVV;
    data['expirydte'] = this.expiryDate;
    return data;
  }
}
