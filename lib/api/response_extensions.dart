 import 'package:http/http.dart';
import 'package:supra/helpers.dart';

extension ResponseExtensions on Response{
  dynamic getObjectBody() {
    return jDecode(this.body);
  }

  String fetchMessage(){
    try{
      return getObjectBody()["message"];
    }catch(e){
      return 'error in getting data';
    }
  }
  dynamic fetchData() {
    return jDecode(this.body)["data"];
  }
}