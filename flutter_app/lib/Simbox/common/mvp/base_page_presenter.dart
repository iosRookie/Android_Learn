import 'package:flutter_app/Simbox/common/mvp/mvp_view.dart';

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