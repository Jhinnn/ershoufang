import 'dart:convert';
import 'package:ershoufang/constants/app_colors.dart';
import 'package:ershoufang/model/building_count_model.dart';
import 'package:ershoufang/model/house_model.dart';
import 'package:ershoufang/model/regions_model.dart';
import 'package:ershoufang/sql/db_helper.dart';
import 'package:ershoufang/widget/sort_widge.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../request/api.dart';

class ErShouFangPage extends StatefulWidget {
  const ErShouFangPage({Key? key}) : super(key: key);

  @override
  ErShouFangPageState createState() => ErShouFangPageState();
}

class ErShouFangPageState extends State<ErShouFangPage> {
  final List<HouseModel> _packages = [];
  final ScrollController _scrollController = ScrollController();

  bool isLoading = false;
  int page = 0;

  int totalHouse = 0;

  List<String> regions = [];

  CityModel? cityModel;

  List<BuildingModel> buildings = [];
  List<HouseModel> houses = [];
  List<BuildingCountModel> buildingModels = [];

  String region = '';
  String buildingName = '';

  String cellName = '';
  int buildingsCount = 0;

  List<String> condiS = ['默认排序', '最新发布', '房屋单价', '房屋总价', '房屋面积'];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // _loadMoreData();

    // // 添加滚动监听器，检测是否需要加载更多
    // _scrollController.addListener(() {
    //   if (_scrollController.position.pixels ==
    //       _scrollController.position.maxScrollExtent) {
    //     // 开始加载更多数据
    //     _loadMoreData();
    //   }
    // });
    loadJsonData();

