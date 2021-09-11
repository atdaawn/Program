import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'dart:convert';

import 'data/ApiResponse.dart';





// 시작
void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}



// _MyAppState
class _MyAppState extends State<MyApp> {
  String _scanBarcode = 'Unknown';

  @override
  void initState() {
    super.initState();
  }

  // scanBarcodeNormal (Function)
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  // Widget build
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: const Text('Barcode scan')),
            body: Builder(builder: (BuildContext context) {
              return Container(
                  alignment: Alignment.center,
                  child: Flex(
                      direction: Axis.vertical,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ElevatedButton(
                            onPressed: () => scanBarcodeNormal(),
                            child: Text('Start barcode scan')),
                        Text('Scan result : $_scanBarcode\n',
                            style: TextStyle(fontSize: 20))
                      ]));
            })));
  }
}




// Class MyHomePage
class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  var barcode='_scanBarcode'; //++++바코드 입력받음!

  @override
  _MyHomePageState createState() => _MyHomePageState(barcode);
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  //Image image1;
  String authkey ='33bdb62172294843a400';
  String authkey2 = 'Gj5JY2TDy07OsBlp%2F49dXG87xxg5MVf221%2FuJnysOWMhbqS5V9LELnodfK025BwqZpSMM2rtG%2BT2UrGBJDgoog%3D%3D';
  // 너무 길이서 변수로 나눔.
  //var jsonString1='{"C005":{"RESULT":{"MSG":"정상처리되었습니다.","CODE":"INFO-000"},';
  //var jsonString2='"total_count":"100797","row":[{"BAR_CD":"123","PRDLST_NM":"123","PRDLST_REPORT_NO":"123"},';
  //var jsonString3='{"BAR_CD":"111","PRDLST_NM":"111","PRDLST_REPORT_NO":"111"}]}}';
  //var jsonString;

  void getFoodNum(String barcd)async {
    var jsonUrl = "http://openapi.foodsafetykorea.go.kr/api/$authkey/C005/json/1/5" +
        '/BAR_CD=$barcd';
    var response = await http.get(Uri.parse(jsonUrl));
    var result=BarcodeApiResponse.fromJson(jsonDecode(response.body));
    //print(result.c005.result.message);
    //print(result.c005.row[0].name);
    //String keynum = result.c005.row[0].foodnum;
    var jsonUrl2 = "http://apis.data.go.kr/B553748/CertImgListService/getCertImgListService?serviceKey=$authkey2"+"&returnType=json&prdlstReportNo="+result.c005.row[0].foodnum;
    var response2 = await http.get(Uri.parse(jsonUrl2));
    var result2 = BarcodeApiResponse2.fromJson(jsonDecode(response2.body));
    print(result2.list[0].nutrient);
    print(result2.list[0].rawmtrl);
    print(result2.list[0].img);
    print(result2.list[0].capacity);
    print(result2.list[0].allergy);
    String rawmtrl = result2.list[0].rawmtrl;
    String nonvegan = "코치닐, 카민, 젤라틴, 인산골, 이노신산나트륨, 밀랍, 셸락, 염산 엘시스테인, 메소이노시톨 칼슘, 헥사포스페이트, 경유, 경랍, 젖, 카세인, 젖산염, 젖산, 락토오스, 유청, 꿀, 벌, 봉독, 밀랍, 로열젤리, 케라틴, 태반, 연골, 엘라스틴, 동물성, 용연향, 자개, 캐비어, 키틴, 산호, 생선 비늘, 어분, 부레풀, 동물유, 천연 해면, 진주, 생선 알, 바다표범, 조개류, 육류, 경유, 고기, 알란토인, 양수, 동물, 생선, 카민산, 장선, 섀미, 코치닐, 달팽이, 곤충, 휘발보유제, 호르몬, 상아, 라놀린, 밍크, 양피지, 태반, 비단, 뱀, D3, 요소, 송아지, 수지, 아미노산, 육즙 젤리, 뼈, 골탄, 골분, 돼지, 콜라겐, 솜털, 선지, 지방산부산물, 글리세, 올레, 올레오스테아린, 펩신, 레닛, 가죽, 스테아르산염, 스테아르산, 스테아린, 하이드록시아파타이트, 철분, 카트리닌, 엘시스테인, 글루타, 글리세리드, 이노신산, 락티톨";
    var NonV = nonvegan.split(', ');
    //print(NonV);
    print(NonV.length);
    for(int i = 0; i < NonV.length;i++){
      //print(NonV[i]);
      print(rawmtrl.contains(NonV[i]));
      String observe = NonV[i];
      if(rawmtrl.contains(NonV[i]) == true){
        print("Nonvegan");
        break;
      }
    }
  }_MyHomePageState(String barcode){
    //jsonString='$jsonString1$jsonString2$jsonString3';
    getFoodNum(barcode);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}