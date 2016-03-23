#import "AXZMapViewController.h"
#import "AXZHomeViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "STAnnotation.h"

@interface AXZMapViewController ()<MKMapViewDelegate,UITextFieldDelegate,CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *latLabel;
@property (weak, nonatomic) IBOutlet UILabel *logLabel;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (strong, nonatomic) IBOutlet UITextField *AdressStrTextField;

@property CLLocationCoordinate2D nowLocation;

@end

@implementation AXZMapViewController
@synthesize AdressStrTextField;
@synthesize locationManager;

double lat, lng;

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    self.mapView.mapType = MKMapTypeStandard;
    self.AdressStrTextField.delegate = self;
    [self _prepareLocationManager];
}

- (void)_prepareLocationManager
{
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    [self.locationManager startUpdatingLocation];
    [self.locationManager requestWhenInUseAuthorization];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscapeLeft;
}

//=============================================================
#pragma Action
//=============================================================

- (IBAction)backToMainView:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)targetTextField
{
    [targetTextField resignFirstResponder];
    [self.view endEditing:NO];
    [self geocorde:AdressStrTextField.text];

    return YES;
}

//=============================================================
#pragma Geocorde
//=============================================================

- (void)geocorde:(NSString *)addressString
{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:addressString
                 completionHandler:^(NSArray* placemarks, NSError* error) {
                     for (CLPlacemark* placemark in placemarks) {

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
                              if (error) return;

                              if ([response.routes count] > 0)
                              {
                                  MKRoute *route = [response.routes objectAtIndex:0];
                                  NSLog(@"distance: %.2f meter", route.distance);
                                  
                                  [self.mapView addOverlay:route.polyline];
                              }
                          }];
                     }
                 }];
}

//=============================================================
#pragma LocationManager
//=============================================================

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    MKCoordinateRegion region = MKCoordinateRegionMake([newLocation coordinate], MKCoordinateSpanMake(0.3, 0.3));
    self.nowLocation = CLLocationCoordinate2DMake([newLocation coordinate].latitude, [newLocation coordinate].longitude);
    self.latLabel.text = [NSString stringWithFormat:@"LONGITUDE:%f", newLocation.coordinate.latitude];
    self.logLabel.text = [NSString stringWithFormat:@"LONGITUDE:%f", newLocation.coordinate.longitude];
    [self.mapView setCenterCoordinate:[newLocation coordinate]];
    [self.mapView setRegion:region];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"エラー" message:@"位置情報が取得できませんでした。" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alertView show];
}

-(void)onResume
{
    if (nil == locationManager && [CLLocationManager locationServicesEnabled])
        [locationManager startUpdatingLocation];
}

-(void)onPause
{
    if (nil == locationManager && [CLLocationManager locationServicesEnabled])
        [locationManager stopUpdatingLocation];
}

//=============================================================
#pragma MKOverlayRenderer
//=============================================================

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
    } else {
        return nil;
    }
}

@end
