

import 'mvpexample_model.dart';

abstract class MVPExampleView {
  void showContactList(List<MVPExampleModel> items);

  void showError();
}
