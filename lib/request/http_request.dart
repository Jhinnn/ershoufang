import 'package:dio/dio.dart';

class DioHouseFactory {
  static Future<String> getString(param, page,
      {isSearch = false, options, cancelToken, data}) async {
    var dio = Dio(); // with default Options

    dio.options.baseUrl = 'https://wh.lianjia.com/ershoufang/';

    dio.options.connectTimeout = 60000;
    dio.options.receiveTimeout = 60000;

    try {
      // https://wh.lianjia.com/ershoufang/baishazhou/pg100sf1/
      // String url = isSearch
      //     ? '?$param&page=$page'
      //     : page == 1
      //         ? 'rs$param/'
      //         : 'pg${page}rs$param/';
      String url = page == 1 ? '$param/sf1/' : '$param/pg${page}sf1/';

      print('请求地址：$url，时间戳：${DateTime.now()}');
      Response response =
          await dio.get(url, cancelToken: cancelToken, options: options);
      return response.data.toString();
    } catch (e) {
      return '';
    }
  }

  static Future<String> getxxxString(param, page,
      {isSearch = false, options, cancelToken, data}) async {
    var dio = Dio(); // with default Options

    dio.options.baseUrl = 'https://wh.lianjia.com/ershoufang/';

    dio.options.connectTimeout = 60000;
    dio.options.receiveTimeout = 60000;

    try {
      // https://wh.lianjia.com/ershoufang/baishazhou/pg100sf1/
      // String url = isSearch
      //     ? '?$param&page=$page'
      //     : page == 1
      //         ? 'rs$param/'
      //         : 'pg${page}rs$param/';
      String url = page == 1 ? 'sf1rs$param/' : 'pg2sf1rs$param/';

      print('请求地址：$url，时间戳：${DateTime.now()}');
      Response response =
          await dio.get(url, cancelToken: cancelToken, options: options);
      return response.data.toString();
    } catch (e) {
      return '';
    }
  }

  static Future<String> getDaddy() async {
    var dio = Dio(); // with default Options

    dio.options.baseUrl = 'https://mp.weixin.qq.com/s/';

    dio.options.connectTimeout = 60000;
    dio.options.receiveTimeout = 60000;

    try {
      // https://wh.lianjia.com/ershoufang/baishazhou/pg100sf1/
      // String url = isSearch
      //     ? '?$param&page=$page'
      //     : page == 1
      //         ? 'rs$param/'
      //         : 'pg${page}rs$param/';
      String url = '__biz=MzU0MzI3NDM3Mw==&mid=2247502720&idx=2&sn=cf8e84a6a066bee235b99a6579e9b1e4&chksm=fb0f6f6acc78e67ca01f95e1bda1107cb627eaa568e8341659ca996cd8a6b3d9caa9b802c47c&scene=27';

      print('请求地址：$url，时间戳：${DateTime.now()}');
      Response response =
          await dio.get(url);
      return response.data.toString();
    } catch (e) {
      return '';
    }
  }


}
