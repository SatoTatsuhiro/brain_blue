//
//  MapViewController.h
//  Axiz Brain Blue
//
//  Created by 左藤樹洋 on 2014/06/18.
//  Copyright (c) 2014年 Tatsuhiro Sato. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@interface MapViewController : UIViewController
@property double latitude;  //緯度
@property double longitude; //経度

@property (strong, nonatomic) IBOutlet UITextField *AdressStrTextField;
@property (nonatomic, retain) CLLocationManager *locationManager;

-(void) onResume;
-(void) onPause;



@end
