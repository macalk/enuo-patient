//
//  BaiduMapViewController.m
//  enuo4
//
//  Created by apple on 16/3/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BaiduMapViewController.h"
#import "Macros.h"
#import "UIColor+Extend.h"
#import "BaiduModel.h"
#import <AFNetworking.h>
#import <Masonry.h>
#import "HosViewController.h"
#import "hosHomePageVC.h"
#import <UIImageView+WebCache.h>

#define kkk self.textView.bounds.size.height/5
@interface BaiduMapViewController ()<UISearchBarDelegate>
@property (nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic,strong)UIView *textView;
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UILabel *addresssLabel;
@property (nonatomic,strong)UILabel *phoneLabel;
@property (nonatomic,strong)UILabel *phoneTextLabel;
@property (nonatomic,strong)UILabel *illlabel;
@property (nonatomic,strong)UILabel *illTextLabel;
@property (nonatomic,strong)BaiduModel *model;
@property (nonatomic,strong)UILabel *addressLabel;
@property (nonatomic,copy)NSString * strProvince;
@property (nonatomic,copy)NSString * strCity;
@property (nonatomic,copy)NSString * strDistrict;
@property (nonatomic,strong)UIView * aView;
@property (nonatomic,strong)UIWindow *window;

@property (nonatomic,strong)UIImageView *bView;

@property (nonatomic,strong)UIImageView *rightItemImageView;


@property (nonatomic,assign)BOOL location;


@property (nonatomic,strong)UIImageView *photoImage;
@property (nonatomic,copy)NSString *hosid;
@end

BMKCircle* circle;
BMKPolygon* polygon;
BMKPolygon* polygon2;
BMKPolyline* polyline;
BMKPolyline* colorfulPolyline;
BMKArcline* arcline;
BMKGroundOverlay* ground2;
BMKPointAnnotation* pointAnnotation;
BMKPointAnnotation* animatedAnnotation;
BMKUserLocation *userlaction;
BMKCoordinateRegion region;

@implementation BaiduMapViewController

- (UIImageView *)bView{
    if (!_bView) {
        self.bView = [[UIImageView alloc]init];
    }return _bView;
}

- (UIImageView *)photoImage{
    if (!_photoImage) {
        self.photoImage = [[UIImageView alloc]init];
    }return _photoImage;
}

- (UILabel *)addressLabel{
    if (!_addressLabel) {
        self.addressLabel = [[UILabel alloc]init];
    }return _addressLabel;
}

- (UILabel *)addresssLabel{
    if (!_addresssLabel) {
        self.addresssLabel = [[UILabel alloc]init];
    }return _addresssLabel;
}

- (UILabel *)phoneLabel{
    if (!_phoneLabel) {
        self.phoneLabel = [[UILabel alloc]init];
    }return _phoneLabel;
}

- (UILabel *)phoneTextLabel{
    if (!_phoneTextLabel) {
        self.phoneTextLabel = [[UILabel alloc]init];
    }return _phoneTextLabel;
}
- (UILabel *)illlabel{
    if (!_illlabel) {
        self.illlabel = [[UILabel alloc]init];
    }return _illlabel;
}

- (UILabel *)illTextLabel{
    if (!_illTextLabel) {
        self.illTextLabel = [[UILabel alloc]init];
    }return _illTextLabel;
}



- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        self.dataArr = [NSMutableArray array];
        
    }return _dataArr;
}

-(UIView *)textView{
    if (!_textView) {
        self.textView = [[UIView alloc]init];
        
    }return _textView;
}
- (UILabel *)nameLabel{
    if (!_nameLabel) {
        self.nameLabel = [[UILabel alloc]init];
    }return _nameLabel;
}

