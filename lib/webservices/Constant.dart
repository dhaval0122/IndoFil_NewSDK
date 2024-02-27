class Constant {
  /*
  * DEV URL
  * */
  // static String BASE_URL = 'http://172.16.8.198/eCubix_Printing_Services/';
  // static String BASE_URL = 'http://172.16.8.198/eCubix_Printing_Services/';
  // static String BASE_URL = 'http://172.16.8.198/eCubix_Printing_ServicesCore/';
  // static String BASE_URL = "http://172.16.8.228/eCubix_Printing_Services/";
  // static String BASE_URL = "http://172.16.8.153/eCubix_Printing_Services/";
  // static String BASE_URL = 'http://172.16.10.70/eCubix_Printing_Services/';
  // static String SERVER = 'DEV';

  /*
  * IQA URL
  * */
  // static String BASE_URL =
  //     'https://vcsiqa.ecubix.com/eCubix_Live_Services_IQA/';
  //  static String BASE_URL = 'https://vcsiqa.ecubix.com/eCubix_Local_Services_IQA_Core/';
  //http://10.168.16.87/eCubix_Live_Services_IQA
  //https://demotnt.ecubix.com:8448/eCubix_Live_Services_IQA/api/FarmerServices
  //  static String BASE_URL = 'http://10.168.16.87/eCubix_Live_Services_IQA/';
   static String BASE_URL = 'https://demotnt.ecubix.com:8448/eCubix_Live_Services_IQA/';
   static String SERVER = 'IQA';
   static String IS_DEMO_APP = 'Y';

  //https://cqa-indofil.ecubix.com/eCubix_Live_Services_CQA_Core/api/FarmerServices

  /*
  * CQA URL
  *
  * CHECK SCAN CLASS
  * */
  // static String BASE_URL =
  // //     'https://cqa-indofil.ecubix.com/Indofil_Printing_Services/';
  //     'https://cqa-indofil.ecubix.com/eCubix_Live_Services_CQA_Core/';
  // static String SERVER = 'CQA';

  /*
  * LIVE URL
  *
  * CHECK SCAN CLASS
  * */
  // static String BASE_URL =
  //    "https://indofil.ecubix.com/Indofil_Printing_Services/";
  // static String SERVER = "LIVE";

  static final int connectionTimeOut = 60000;
  static final int receiveTimeout = 60000;
  static final String CheckVersion = 'api/FarmerServices/CheckVersion';
  static final String FarmerRegistration =
      'api/FarmerServices/FarmerRegistration';
  static final String MobileOREmailVerify =
      'api/FarmerServices/MobileOREmailVerify';

  static final String Farmer_Scanning = 'api/FarmerServices/Farmer_Scanning';

  static final String action_Registration = 'Registration';
  static var Action_Scanning = 'Scanning';
  static var Action_GetProductInfoLink = 'GetProductInfoLink';
  static var Action_Check2FA = 'Check2FA';
  static var Action_OTPGenerate = 'OTPGenerate';
  static var Action_VerifyOTP = 'VerifyOTP';

  /* Common For all api */
  // static final String subModule_android =
  //     "eCubix_SKU_Printing_HHT_FLUTTER_ANDROID";
  static final String subModule_android =
      'eCubix_SKU_Printing_Farmer_FLUTTER_ANDROID';
  static final String subModule_iOS = 'eCubix_SKU_Printing_Farmer_FLUTTER_IOS';
  static final String Action = 'Action';
  static final String SubModuleName = 'SubmoduleName';
  static final String DeviceId = 'DeviceId';
  static final String Version = 'Version';
  static final String APIToken = 'APIToken';

  /*Prefres Name */

  static final String USER_DATA = 'user_data';
  static final String MENU_MST = 'menu_mst';
  static final String RIGHT_MENU = 'right_menu_mst';
  static final String MAIN_MENU = 'main_menu_mst';
  static final String USER_PASSWORD = 'user_pwd';
  static final String SYNC_MSG = 'sync_msg';
  static final String product_List = 'product_list';
  static final String dispatch_List = 'dispatch_list';
  static final String LATTITUDE = 'latitude';
  static final String LONGITUDE = 'longitude';

  static var CID = 'IND'; // INDIA

  static final String getRetailersForFarmer = 'getRetailersForFarmer';
  static final String CheckOnlineFarmer = 'CheckOnlineFarmer';
  static final String updateLangCode = 'updateLangCode';
  static final String getFarmerSetLocation = 'getFarmerSetLocation';
  static final String profile_farmer = 'getProfileInfo';
  static final String update_profile_farmer = 'updateProfileInfo';
  static final String getSuggestedRetailers = 'getSuggestedRetailers';

  static String alarmAudioPath = 'beep_sound.mp3';

  static bool locationPermission = true;

}