    Dddpip.fetchPackages()
;
    // makeMultipleRequests();
  }

  Future<void> loadJsonData() async {
    String jsonString = await rootBundle.loadString('assets/json/regions.json');
    Map<String, dynamic> jsonData = json.decode(jsonString);

    // 现在你可以使用 jsonData 对象进行操作
    cityModel = CityModel.fromJson(jsonData);
    int length = 0;
    for (RegionsModel model in cityModel!.region) {
      int totalHouse = 0;
      regions.add(model.region);

      List<BuildingModel> buildings = model.buildings;
      // for (BuildingModel buildingModel in buildings) {
      //   // totalHouse += buildingModel.length * 30;
      //   // print(buildingModel.name + '' + buildingModel.length.toString());
      // makeMultipleRequests(buildings);
      // }
      // for (var i = 0; i < buildings.length; i++) {
      //   int count = await DbHelper.instance.houseTable.queryByRegion(buildings[i].name);
      //   totalHouse += count;
      // }
      // length += totalHouse;
    }
    // print('总数为：$length');
    setState(() {});
  }

  // Future<void> loadJsonData() async {
  //   String jsonString = await rootBundle.loadString('assets/json/regions.json');
  //   Map<String, dynamic> jsonData = json.decode(jsonString);

  //   // 现在你可以使用 jsonData 对象进行操作
  //   CityModel cityModel = CityModel.fromJson(jsonData);

  //   for (RegionsModel model in cityModel.region) {
  //     print(
  //         '----------------------${model.region}------------------------------');
  //     List<BuildingModel> buildings = model.buildings;
  //     // for (BuildingModel buildingModel in buildings) {
  //     //   // totalHouse += buildingModel.length * 30;
  //     //   // print(buildingModel.name + '' + buildingModel.length.toString());
  //     makeMultipleRequests(buildings);
  //     // }
  //   }
  //   print('总数为：$totalHouse');
  // }

  // Future<void> makeMultipleRequests(List<BuildingModel> buildings) async {
  //   for (BuildingModel model in buildings) {
  //     for (int i = 1; i <= model.length; i++) {
  //       print('小区名称：' + model.name + "请求第$i页数据");
  //       await makeSingleRequest(model.pinyin, i);
  //     }
  //   }
  // }

  // Future<void> makeSingleRequest(param, i) async {
  //   List<HouseModel> data = await Hpi.fetchPackages(param, i);

  //   for (var element in data) {
  //     await DbHelper.instance.houseTable.insertHouseModel(element);
  //   }

  //   setState(() {
  //     _packages.addAll(data);
  //   });
  // }

  // void _loadMoreData() async {
  //   if (!isLoading) {
  //     setState(() {
  //       isLoading = true;
  //     });
  //     page++;

  //     Hpi.fetchPackages("baishazhou", page).then((data) {
  //       for (var element in data) {
  //         DbHelper.instance.houseTable.insertHouseModel(element);
  //       }
  //       setState(() {
  //         _packages.addAll(data);
  //       });
  //     });
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 38,
          color: AppColors.goodColor,
          padding: EdgeInsets.only(right: 3, left: 460),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('武汉二手房', style: Theme.of(context).textTheme.titleLarge),
              Container(
                height: 28.0,
                width: 240.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.0),
                  border: Border.all(
                    color: Colors.grey,
                    width: 0.6,
                  ),
                ),
                child: const TextField(
                  style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w200),
                  cursorColor: Colors.white,
                  cursorWidth: 0.6,
                  decoration: InputDecoration(
                      hintText: '请输入小区名称',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w100),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 8, right: 12, bottom: 16)),
                ),
              ),
            ],
          ),
        ),
        Expanded(
            child: Row(
          children: [
            Expanded(
              flex: 10,
              child: Container(
                padding: EdgeInsets.only(top: 10),
                margin: EdgeInsets.only(left: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      alignment: WrapAlignment.start,
                      spacing: 4,
                      runSpacing: 4,
                      children: cityModel != null
                          ? cityModel!.region
                              .map((e) => InkWell(
                                    onTap: () => regionChange(e),
                                    child: Chip(
                                      backgroundColor: region == e.region ? AppColors.bgColor : Color.fromARGB(255, 170, 165, 165),
                                      padding: EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                                      label: Text(e.region, style: TextStyle(color: region == e.region ? Colors.white : AppColors.goodColor, fontSize: 11)),
                                    ),
                                  ))
                              .toList()
                          : [],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Wrap(
                      alignment: WrapAlignment.end,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      runAlignment: WrapAlignment.end,
                      spacing: 2,
                      runSpacing: 2,
                      children: buildings
                          .map((e) => InkWell(
                                onTap: () => secondRegionChange(e),
                                child: Chip(
                                  backgroundColor: buildingName == e.name ? AppColors.bgColor : Color.fromARGB(255, 215, 206, 206),
                                  padding: EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                                  label: Text(e.name, style: TextStyle(color: buildingName == e.name ? Colors.white : AppColors.goodColor, fontSize: 10)),
                                ),
                              ))
                          .toList(),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    SortWidget(
                      titles: condiS,
                      onConditionsTap: (p0, p1) => sort(p0, p1),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Expanded(
                      child: houses.isNotEmpty
                          ? ListView.separated(
                              controller: _scrollController,
                              separatorBuilder: (context, index) => const Divider(
                                height: 1,
                              ),
                              padding: EdgeInsets.only(right: 5),
                              itemBuilder: (context, index) {
                                HouseModel model = houses[index];
                                return Container(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: Image.network(
                                          model.cover,
                                          width: 80,
                                          height: 60,
                                          errorBuilder: (context, error, stackTrace) => Container(
                                            width: 80,
                                            height: 60,
                                            color: const Color.fromARGB(255, 167, 170, 175),
                                            child: const Center(
                                              child: Icon(
                                                Icons.house,
                                                size: 34,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                          child: SizedBox(
                                        height: 60,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  model.description,
                                                  style: Theme.of(context).textTheme.titleMedium,
                                                  maxLines: 1,
                                                ),
                                                Text(
                                                  model.publishTime,
                                                  style: Theme.of(context).textTheme.labelSmall,
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      model.area + '平米',
                                                      style: Theme.of(context).textTheme.titleSmall,
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(model.floor, style: Theme.of(context).textTheme.titleSmall),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      model.region,
                                                      style: Theme.of(context).textTheme.labelSmall,
                                                    ),
                                                    Text(
                                                      '-',
                                                      style: Theme.of(context).textTheme.labelSmall,
                                                    ),
                                                    Text(
                                                      model.buildName,
                                                      style: Theme.of(context).textTheme.labelSmall,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            InkWell(
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    model.priceList.first.price,
                                                    style: Theme.of(context).textTheme.labelMedium,
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(model.priceList.first.totalPrice, style: Theme.of(context).textTheme.labelMedium),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  model.priceList.length != 1 ? Icon(Icons.list,size: 15,) : Container()
                                                ],
                                              ),
                                              onTap: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) => Material(color: Colors.transparent, child:Center(
                                                      child: Container(
                                                        decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(8)),
                                                        width: 320,
                                                        height: 200,
                                                        child: Center(
                                                          child: ListView.builder(
                                                                shrinkWrap: true,
                                                                physics: NeverScrollableScrollPhysics(),
                                                                itemBuilder: (context, index) {
                                                                  return Row(
                                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                                    children: [
                                                                    model.priceList[index].price.isEmpty ? Container() : Text(model.priceList[index].price),
                                                                    SizedBox(width: 5,),
                                                                    model.priceList[index].totalPrice.isEmpty ? Container() : Text(model.priceList[index].totalPrice),
                                                                    SizedBox(width: 5,),
                                                                    Text(DateTime.fromMillisecondsSinceEpoch(model.priceList[index].time).toString())
                                                                  ]);
                                                                },
                                                                itemCount: model.priceList.length,
                                                              ),
                                                        ),
                                                      ),
                                                    )));
                                              },
                                            )
                                          ],
                                        ),
                                      ))
                                    ],
                                  ),
                                );
                              },
                              itemCount: houses.length,
                            )
                          : Container(),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
                flex: 3,
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(left: 12),
                  child: buildingModels.isNotEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 108,
                                  padding: EdgeInsets.only(top: 6),
                                  color: Colors.white,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '共' + houses.length.toString() + '套房源',
                                        style: Theme.of(context).textTheme.titleMedium,
                                      ),
                                      cellName.isEmpty ? Container() : IconButton(onPressed: () => updateRegions(), icon: Icon(Icons.refresh)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: ListView.builder(
                                  itemBuilder: (context, index) {
                                    BuildingCountModel model = buildingModels[index];
                                    return InkWell(
                                      onTap: () => thirdRegionChage(model),
                                      child: Container(
                                          padding: EdgeInsets.symmetric(vertical: 4),
                                          child: Row(children: [
                                            Expanded(
                                                child: Text(
                                              '${model.buildName}(${model.count.toString()})',
                                              maxLines: 2,
                                              style:
                                                  TextStyle(color: cellName == model.buildName ? AppColors.bgColor : const Color.fromARGB(255, 78, 77, 77), fontSize: 12, fontWeight: FontWeight.w100),
                                            )),
                                            SizedBox(
                                              width: 10,
                                            )
                                          ])),
                                    );
                                  },
                                  itemCount: buildingModels.length),
                            ),
                          ],
                        )
                      : Container(),
                )),
          ],
        ))
      ],
    ));
  }

  //修改选择区
  void regionChange(RegionsModel e) {
    buildings = e.buildings;
    region = e.region;
    cellName = "";
    setState(() {});
  }

  //修改选择二级区域
  void secondRegionChange(BuildingModel e) async {
    houses.clear();
    cellName = "";
    houses = await DbHelper.instance.houseTable.queryByRegion(e.name);
    buildingName = e.name;
    buildingModels = await DbHelper.instance.houseTable.queryBuildingsByRegion(e.name);
    setState(() {});
  }

  //修改选择三级区域
  void thirdRegionChage(BuildingCountModel model) async {
    cellName = model.buildName;
    houses.clear();
    houses = await DbHelper.instance.houseTable.queryByBuildName(model.buildName);
    setState(() {});
  }

  //排序
  void sort(p0, p1) {
    switch (p0) {
      case 0:
        {}
        break;
      case 1:
        {}
        break;
      case 2:
        {
          if (p1) {
            houses.sort((a, b) {
              return a.priceList.first.price.compareTo(b.priceList.first.price);
            });
          } else {
            houses.sort((a, b) {
              return b.priceList.first.price.compareTo(a.priceList.first.price);
            });
          }
        }
        break;
      case 3:
        {
          if (p1) {
            houses.sort((a, b) {
              return a.priceList.first.totalPrice.compareTo(b.priceList.first.totalPrice);
            });
          } else {
            houses.sort((a, b) {
              return b.priceList.first.totalPrice.compareTo(a.priceList.first.totalPrice);
            });
          }
        }
      case 4:
        {
          if (p1) {
            houses.sort((a, b) {
              double aArea = double.parse(a.area) * 100;
              double bArea = double.parse(b.area) * 100;
              return aArea.compareTo(bArea);
            });
          } else {
            houses.sort((a, b) {
              double aArea = double.parse(a.area) * 100;
              double bArea = double.parse(b.area) * 100;
              return bArea.compareTo(aArea);
            });
          }
        }
        break;
      default:
    }
    setState(() {});
  }

  void updateRegions() async {
    int newHouseCount = 0;
    List<HouseModel> data = await Hpip.fetchPackages(cellName, 1);
    for (var element in data) {
      int result = await DbHelper.instance.houseTable.insertHouseModel(element);
      if (result != 0) {
        newHouseCount++;
      }
    }

    if (newHouseCount > 1) {
      houses.clear();
      buildingModels = await DbHelper.instance.houseTable.queryBuildingsByRegion(buildingName);
      houses = await DbHelper.instance.houseTable.queryByBuildName(cellName);
      setState(() {});
    }

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: Text('提示', style: TextStyle(color: AppColors.goodColor)),
            content: newHouseCount > 1
                ? Text(
                    '更新成功,新增${newHouseCount}套房源！',
                    style: TextStyle(color: AppColors.goodColor),
                  )
                : Text(
                    '暂无房源更新！',
                    style: TextStyle(
                      color: AppColors.goodColor,
                    ),
                  )));
  }
}