- (void)customNavView {
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"白色返回"] style:UIBarButtonItemStyleDone target:self action:@selector(handleBack:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    [titleLable setTextAlignment:NSTextAlignmentCenter];
    [titleLable setTextColor:[UIColor whiteColor]];
    [titleLable setText:@"周边医院"];
    titleLable.font = [UIFont boldSystemFontOfSize:18];
    self.navigationItem.titleView = titleLable;
    
    UIView *rightItemView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 64, 22)];
    UIImageView *rightItemImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"定位"]];
    self.rightItemImageView = rightItemImageView;
    rightItemImageView.frame = CGRectMake(0,5, 13, 13);
    UILabel *rightItemLabel = [[UILabel alloc]initWithFrame:CGRectMake(15,5 , 50, 11)];
    rightItemLabel.text = @"我的位置";
    rightItemLabel.font = [UIFont systemFontOfSize:11];
    rightItemLabel.textColor = [UIColor whiteColor];
    [rightItemView addSubview:rightItemLabel];
    [rightItemView addSubview:rightItemImageView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightItemView];
    UITapGestureRecognizer *gerture = [[UITapGestureRecognizer alloc]init];
    [gerture addTarget:self action:@selector(rightItemViewClick)];
    [rightItemView addGestureRecognizer:gerture];

    
    self.navigationController.navigationBar.barTintColor = [UIColor stringTOColor:@"#22ccc6"];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self customNavView];

    _geocodesearch = [[BMKGeoCodeSearch alloc]init];
    
    self.navigationController.navigationBar.translucent = NO;
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8) {
        //由于IOS8中定位的授权机制改变 需要进行手动授权
        CLLocationManager  *locationManager = [[CLLocationManager alloc] init];
        //获取授权认证
        [locationManager requestAlwaysAuthorization];
        [locationManager requestWhenInUseAuthorization];
    }
    self.view.backgroundColor = [UIColor whiteColor];
    BMKMapStatus *mapStatus = [[BMKMapStatus alloc] init];
    // 设置缩放级别
    mapStatus.fLevel = 12;
    _mapView  = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeigth)];
    _mapView.userTrackingMode = BMKUserTrackingModeFollow;//设置定位的状态
   _mapView.showsUserLocation = YES;//显示定位图层

    [self.view addSubview:_mapView];
   _locService = [[BMKLocationService alloc]init];
    _mapView.showMapScaleBar = true;
    _mapView.mapScaleBarPosition = CGPointMake(5 ,10);
    _mapView.scrollEnabled = true; // 地图随手指移动
      [_locService startUserLocationService];
   // [stopBtn setEnabled:NO];
    [stopBtn setAlpha:0.6];
    BMKLocationViewDisplayParam* testParam = [[BMKLocationViewDisplayParam alloc] init];
//    testParam.isRotateAngleValid = true;// 跟随态旋转角度是否生效
    testParam.isAccuracyCircleShow = false;// 精度圈是否显示
//    testParam.locationViewImgName = @"icon_compass";// 定位图标名称
//    testParam.locationViewOffsetX = 0;//定位图标偏移量(经度)
//    testParam.locationViewOffsetY = 0;// 定位图标偏移量(纬度)
    [_mapView updateLocationViewWithParam:testParam]; //调用此方法后自定义定位图层生效
//    
       region.span.latitudeDelta  =0.05;
        region.span.longitudeDelta = 0.05;
    _mapView.region = region;
    _mapView.centerCoordinate = userlaction.location.coordinate;
   
    [self requestData];
    
//    [self creatAddareeLabel];
    
    //搜索
//    [self handleSearchBarItem];
    
}


