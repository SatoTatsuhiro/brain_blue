#import "AXZTripViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface AXZTripViewController ()<CLLocationManagerDelegate>

@property (strong, nonatomic)CLLocationManager* locationManager;
@property int totalDistance;
@property int totalMileDistance;

@property (nonatomic) IBOutlet UIButton *setButton;
@property (nonatomic) IBOutlet UIButton *resetButton;
@property (nonatomic) IBOutlet UIButton *typeChangeButton;
@property (nonatomic) NSInteger typeFlag;
@property (nonatomic) NSInteger setTypeButtonFlag;

@end

@implementation AXZTripViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.locationManager = [[CLLocationManager alloc] init];

    BOOL locationServicesEnabled;
    locationServicesEnabled = [CLLocationManager locationServicesEnabled];
    
    if (locationServicesEnabled) {
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationManager.distanceFilter = 1;
    }
    
    [self.locationManager startUpdatingLocation];
    self.totalDistance = 0;
    self.typeFlag = 1;
    self.setTypeButtonFlag = 1;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {

    if(oldLocation != nil)
    {
        if (self.setTypeButtonFlag == 2) {
            CLLocationDistance distance = [newLocation distanceFromLocation:oldLocation];
            self.totalDistance = self.totalDistance + distance;
        }
    }
    if (self.typeFlag == 1) {
        
        int totalDistanceToKm = self.totalDistance / 10;
        NSString* distanceStr = [NSString stringWithFormat:@"%06d",totalDistanceToKm];
        
        self.tripLabel1.text = [NSString stringWithFormat:@"%@",[distanceStr substringWithRange:NSMakeRange(5, 1)]];
        self.tripLabel2.text = [NSString stringWithFormat:@"%@",[distanceStr substringWithRange:NSMakeRange(4, 1)]];
        self.tripLabel3.text = [NSString stringWithFormat:@"%@",[distanceStr substringWithRange:NSMakeRange(3, 1)]];
        self.tripLabel4.text = [NSString stringWithFormat:@"%@",[distanceStr substringWithRange:NSMakeRange(2, 1)]];
        self.tripLabel5.text = [NSString stringWithFormat:@"%@",[distanceStr substringWithRange:NSMakeRange(1, 1)]];
        self.tripLabel6.text = [NSString stringWithFormat:@"%@",[distanceStr substringWithRange:NSMakeRange(0, 1)]];
        
    } else if (self.typeFlag == 2) {
        self.totalMileDistance = self.totalDistance /1.6;
        NSString* distanceStr = [NSString stringWithFormat:@"%06d",self.totalMileDistance/10];
        self.tripLabel1.text = [NSString stringWithFormat:@"%@",[distanceStr substringWithRange:NSMakeRange(5, 1)]];
        self.tripLabel2.text = [NSString stringWithFormat:@"%@",[distanceStr substringWithRange:NSMakeRange(4, 1)]];
        self.tripLabel3.text = [NSString stringWithFormat:@"%@",[distanceStr substringWithRange:NSMakeRange(3, 1)]];
        self.tripLabel4.text = [NSString stringWithFormat:@"%@",[distanceStr substringWithRange:NSMakeRange(2, 1)]];
        self.tripLabel5.text = [NSString stringWithFormat:@"%@",[distanceStr substringWithRange:NSMakeRange(1, 1)]];
        self.tripLabel6.text = [NSString stringWithFormat:@"%@",[distanceStr substringWithRange:NSMakeRange(0, 1)]];
    }
}

- (IBAction)resetbutton:(id)sender
{
    self.totalDistance = 0;
}

- (IBAction)typeChangeAction:(id)sender
{
    if (self.typeFlag == 1) {
        [self.typeChangeButton setImage:[UIImage imageNamed:@"trip_button_mph"] forState:UIControlStateNormal];
        [self.typeChangeButton setImage:[UIImage imageNamed:@"trip_button_mph_hover"] forState:UIControlStateHighlighted];
        self.typeFlag = 2;
    } else if (self.typeFlag == 2) {
        [self.typeChangeButton setImage:[UIImage imageNamed:@"trip_button_km"] forState:UIControlStateNormal];
        [self.typeChangeButton setImage:[UIImage imageNamed:@"trip_button_km_hover"] forState:UIControlStateHighlighted];
        self.typeFlag = 1;
    }
}

- (IBAction)setButtonAction:(id)sender
{
    if (self.setTypeButtonFlag == 1) {
        [self.setButton setImage:[UIImage imageNamed:@"trip_button_running"] forState:UIControlStateNormal];
        [self.setButton setImage:[UIImage imageNamed:@"trip_button_running_hover"] forState:UIControlStateHighlighted];
        self.setTypeButtonFlag = 2;
    } else if (self.setTypeButtonFlag == 2) {
        [self.setButton setImage:[UIImage imageNamed:@"trip_button_set"] forState:UIControlStateNormal];
        [self.setButton setImage:[UIImage imageNamed:@"trip_button_set_hover"] forState:UIControlStateHighlighted];
        self.setTypeButtonFlag = 1;
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (IBAction)backToMainViewAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
