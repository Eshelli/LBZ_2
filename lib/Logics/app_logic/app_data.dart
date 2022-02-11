import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:libozzle/Screens/categories/model/categories_model.dart';
import 'package:libozzle/models/cat.dart';
import 'package:libozzle/models/cities.dart';
import 'package:libozzle/models/countries.dart';
import 'package:libozzle/models/login_status.dart';
import 'package:libozzle/models/ad_details.dart';
import 'package:libozzle/models/ads_list.dart';
import 'package:libozzle/models/attributes.dart';
import 'package:libozzle/models/cat_parent.dart';
import 'package:libozzle/models/package.dart';
import 'package:libozzle/models/popular_ads.dart';
import 'package:libozzle/models/section_model.dart';

class AppData{
  var counter =0.obs;
  List<Sections> section = [];
  List<Countries> countries = [];
  List<Cities> cities = [];
  List<Attribute> attributes = [];
  List<Cat> categoryChildren = [];
  List<Cat> categoryChildren2 = [];
  List<Pop> pop = [];
  late CategoryParent categoryParent;
  late Section sectionCat;
  List<Ads_List> adsList = [];
  List<DataList> adsListData = [];
  List<NewPackage> listPackages = [];
  late AdDetails adsDetails;
  late LoginStatus loginState;
  var noConnection = false.obs;
  var connectionIsLoading = false.obs;
  var balance = 0.00.obs;
  var isLoading = false.obs;

  var popIsLoading = false.obs;
  var adsIsLoading = false.obs;
  var categoryIsLoading = false.obs;
  var adsDetailsLoading = false.obs;
}