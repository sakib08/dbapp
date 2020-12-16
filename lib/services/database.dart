import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:sondhani/models/user.dart';

class DatabaseService{

final String uid;
DatabaseService({ this.uid });
// collection Ref 
final CollectionReference donorCollection = Firestore.instance.collection('donor');

Future updateUserData(String birthdate, String name,String bloodgroup,String city,String phone,String email,String address,double lat,double long,String available) async{
  return await donorCollection.document(uid).setData({
    'name': name,
    'birthdate': birthdate,
    'bloodgroup': bloodgroup,
    'city': city,
    'phone': phone,
    'email': email,
    'address': address,
    'lat': lat,
    'long': long,
    'available': available,
  });
 }


}