- (void)handleSearchBarItem{
    
    UIView *searckView = [[UIView alloc]initWithFrame:CGRectMake(20, 40, kScreenWidth-40, 44)];
    
    searckView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:searckView];
    
    UIButton *moreBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [moreBtn setTitle:@"全部" forState:normal];
    moreBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [moreBtn setTitleColor:[UIColor blackColor] forState:normal];
    [searckView addSubview:moreBtn];
    
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(100, 6, searckView.bounds.size.width-100, 30)];
    [searchBar setImage:[UIImage imageNamed:@""] forSearchBarIcon:UISearchBarIconSearch state:normal];
    searchBar.placeholder = @"搜索医院";
    searchBar.delegate = self;
    
    //移除searchbar的灰色背景  只留下textfield样式（需要iOS8.0以上版本 以下需要判断）
    for(int i =  0 ;i < searchBar.subviews.count;i++){
        
        UIView * backView = searchBar.subviews[i];
        
        if ([backView isKindOfClass:NSClassFromString(@"UISearchBarBackground")] == YES) {
            
            [backView removeFromSuperview];
            [searchBar setBackgroundColor:[UIColor clearColor]];
            break;
            
        }else{
            
            NSArray * arr = searchBar.subviews[i].subviews;
            
            for(int j = 0;j<arr.count;j++   ){
                
                UIView * barView = arr[i];
                
                if ([barView isKindOfClass:NSClassFromString(@"UISearchBarBackground")] == YES) {
                    
                    [barView removeFromSuperview];
                    [searchBar setBackgroundColor:[UIColor clearColor]];
                    break;
                    
                }
                
            }
            
        }
        
    }
    
    searchBar.keyboardType = UIKeyboardTypeDefault;
    
    [searckView addSubview:searchBar];
    

}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"1111");
}

- (void)handleBack:(UIBarButtonItem *)sender{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)rightItemViewClick {
    self.location = !self.location;
    
    if(self.location){
        self.rightItemImageView.image = [UIImage imageNamed:@"蓝定位"];
        _mapView.showsUserLocation = NO;//先关闭显示的定位图层
        _mapView.userTrackingMode = BMKUserTrackingModeFollow;//设置定位的状态
        _mapView.showsUserLocation = YES;
        //记得昨晚操作之后，改变按钮的点击状态
        _mapView.scrollEnabled = false; // 地图随手指移动
        
    }else{
        self.rightItemImageView.image = [UIImage imageNamed:@"定位"];
        _mapView.scrollEnabled = true; // 地图随手指移动
    }

}

