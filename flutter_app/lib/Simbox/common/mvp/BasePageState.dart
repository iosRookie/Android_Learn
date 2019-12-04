import 'package:flutter/material.dart';
import 'package:flutter_app/Simbox/common/mvp/BasePagePresenter.dart';
import 'package:flutter_app/Simbox/common/mvp/MvpView.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

abstract class BasePageState<T extends StatefulWidget, P extends BasePagePresenter> extends State<T> implements MvpView {

  P presenter;

  bool _isShowDialog = false;

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
          builder: ((context) {
            return SpinKitRing(color: Colors.red,);
          })
        );
      }catch(e){
        /// 异常原因主要是页面没有build完成就调用Progress。
        print(e);
      }
    }
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
    super.initState();
    presenter?.initState();
  }

  didUpdateWidgets<W>(W oldWidget) {
    presenter?.didUpdateWidgets<W>(oldWidget);
  }
}