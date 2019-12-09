
import 'package:flutter/cupertino.dart';

abstract class MvpView {

  BuildContext getContext();

  /// 显示加载progress
  showProgress();

  /// 关闭progress
  closeProgress();

  /// 显示toast提示
  showToast(String string);
}

abstract class Presenter extends Lifecycle {

}

abstract class Lifecycle {

  initState();

  didChangeDependencies();

  didUpdateWidgets<W>(W oldWidget);

  deactivate();

  dispose();

}