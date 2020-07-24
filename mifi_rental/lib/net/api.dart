class UrlApi {
  // 测试环境
  static const String BASE_HOST = 'https://rental.ukelink.net';
  static const String PAYPAL_HOST = 'https://saas82mph5.ukelink.net/pay/authPaypal';
  // 开发环境
//  static const String BASE_HOST =  'http://58.251.37.197:10199';//'https://rentaldev.ukelink.net';
//  static const String PAYPAL_HOST = 'https://webdevmph5.ukelink.net/pay/authPaypal';

  static const String DOCUMENT_HOST = 'https://appweb.ukelink.net/';
  static const String PARTNER_CODE  = 'RMSYSTEM';

  static const String CREATE_ORDER = BASE_HOST + '/rm/web/app/order/createOrder'; // 创建订单
  static const String QUERY_ORDER_INFO =  BASE_HOST + '/rm/web/app/order/queryOrderInfo'; // 订单信息
  static const String HANDLER_ORDER =  BASE_HOST + '/rm/web/app/order/handlerOrder'; // 弹出设备
  static const String QUERY_POPUP_RESULT =  BASE_HOST + '/rm/web/app/terminal/queryPopupResult'; // 查询弹出结果
  static const String CANCEL_ORDER =  BASE_HOST + '/rm/web/app/order/cancelOrder'; // 取消订单
  static const String QUERY_MIFI_INFO =  BASE_HOST + '/rm/web/app/mifi/queryMifiInfo'; // mifi信息
  static const String QUERY_TERMINAL_INFO =  BASE_HOST + '/rm/web/app/terminal/queryTerminalInfo'; // 设备信息
  static const String QUERY_NEARBY_TERMINAL_INFO =  BASE_HOST + '/rm/web/app/bank/nearlyBank'; // 附近网点
  static const String GET_CONF_BY_MVNO =  BASE_HOST + '/rm/web/app/conf/getConfByMvno';
  static const String ISSUE_REPORT =  BASE_HOST + '/rm/web/app/feedBack/issueReport';  // 问题反馈
  static const String BUY_MIFI =  BASE_HOST + '/rm/web/app/order/keepIt'; // 购买设备
  static const String QUERY_GOODS_INFO =  BASE_HOST + '/rm/web/app/order/queryOfferInfo'; // 流量查询
  static const String QUERY_BINDING_TOKEN =  BASE_HOST + '/rm/web/app/mifi/queryBindingToken'; // 流量查询
  static const String UPLOAD_IMAGE =  BASE_HOST + '/webmps/common/s3/uploadRm'; // 图片上传

  static const String QUERY_OFFER_LIST =  BASE_HOST + '/bss/app/noauth/QueryOfferList'; // 销售品查询(流量包查询)
  static const String PRE_CALC_ORDER =  BASE_HOST + '/bss/app/order/PreCalcOrder'; // 下单时预计算订单费用
  static const String FLOW_PACKAGE_CREATE_ORDER =  BASE_HOST + '/bss/app/order/CreateOrder'; // 创建订单接口

}
