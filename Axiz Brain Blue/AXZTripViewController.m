#import "AXZTripViewController.h"
#import "UIView+AXZUI.h"
#import "UILabel+AXZUI.h"
#import <CoreLocation/CoreLocation.h>

@interface AXZTripViewController ()<CLLocationManagerDelegate>

@property (strong, nonatomic)CLLocationManager* locationManager;
@property int totalDistance;
@property int totalMileDistance;

@property (strong, nonatomic) IBOutlet UILabel *tripLabel1;
@property (strong, nonatomic) IBOutlet UILabel *tripLabel2;
@property (strong, nonatomic) IBOutlet UILabel *tripLabel3;
@property (strong, nonatomic) IBOutlet UILabel *tripLabel4;
@property (strong, nonatomic) IBOutlet UILabel *tripLabel5;
@property (strong, nonatomic) IBOutlet UILabel *tripLabel6;

@property (nonatomic) IBOutlet UIButton *setButton;
@property (nonatomic) IBOutlet UIButton *resetButton;
@property (nonatomic) IBOutlet UIButton *typeChangeButton;
@property (nonatomic) NSInteger typeFlag;
@property (nonatomic) BOOL isTripWorking;

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
    self.isTripWorking = false;
    
    [self prepareView];
    [self prepareLabels];
}

- (void)prepareView
{
    self.setButton.translatesAutoresizingMaskIntoConstraints = YES;
    self.setButton.frame = [UIView tripSetButtonRect];
    
    self.resetButton.translatesAutoresizingMaskIntoConstraints = YES;
    self.resetButton.frame = [UIView tripResetButtonRect];
    
    self.typeChangeButton.translatesAutoresizingMaskIntoConstraints = YES;
    self.typeChangeButton.frame = [UIView tripTypeChangeButtonRect];
}

- (void)prepareLabels
{
    CGRect labelRect = [UIView tripLabelRect];
    CGFloat x = labelRect.origin.x;
    CGFloat y = labelRect.origin.y;
    CGFloat height = labelRect.size.height;
    CGFloat width = labelRect.size.width;
    CGFloat diffLabelX = [UIView tripDiffLabelPointX];
    
    self.tripLabel1.translatesAutoresizingMaskIntoConstraints = YES;
    self.tripLabel1.frame = labelRect;
    self.tripLabel1.font = [UILabel tripViewLabelFont];
    
    self.tripLabel2.translatesAutoresizingMaskIntoConstraints = YES;
    self.tripLabel2.frame = CGRectMake(x + diffLabelX, y, width, height);
    self.tripLabel2.font = [UILabel tripViewLabelFont];
    
    self.tripLabel3.translatesAutoresizingMaskIntoConstraints = YES;
    self.tripLabel3.frame = CGRectMake(x + diffLabelX * 2, y, width, height);
    self.tripLabel3.font = [UILabel tripViewLabelFont];
    
    self.tripLabel4.translatesAutoresizingMaskIntoConstraints = YES;
    self.tripLabel4.frame = CGRectMake(x + diffLabelX * 3, y, width, height);
    self.tripLabel4.font = [UILabel tripViewLabelFont];
    
    self.tripLabel5.translatesAutoresizingMaskIntoConstraints = YES;
    self.tripLabel5.frame = CGRectMake(x + diffLabelX * 4, y, width, height);
    self.tripLabel5.font = [UILabel tripViewLabelFont];
    
    self.tripLabel6.translatesAutoresizingMaskIntoConstraints = YES;
    self.tripLabel6.frame = CGRectMake(x + diffLabelX * 5, y, width, height);
    self.tripLabel6.font = [UILabel tripViewLabelFont];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {

    if(oldLocation != nil)
    {
        if (self.isTripWorking) {
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
        [self.typeChangeButton setImage:[UIImage imageNamed:@"button_mph"] forState:UIControlStateNormal];
        [self.typeChangeButton setImage:[UIImage imageNamed:@"trip_button_mph_hover"] forState:UIControlStateHighlighted];
        self.typeFlag = 2;
    } else if (self.typeFlag == 2) {
        [self.typeChangeButton setImage:[UIImage imageNamed:@"button_km"] forState:UIControlStateNormal];
        [self.typeChangeButton setImage:[UIImage imageNamed:@"trip_button_km_hover"] forState:UIControlStateHighlighted];
        self.typeFlag = 1;
    }
}

- (IBAction)setButtonAction:(id)sender
{
    if (self.isTripWorking) {
        [self.setButton setImage:[UIImage imageNamed:@"button_set"] forState:UIControlStateNormal];
        [self.setButton setImage:[UIImage imageNamed:@"trip_button_set_hover"] forState:UIControlStateHighlighted];
        self.isTripWorking = false;
    } else {
        [self.setButton setImage:[UIImage imageNamed:@"button_running"] forState:UIControlStateNormal];
        [self.setButton setImage:[UIImage imageNamed:@"trip_button_running_hover"] forState:UIControlStateHighlighted];
        self.isTripWorking = true;
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
