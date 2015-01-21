//应用程序   版本
#define App_version   @"2.2.0"


//活动主页面
#define kActivity @"http://tubu.ibuzhai.com/rest/v1/activity/cats?app_version=1.0.2&device_type=1"
//活动首页图片轮播url
#define kAdvertisement  @"http://tubu.ibuzhai.com/rest/v1/advertisements?app_version=2.2.0&destination=0&device_type=1&objectType=&position=%2C1"
//点击轮播图   进入的活动列表
#define kAdverList  @"http://tubu.ibuzhai.com/rest/v1/advertisement"  //拼接advertisement的id，如23 ，再拼接activities

//点击分类图标进入 活动列表 参数拼接
#define kActivityList @"http://tubu.ibuzhai.com/rest/v1/activities?"

//活动详情  
#define kAcDetail @"http://tubu.ibuzhai.com/rest/v1/activity"




//游记主题展示页面url
#define kTravelLog @"http://tubu.ibuzhai.com/rest/v1/travelog/recommends?app_version=1.0.2&device_type=1"
//游记详细页面url
#define kDetailTL @"http://tubu.ibuzhai.com/rest/v1/travelog/trail/"  //拼接TravelLog的参数 id ,如1185.


#define kAdverList  @"http://tubu.ibuzhai.com/rest/v1/advertisement"  //拼接advertisement的id，如23 ，再拼接activities

#define kAdverDetail  @"http://tubu.ibuzhai.com/rest/v1/advertisement"  //拼接advertisement的id，如23 ，再拼接activities










//*************************************************************路线主页面

#define kAllTrail @"http://tubu.ibuzhai.com/rest/v1/trails?app_version=1.0.2&city=0&crowd=0&device_type=1&page=1&page_size=10&trait=0"
#define kAllTrail_lostPage @"http://tubu.ibuzhai.com/rest/v1/trails?access_token=9c659546-c684-43c0-8f4a-7feeb8ce400f&app_version=2.2.0&city=0&crowd=0&device_type=1&page_size=10&trait=0"
#define kTrailDetail_lostId @"http://tubu.ibuzhai.com/rest/v1/trail/"

//路线专题
#define kTypeTrail @"http://tubu.ibuzhai.com/rest/v1/trail/types"
#define kTypeTrailList @"http://tubu.ibuzhai.com/rest/v1/trail/type"




#pragma mark   通知
#define loginSuccess @"loginSuccess"



#define kTrailSearch @"http://tubu.ibuzhai.com/rest/v1/trails?&page_size=20&area_id=&page=1&device_type=1&app_version=2.2.0&api_version=1&access_token="
