//[
//{
//"amount": 12,
//"routeNumberr": "d",
//"id": "New York",
//"timestamp": "uid",
//"nAdults": 1,
//"nStudents": 1,
//"nChildren": 1,
//"creditCardId": "d"
//}
//]


class OrderDetailsModel {
  int amount;
  String routeNumberr;
  String id;
  String timestamp;
  int nAdults;
  int nStudents;
  int nChildren;
  String creditCardId;

  OrderDetailsModel(
      {this.amount,
        this.routeNumberr,
        this.id,
        this.timestamp,
        this.nAdults,
        this.nStudents,
        this.nChildren,
        this.creditCardId});

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    routeNumberr = json['routeNumberr'];
    id = json['id'];
    timestamp = json['timestamp'];
    nAdults = json['nAdults'];
    nStudents = json['nStudents'];
    nChildren = json['nChildren'];
    creditCardId = json['creditCardId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['routeNumberr'] = this.routeNumberr;
    data['id'] = this.id;
    data['timestamp'] = this.timestamp;
    data['nAdults'] = this.nAdults;
    data['nStudents'] = this.nStudents;
    data['nChildren'] = this.nChildren;
    data['creditCardId'] = this.creditCardId;
    return data;
  }
}
