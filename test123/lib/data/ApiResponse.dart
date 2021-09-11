class ProductInfo{
  final String foodnum;
  final String name;
  ProductInfo(this.foodnum, this.name);
  factory ProductInfo.fromJson(Map<dynamic, dynamic> json){
    return ProductInfo(json['PRDLST_REPORT_NO'], json['PRDLST_NM']);
  }
}

class Result {
  final String code;
  final String message;
  Result(this.code, this.message);
  factory Result.fromJson(Map<dynamic, dynamic> json){
    return Result(json['CODE'], json['MSG']);
  }
}

class C005{
  final Result result;
  final List<ProductInfo> row;
  C005(this.result, this.row);
  factory C005.fromJson(Map<dynamic, dynamic> json){
    var rawList = json['row'] as List;
    List<ProductInfo> rows = rawList.map((i)=>ProductInfo.fromJson(i)).toList();
    return C005(Result.fromJson(json['RESULT']), rows);
  }
}

class BarcodeApiResponse{
  final C005 c005;
  BarcodeApiResponse(this.c005);
  factory BarcodeApiResponse.fromJson(Map<dynamic, dynamic> json){
    return BarcodeApiResponse(C005.fromJson(json['C005']));
  }
}




////////////////////////////////////////////////////////////////////////////////////////////////////////
//두번째 api 연동


/*
class BarcodeApiResponse2{
  final int totalCount;
  final int pageNo;
  final List<Lists> list;
  BarcodeApiResponse2(this.list, this.totalCount, this.pageNo, this.resultCode);
  factory BarcodeApiResponse2.fromJson(Map<dynamic, dynamic> json){
    //return BarcodeApiResponse2(Lists.fromJson(json['totalCount']));
    return BarcodeApiResponse2(json[totalCount],json[pageNo],);
  }
}
class Lists{
  final String nutrient;
  final String rawmtrl;
  final String prdlstNm;
  final String imgurl2;
  final String barcode;
  final String imgurl1;
  final String productGb;
  final String seller;
  final String prdkindstate;
  final String rnum;
  final String manufacture;
  final String prdkind;
  final String capacity;
  final String prdlstReportNo;
  final String allergy;
  Lists(this.nutrient, this.rawmtrl, this.prdlstNm, this.imgurl2, this.barcode, this.imgurl1, this.productGb, this.seller, this.prdkindstate, this.rnum, this.manufacture, this.prdkind, this.capacity, this.prdlstReportNo, this.allergy);
  factory Lists.fromJson(Map<dynamic, dynamic> json){
    var rawList = json['row'] as List;
    List<ProductInfo> rows = rawList.map((i)=>ProductInfo.fromJson(i)).toList();
    return C005(Result.fromJson(json['RESULT']), rows);
  }
}*/

class BarcodeApiResponse2{
  final String totalCount;
  final String pageNo;
  final List<ProductConst> list;
  BarcodeApiResponse2(this.totalCount, this.pageNo, this.list);
  factory BarcodeApiResponse2.fromJson(Map<dynamic, dynamic> json){
    var rawList = json['list'] as List;
    List<ProductConst> productList = rawList.map((i)=>ProductConst.fromJson(i)).toList();
    return BarcodeApiResponse2(json['totalCount'], json['pageNo'], productList);
  }
}
class Lists{
  final List<ProductConst> list;
  Lists(this.list);
  factory Lists.fromJson(Map<dynamic, dynamic> json){
    var constList = json['list'] as List;
    List<ProductConst> lists = constList.map((i)=>ProductConst.fromJson(i)).toList();
    return Lists(lists);
  }
}
class ProductConst{
  final String nutrient;
  final String rawmtrl;
  final String img;
  final String prdkind;
  final String capacity;
  final String allergy;
  ProductConst(this.nutrient, this.rawmtrl, this.img, this.prdkind, this.capacity, this.allergy);
  factory ProductConst.fromJson(Map<dynamic, dynamic> json){
    return ProductConst(json['nutrient'], json['rawmtrl'], json['imgurl1'], json['imgurl1'], json['prdkind'], json['capacity']);
  }
}