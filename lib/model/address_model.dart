class DeliveryAddressModel {
  String firstName;
  String lastName;
  String mobNo;
  String AlternativeMobNo;
  String Society;
  String Street;
  String landMArk;
  String City;
  String Area;
  String PinCode;
  String AddresType;

  DeliveryAddressModel({
    required this.Area,
    required this.AlternativeMobNo,
    required this.City,
    required this.firstName,
    required this.landMArk,
    required this.lastName,
    required this.mobNo,
    required this.PinCode,
    required this.Street,
    required this.Society,
    required this.AddresType
  });
}