class Transactions {
  String title; //ชื่อ
  String lastname;
  String address;
  String phone;
  double amount; //เบอร์
  String email;
  String password;
  DateTime date; //วันที่ เวลา บันทึกรายการ

  Transactions(
      {this.title,
      this.lastname,
      this.address,
      this.amount,
      this.email,
      this.password,
      this.date});
}
