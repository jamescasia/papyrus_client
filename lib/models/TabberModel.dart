import 'package:scoped_model/scoped_model.dart';

class TabberModel extends Model {
  int currentPage = 1;

  changeCurrentPage(int index) {
    currentPage = index;
    print(index.toString() + "atay");
    notifyListeners();
  }
}
