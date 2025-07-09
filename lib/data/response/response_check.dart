
import 'package:dizisalon_vender/data/response/exception.dart';

dynamic checkREsponse(response) {
  // print(response.statusCode);
  if (response.statusCode == 200) {
    var data = response.data;
    // ShowToast(msg: data);
    return data;
  } else if (response.statusCode == 400) {
    return BadRequestException(response.data.toString());
  } else {
    return FetchDataException(
        "Error Occured while communicate the server with status code: ${response.statusCode}");
  }
}
