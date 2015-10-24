#import "AXZMapViewController.h"
#import "AXZHomeViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "STAnnotation.h"


@interface AXZMapViewController ()<MKMapViewDelegate,UITextFieldDelegate,CLLocationManagerDelegate>
@property MKMapView* mapView;
@property CLLocationCoordinate2D nowLocation;
- (void)geocorde:(NSString *)place;
- (IBAction)backToMainView:(id)sender;

@end


@implementation AXZMapViewController
@synthesize AdressStrTextField;
@synthesize locationManager;

double lat, lng;
int mapFlag = 1;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.mapView = [[MKMapView alloc]init];
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    self.mapView.mapType = MKMapTypeStandard;
    self.mapView.frame = CGRectMake(0, 70, 570, 250);
    self.AdressStrTextField.delegate = self;
    
    locationManager = [[CLLocationManager alloc] init];
    
    if ([CLLocationManager locationServicesEnabled]) {
        locationManager.delegate = self;
        [locationManager startUpdatingLocation];
    } else {
        NSLog(@"Location services not available.");
        

    }
    
    [self performSegueWithIdentifier:@"pushNewsViewCtl" sender:self];
    
    
    
    
    
    UILabel* latLabel = [[UILabel alloc]init];
    latLabel.text = @"LATITUDE:133.22.2222";
    latLabel.font = [UIFont systemFontOfSize:11];
    latLabel.frame = CGRectMake(430,277 ,150 , 30);
    
    UILabel* logLabel = [[UILabel alloc]init];
    logLabel.text = @"LONGITUDE:133.22.2222";
    logLabel.font = [UIFont systemFontOfSize:11];
    logLabel.frame = CGRectMake(418,290 ,150 , 30);
    
    [self.view addSubview:self.mapView];
    [self.view addSubview:latLabel];
    [self.view addSubview:logLabel];
    
   
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UIStatusBarStyle)preferredStatusBarStyle {
    //文字を白くする
    return UIStatusBarStyleLightContent;
}
- (IBAction)backToMainView:(id)sender {

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)targetTextField {
    
    [targetTextField resignFirstResponder];
    [self.view endEditing:NO];
    [self geocorde:AdressStrTextField.text];
    
    return YES;
}

- (void)geocorde:(NSString *)addressString {
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:addressString
                 completionHandler:^(NSArray* placemarks, NSError* error) {
                     // 住所からジオコーディングを行った結果（場所）の数
                        for (CLPlacemark* placemark in placemarks) {
                         // それぞれの結果（場所）の情報
                            NSLog(@"latitude : %f", placemark.location.coordinate.latitude);
                            NSLog(@"longitude : %f", placemark.location.coordinate.longitude);
                            lat = placemark.location.coordinate.latitude;
                            lng = placemark.location.coordinate.longitude;
                            
                            
                            CLLocationCoordinate2D co;
                            co.latitude = placemark.location.coordinate.latitude;
                            co.longitude = placemark.location.coordinate.longitude;
                            
                            
                            STAnnotation* annotation = [[STAnnotation alloc]initWithCoordinate:co];
                            annotation.title = @"GOAL";
                            [self.mapView addAnnotation:annotation];
                            
                            CLLocationCoordinate2D goalCoordinate = CLLocationCoordinate2DMake(co.latitude, co.longitude);
                            
                            
                            
                            
                            
                            MKPlacemark *fromPlacemark =
                            [[MKPlacemark alloc] initWithCoordinate:self.nowLocation
                                                  addressDictionary:nil];
                            MKPlacemark *toPlacemark =
                            [[MKPlacemark alloc] initWithCoordinate:goalCoordinate
                                                  addressDictionary:nil];
                            
                            MKMapItem *fromItem =
                            [[MKMapItem alloc] initWithPlacemark:fromPlacemark];
                            MKMapItem *toItem =
                            [[MKMapItem alloc] initWithPlacemark:toPlacemark];
                            
                            MKDirectionsRequest *request =
                            [[MKDirectionsRequest alloc] init];
                            request.source = fromItem;
                            request.destination = toItem;
                            request.requestsAlternateRoutes = YES;
                            
                            MKDirections *directions =
                            [[MKDirections alloc] initWithRequest:request];
                            
                            [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error)
                             {
                                 
                                 NSLog(@"%@",error);
                                 if (error) return;
                                 
                                 if ([response.routes count] > 0)
                                 {
                                     MKRoute *route = [response.routes objectAtIndex:0];
                                     NSLog(@"distance: %.2f meter", route.distance);
                                     
                                     // 地図上にルートを描画
                                     [self.mapView addOverlay:route.polyline];
                                 }
                             }];
                            
                            
                            
                     }
                 }];
}

- (NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskLandscapeLeft;
}

-(void) onResume {
    if (nil == locationManager && [CLLocationManager locationServicesEnabled])
        [locationManager startUpdatingLocation]; //測位再開
}

-(void) onPause {
    if (nil == locationManager && [CLLocationManager locationServicesEnabled])
        [locationManager stopUpdatingLocation]; //測位停止
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
    NSLog(@"didUpdateToLocation latitude=%f, longitude=%f",
          [newLocation coordinate].latitude,
          [newLocation coordinate].longitude);
    if (mapFlag == 1) {
        MKCoordinateRegion region = MKCoordinateRegionMake([newLocation coordinate], MKCoordinateSpanMake(0.3, 0.3));
        self.nowLocation = CLLocationCoordinate2DMake([newLocation coordinate].latitude, [newLocation coordinate].longitude);
        [self.mapView setCenterCoordinate:[newLocation coordinate]];
        [self.mapView setRegion:region];
        mapFlag = 2;
        NSLog(@"%f",self.nowLocation.latitude);
    }
    
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error{
    NSLog(@"didFailWithError");
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"エラー" message:@"位置情報が取得できませんでした。" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alertView show];

}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView
            rendererForOverlay:(id<MKOverlay>)overlay
{
    if ([overlay isKindOfClass:[MKPolyline class]])
    {
        MKPolyline *route = overlay;
        MKPolylineRenderer *routeRenderer = [[MKPolylineRenderer alloc] initWithPolyline:route];
        routeRenderer.lineWidth = 5.0;
        routeRenderer.strokeColor = [UIColor cyanColor];
        
        return routeRenderer;
    }
    else {
        return nil;
    }
}



@end
