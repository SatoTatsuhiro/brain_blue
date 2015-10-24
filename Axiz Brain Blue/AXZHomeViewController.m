#import "AXZHomeViewController.h"
#import "AXZMeterView.h"
#import "AXZAsset.h"
#import <CoreMotion/CoreMotion.h>
#import <CoreLocation/CoreLocation.h>
#import "AXZWebViewController.h"
#import "AXZSettingViewController.h"
#import "AXZSlopeViewController.h"
#import "AXZBankViewController.h"

#define PAGE_COUNT 5

@interface AXZHomeViewController () <AXZMeterViewDelegate, CLLocationManagerDelegate>

@property (nonatomic) NSMutableArray *meterViews;
@property (nonatomic) UIScrollView *scrollView;

@property (nonatomic) float reviseBank;
@property (nonatomic) float reviseSlope;
@property (nonatomic) CMAttitude *currentAttitude;
@property (nonatomic) CMMotionManager *motionManager;
@property (nonatomic) CLLocationManager *locationManager;

@end

@implementation AXZHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initialize];
    [self startGetAngle];
}

//=============================================================
#pragma initialize
//=============================================================

- (void)initialize
{
    [self _prepareMeterViews];
    
    self.reviseBank = 0;
    self.reviseSlope = 0;
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height * PAGE_COUNT);
    [self.view addSubview:self.scrollView];
    
    [self _prepareLocationManager];

    for (AXZMeterView *meterView in self.meterViews) {
        [self.scrollView addSubview:meterView];
    }
}

- (void)_prepareMeterViews
{
    self.meterViews = [[NSMutableArray alloc] init];
    for (int i = 0; i < PAGE_COUNT; i++) {
        UINib *nib = [UINib nibWithNibName:@"AXZMeterView" bundle:nil];
        AXZMeterView *meterView = [nib instantiateWithOwner:self options:nil][0];
        meterView.delegate = self;
        meterView.index = i;
        meterView.frame = CGRectMake(0, self.view.frame.size.height * i, self.view.frame.size.width, self.view.frame.size.height);
        [meterView index];
        [self.meterViews addObject:meterView];
    }
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

//=============================================================
#pragma Angle
//=============================================================

- (void)startGetAngle
{
    self.motionManager = [[CMMotionManager alloc] init];
    self.motionManager.deviceMotionUpdateInterval = 1.0/60.0;
    
    NSOperationQueue * queue = [NSOperationQueue mainQueue];
    [self.motionManager startDeviceMotionUpdatesToQueue:queue withHandler:^(CMDeviceMotion *motion, NSError *error)
    {
        self.currentAttitude = motion.attitude;
        int bankDegree = round(180 * (self.currentAttitude.pitch - self.reviseBank) / M_PI);
        int slopeDgree = round(180 * (self.currentAttitude.roll - self.reviseSlope) / M_PI);
        
        for (AXZMeterView *meterView in self.meterViews) {
            [meterView updateBankLabelWithBank:bankDegree];
            [meterView updateSlopeLabelWithSpeed:slopeDgree];
        }
    }];
}

//=============================================================
#pragma CLLocationManagerDelegate
//=============================================================

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *newLocation = locations[locations.count - 1];
    
    for (AXZMeterView *meterView in self.meterViews) {
        [meterView updateSpeedLabelWithSpeed:newLocation.speed];
    }
}

//=============================================================
#pragma AXZMeterViewDelegate
//=============================================================

- (void)resetButtonDidTapped:(id)sender
{
    self.reviseBank = self.currentAttitude.pitch;
    self.reviseSlope = self.currentAttitude.roll;
}

- (void)infoButtonDidTapped:(id)sender
{
    AXZWebViewController *axzWebView = [[AXZWebViewController alloc] initWithNibName:@"AXZWebViewController" bundle:nil];
    [self presentViewController:axzWebView animated:YES completion:nil];
}

- (void)userButtonDidtapped:(id)sender
{
    AXZSettingViewController *settingViewController = [[AXZSettingViewController alloc] initWithNibName:@"AXZSettingViewController" bundle:nil];
    [self presentViewController:settingViewController animated:YES completion:nil];
}

- (void)homeButtonDidtapped:(id)sender
{
    CGPoint offset;
    offset.x = 0;
    offset.y = 0;
    
    [self.scrollView setContentOffset:offset animated:YES];
}

- (void)arrowLeftButtonDidTapped:(id)sender
{
    AXZBankViewController *bankViewController = [[AXZBankViewController alloc] initWithNibName:NSStringFromClass([AXZBankViewController class]) bundle:nil];
    bankViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:bankViewController animated:YES completion:nil];
}

- (void)arrowRightButtonDidTapped:(id)sender
{
    AXZSlopeViewController *slopeViewController = [[AXZSlopeViewController alloc] initWithNibName:NSStringFromClass([AXZSlopeViewController class]) bundle:nil];
    slopeViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:slopeViewController animated:YES completion:nil];
}

//=============================================================
#pragma Error
//=============================================================

- (void)showError
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"モーションエラー" message:@"モーションの取得に失敗しました." preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"はい" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [alert dismissViewControllerAnimated:YES completion:nil];
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

@end
