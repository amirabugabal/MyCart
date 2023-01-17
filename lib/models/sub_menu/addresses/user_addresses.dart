import 'package:mycart/models/addresses/delivery_locations.dart';
import 'package:mycart/services/data_manager.dart';

class UserAddressesClass {
  String id;
  String userId;
  String locationId;
  DeliveryLocationsClass locationData;
  String streetName;
  String buildingNumber;
  int floorNumber;
  int apartmentNumber;
  String phoneNumber;
  UserAddressesClass(
      this.id,
      this.userId,
      this.locationId,
      this.streetName,
      this.buildingNumber,
      this.floorNumber,
      this.apartmentNumber,
      this.phoneNumber,) {
    for (DeliveryLocationsClass i in DataManager.deliveryLocations) {
      if (i.id == this.locationId) {
        locationData = i;
      }
    }
  }
}
