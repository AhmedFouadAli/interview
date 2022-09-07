class StoreData {
  static List allData = [];
  static List singlePerson = [];
  static Map pickerTime = {};

  static void addData(userName, pass) {
    StoreData.allData.add({"userName": userName, "password": pass});
    StoreData.singlePerson.add({"userName": userName, "password": pass});
    print(StoreData.allData);
  }

  static void addAvalibility(String dateTime) {
    if (StoreData.pickerTime[singlePerson[0]["userName"]] == null) {
      StoreData.pickerTime[singlePerson[0]["userName"]] = [{"time":dateTime,"reserved":false}];
    } else {
          StoreData.pickerTime[singlePerson[0]["userName"]].add({"time": dateTime, "reserved": false});
    }

  }
}
