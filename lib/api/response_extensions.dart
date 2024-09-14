import 'package:dio/dio.dart';
import 'package:supra/helpers.dart';

extension ResponseExtensions on Response{
  dynamic getObjectBody() {
    return jDecode(this.data);
  }

  String fetchMessage(){
    try{
      return getObjectBody()["message"];
    }catch(e){
      return 'error in getting data';
    }
  }
  dynamic fetchData() {
    return jDecode(this.data)["data"];
  }
}