- (void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view;
{
    NSLog(@"paopaoclick"); }

- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view{
  
    if ([view.annotation.title isEqualToString:@"我的位置"]) {
        
    }else{
    
    
    self.textView = [[UIView alloc]initWithFrame:CGRectMake(0 ,kScreenHeigth/3*2-10, kScreenWidth, (kScreenHeigth - 64)/3)];

   
    for (BaiduModel *model in self.dataArr) {
        if ([view.annotation.title isEqualToString:model.hos_name]) {
            self.addresssLabel.text = model.address;
            self.illTextLabel.text = model.ill;
            self.phoneTextLabel.text = model.phone;
            self.nameLabel.text = model.hos_name;
            self.hosid = model.cid;
            NSString *str = [NSString stringWithFormat:urlPicture,model.photo];
            [self.photoImage sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:nil];
        }
    }
    
    
//        self.bView.alpha = 1;
//        self.bView.backgroundColor = [UIColor clearColor];
        self.photoImage.userInteractionEnabled = YES;
        self.bView.image = [UIImage imageNamed:@"黑半透明"];
        [self.view addSubview:self.textView];

    [self.bView addSubview:self.illTextLabel];
   // [self.textView addSubview:self.phoneLabel];
    [self.bView addSubview:self.addresssLabel];
   // [self.textView addSubview:self.phoneTextLabel];
    [self.bView addSubview:self.nameLabel];
    [self.textView addSubview:self.photoImage];
    [self.photoImage addSubview:self.bView];
        __weak typeof (self) weakSelf = self;
        self.addresssLabel.font  = [UIFont systemFontOfSize:11.0];
        self.illTextLabel.font = [UIFont systemFontOfSize:11.0];
        self.nameLabel.textColor = [UIColor orangeColor];
        self.addresssLabel.textColor = [UIColor whiteColor];
        self.illTextLabel.textColor = [UIColor whiteColor];
        
        [self.photoImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo (weakSelf.textView);
            make.centerX.equalTo (weakSelf.textView);
            make.width.mas_equalTo(kScreenWidth-10);
            make.height.mas_equalTo((kScreenHeigth-64)/3 - 10);
        }];
        
        [weakSelf.bView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo((kScreenHeigth)/6 - 5);
            make.left.equalTo(weakSelf.photoImage.mas_left);
            make.right.equalTo (weakSelf.photoImage.mas_right);
            make.bottom.equalTo (weakSelf.photoImage.mas_bottom);
        }];
        
        [weakSelf.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.bView.mas_left);
            make.right.equalTo(weakSelf.bView.mas_right);
            make.top.equalTo(weakSelf.bView.mas_top);
            make.height.mas_equalTo(@25);
            
            
        }];
        
        [weakSelf.addresssLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.bView.mas_left);
            make.right.equalTo (weakSelf.bView.mas_right);
            make.top.equalTo(weakSelf.nameLabel.mas_bottom);
            make.height.mas_equalTo(@15);
            
        }];
        
        [weakSelf.illTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.bView.mas_left);
            make.right.equalTo (weakSelf.bView.mas_right);
            make.top.equalTo(weakSelf.addresssLabel.mas_bottom);
            make.height.mas_equalTo(@15);
        
        }];
        
        self.textView.backgroundColor = [UIColor blackColor];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapGesture:)];
        //  1）设置轻拍次数  单击  双击  三连击。。。。。
        tapGesture.numberOfTapsRequired = 1;//单击
        //  2）设置触摸手指的个数
        tapGesture.numberOfTouchesRequired = 1;//触摸手指的个数
        //  3） 将轻拍手势添加到相应的视图上（也就是说将手势添加到视图上，那么点击该视图，就应该响应轻拍手势响应的事件）
        [self.textView addGestureRecognizer:tapGesture];
    
        
    }
}
- (void)mapView:(BMKMapView *)mapView didDeselectAnnotationView:(BMKAnnotationView *)view{
    [self.textView removeFromSuperview];
}


- (void)stopButton{
//    [_locService stopUserLocationService];
//    _mapView.showsUserLocation = NO;
//    [stopBtn setEnabled:NO];
//    [stopBtn setAlpha:0.6];
//    [starBtn setEnabled:YES];
//    [starBtn setAlpha:1.0];
//

}
/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    
    [_mapView updateLocationData:userLocation];
   // NSLog(@"heading is %@",userLocation.heading);
}


-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _locService.delegate = self;
    _geocodesearch.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放

}

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _locService.delegate = nil;
      _geocodesearch.delegate = nil; // 不用时，置nil
    [_aView removeFromSuperview];
}
- (void)dealloc {
    if (_aView) {
        [_aView removeFromSuperview];
    }
    if (_geocodesearch != nil) {
        _geocodesearch = nil;
    }
    if (_mapView) {
        _mapView = nil;
    }
    if (_locService != nil) {
        _locService = nil;
    }
}
/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    BMKCoordinateRegion region;
    region.center.latitude  = userLocation.location.coordinate.latitude;
    region.center.longitude = userLocation.location.coordinate.longitude;
