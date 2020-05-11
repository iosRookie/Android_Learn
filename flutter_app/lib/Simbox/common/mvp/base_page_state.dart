import 'package:flutter/material.dart';
import 'package:flutter_app/Simbox/common/mvp/base_page_presenter.dart';
import 'package:flutter_app/Simbox/common/mvp/mvp_view.dart';
import 'package:flutter_app/Simbox/common/widget/LoadingDialog.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

abstract class BasePageState<T extends StatefulWidget, P extends BasePagePresenter> extends State<T> implements MvpView {

  P presenter;

  bool _isShowDialog = false;
  LoadingDialog _requestProgress;

  BasePageState() {
    presenter = createPresenter();
    presenter.view = this;
  }

  P createPresenter();

  @override
  BuildContext getContext() => context;

  @override
  closeProgress() {
    if (mounted && _isShowDialog){
      _isShowDialog = false;
//      Navigator.of(context).pop();
      Navigator.of(context).pop(_requestProgress);
    }
  }

  @override
  showProgress() {
    /// 避免重复弹出
    if (mounted && !_isShowDialog){
      _isShowDialog = true;
      try{
        showDialog(
            context: context,
            builder: (context) {
          return _requestProgress;
        });
      }catch(e){
        /// 异常原因主要是页面没有build完成就调用Progress。
        print(e);
      }
    }
  }

  @override
  disMissProgressCallBack(Function func) {

  }

  @override
  showToast(String string) {

  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    presenter?.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    presenter?.dispose();
  }

  @override
  void deactivate() {
    super.deactivate();
    presenter?.deactivate();
  }

  @override
  void didUpdateWidget(T oldWidget) {
    super.didUpdateWidget(oldWidget);
    didUpdateWidgets<T>(oldWidget);
  }

  @override
  void initState() {
    _requestProgress = LoadingDialog(
      dismissCallback: disMissProgressCallBack,
      outsideDismiss: false,
    );

    super.initState();
    presenter?.initState();
  }

  didUpdateWidgets<W>(W oldWidget) {
    presenter?.didUpdateWidgets<W>(oldWidget);
  }
}