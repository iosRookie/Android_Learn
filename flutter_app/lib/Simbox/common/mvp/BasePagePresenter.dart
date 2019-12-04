import 'package:flutter_app/Simbox/common/mvp/MvpView.dart';

class BasePagePresenter<V extends MvpView> extends Presenter {
  V view;

  @override
  didChangeDependencies() {}

  @override
  didUpdateWidgets<W>(W oldWidget) {}

  @override
  dispose() {}

  @override
  initState() {}

  @override
  deactivate() {}

}