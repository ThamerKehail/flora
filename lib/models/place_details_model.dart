class PlaceDetailsModel {
  int id;
  String fname;
  String lname;
  String address;

  String businessDescription;
  int from;
  int to;
  double city;
  String cover;
  String lat;
  String long;
  String profileImage;
  double distance;
  String email;
  PlaceDetailsModel({
    required this.fname,
    required this.address,
    required this.lname,
    required this.long,
    required this.lat,
    required this.profileImage,
    required this.to,
    required this.from,
    required this.cover,
    required this.id,
    required this.businessDescription,
    required this.city,
    required this.distance,
    required this.email,
  });
}