//    region.span.latitudeDelta  =0.05;
//    region.span.longitudeDelta = 0.05;
    if (_mapView)
    {   //反地理编码出地理位置
        
        
        NSLog(@"_geocodesearch = %@",_geocodesearch);
        
          //  BMKGeoCodeSearch *_geocodesearch = [[BMKGeoCodeSearch alloc]init];
        BMKReverseGeoCodeOption *pt = [[BMKReverseGeoCodeOption alloc]init];
       pt.reverseGeoPoint =(CLLocationCoordinate2D){0,0};
        pt.reverseGeoPoint =(CLLocationCoordinate2D){userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude};
        
        BOOL flag=[_geocodesearch reverseGeoCode:pt];
       
        if (flag) {
            // _mapView.showsUserLocation=NO;//不显示自己的位置
            //self.btnDone.enabled=YES;
            NSLog(@"好累好累");
        }
        
       // _mapView.region = region;
        NSLog(@"当前的坐标是: %f,%f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    }
}

- (void)requestData{
 //  char utf8Str = "杭州市";
     NSString *url = @"http://www.enuo120.com/index.php/app/hospital/map";
    
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
   [manger POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
       
   } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       [self handleWithData:responseObject];
       //NSLog(@"responseObject = %@",responseObject);
   } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
   }];
    
}
- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    NSLog(@"result = %@",result);
}
//反地理编码
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
        if (error==0) {
    
            BMKPointAnnotation *item=[[BMKPointAnnotation alloc] init];
            item.coordinate=result.location;//地理坐标
            item.title=result.address;//地理名称
            //[_mapView addAnnotation:item];
           // _mapView.centerCoordinate=result.location;
            self.addressLabel.text = result.address;
          
            
            self.addressLabel.text =[result.address stringByReplacingOccurrencesOfString:@"-" withString:@""];
            if (![self.addressLabel.text isEqualToString:@""]) {
                _strProvince=result.addressDetail.province;//省份
                _strCity=result.addressDetail.city;//城市
                _strDistrict=result.addressDetail.district;//地区
            }
        }
}


//-(void)onGetAddrResult:(BMKAddrInfo *)result errorCode:(int)error{
//    if (error==0) {
//        BMKPointAnnotation *item=[[BMKPointAnnotation alloc] init];
//        item.coordinate=result.geoPt;//地理坐标
//        item.title=result.strAddr;//地理名称
//        [myMapView addAnnotation:item];
//        myMapView.centerCoordinate=result.geoPt;
//        
//        self.lalAddress.text=[result.strAddr stringByReplacingOccurrencesOfString:@"-" withString:@""];
//        if (![self.lalAddress.text isEqualToString:@""]) {
//            strProvince=result.addressComponent.province;//省份
//            strCity=result.addressComponent.city;//城市
//            strDistrict=result.addressComponent.district;//地区
//        }
//    }
//}
//顺便添加标注！
- (void)handleWithData:(NSDictionary *)data{
    NSArray *arr = data[@"data"];
    for (NSDictionary *temp in arr) {
       self.model = [BaiduModel baiDuModelWithDic:temp];
       
            pointAnnotation = [[BMKPointAnnotation alloc]init];
            CLLocationCoordinate2D coor;
            coor.latitude = [_model.lat doubleValue];
            coor.longitude = [_model.lng doubleValue];
            pointAnnotation.coordinate = coor;
            pointAnnotation.title = _model.hos_name;
            pointAnnotation.subtitle = _model.address;
        
        
        NSString *str = [NSString stringWithFormat:urlPicture,_model.photo];
        [self.photoImage sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:nil];
        
        
        
        self.nameLabel.text = pointAnnotation.title;
        self.illlabel.text = @"约定疾病:";
        self.phoneLabel.text =@"电话:";
        self.phoneTextLabel.text = _model.phone;
        self.illTextLabel.text = _model.ill;
        self.addresssLabel.text = _model.address;
        //self.hosid = _model.cid;
            [_mapView addAnnotation:pointAnnotation];
        
        [self.dataArr addObject:_model];
       // NSLog(@"model = %@",_model);
    }
}
- (void)handleTapGesture:(UITapGestureRecognizer *)sender{
    
    hosHomePageVC *hosVC = [[hosHomePageVC alloc]init];
    hosVC.receiver = self.hosid;
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:hosVC];
    [self presentViewController:nav animated:YES completion:nil];
    
    NSLog(@"点击跳转啦啦啦啦啦啦啦");
    
}

- (void)viewDidGetLocatingUser:(CLLocationCoordinate2D)userLoc{
   // NSLog(@"userLoc = %@",userLoc);
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
