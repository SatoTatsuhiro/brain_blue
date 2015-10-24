#import "AXZTripViewController.h"
#import <CoreLocation/CoreLocation.h>


@interface AXZTripViewController ()<CLLocationManagerDelegate>

@property (strong, nonatomic)CLLocationManager* locationManager;
@property int totalDistance;
@property int totalMileDistance;

- (IBAction)resetbutton:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *typeChangeButton;

- (IBAction)typeChangeAction:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *setButton;
- (IBAction)setButtonAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *resetButton;

@end
int typeFlag;
int setTypeButtonFlag;



@implementation AXZTripViewController

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
    //CLLocationManagerの初期化
    self.locationManager = [[CLLocationManager alloc] init];
    
    //デバイスがGPSを使えるか確認
    BOOL locationServicesEnabled;
    locationServicesEnabled = [CLLocationManager locationServicesEnabled];
    
    if (locationServicesEnabled) {
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest; //精度設定（最高設定）
        self.locationManager.distanceFilter = 1; //更新間隔（1メートル毎に更新）
    }
    
    //位置情報の検出開始
    [self.locationManager startUpdatingLocation];
    self.totalDistance = 0;
    typeFlag = 1;
    setTypeButtonFlag = 1;
    
    
    [self.setButton setImage:[UIImage imageNamed:@"button_set_hover"] forState:UIControlStateHighlighted];
    [self.resetButton setImage:[UIImage imageNamed:@"button_reset_hover"] forState:UIControlStateHighlighted];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    
    if(oldLocation != nil)
    {
        if (setTypeButtonFlag == 2) {
            CLLocationDistance distance = [newLocation distanceFromLocation:oldLocation];
            self.totalDistance = self.totalDistance + distance;

        } else {
            NSLog(@"セットされていません");
            
        }
        
    }
    if (typeFlag == 1) {
        
        int totalDistanceToKm = self.totalDistance / 10;
        NSString* distanceStr = [NSString stringWithFormat:@"%06d",totalDistanceToKm];
        
        self.tripLabel1.text = [NSString stringWithFormat:@"%@",[distanceStr substringWithRange:NSMakeRange(5, 1)]];
        self.tripLabel2.text = [NSString stringWithFormat:@"%@",[distanceStr substringWithRange:NSMakeRange(4, 1)]];
        self.tripLabel3.text = [NSString stringWithFormat:@"%@",[distanceStr substringWithRange:NSMakeRange(3, 1)]];
        self.tripLabel4.text = [NSString stringWithFormat:@"%@",[distanceStr substringWithRange:NSMakeRange(2, 1)]];
        self.tripLabel5.text = [NSString stringWithFormat:@"%@",[distanceStr substringWithRange:NSMakeRange(1, 1)]];
        self.tripLabel6.text = [NSString stringWithFormat:@"%@",[distanceStr substringWithRange:NSMakeRange(0, 1)]];
        
    } else if (typeFlag == 2) {
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

- (IBAction)resetbutton:(id)sender {
    self.totalDistance = 0;
}
- (IBAction)typeChangeAction:(id)sender {
    if (typeFlag == 1) {
        [self.typeChangeButton setImage:[UIImage imageNamed:@"button_mph_trip"] forState:UIControlStateNormal];
        [self.typeChangeButton setImage:[UIImage imageNamed:@"button_mph_hover_trip"] forState:UIControlStateHighlighted];
        typeFlag = 2;
    } else if (typeFlag == 2) {
        [self.typeChangeButton setImage:[UIImage imageNamed:@"button_km_trip"] forState:UIControlStateNormal];
        [self.typeChangeButton setImage:[UIImage imageNamed:@"button_km_hover_trip"] forState:UIControlStateHighlighted];
        typeFlag = 1;
        
        
    }
    
    
}
- (IBAction)setButtonAction:(id)sender {
    if (setTypeButtonFlag == 1) {
        [self.setButton setImage:[UIImage imageNamed:@"button_running@2x"] forState:UIControlStateNormal];
        [self.setButton setImage:[UIImage imageNamed:@"button_running_hover@2x"] forState:UIControlStateHighlighted];
        setTypeButtonFlag = 2;
    } else if (setTypeButtonFlag == 2) {
        [self.setButton setImage:[UIImage imageNamed:@"button_set@2x"] forState:UIControlStateNormal];
        [self.setButton setImage:[UIImage imageNamed:@"button_set_hover@2x"] forState:UIControlStateHighlighted];
        setTypeButtonFlag = 1;
        
        
    }

    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    //文字を白くする
    return UIStatusBarStyleLightContent;
}
- (IBAction)backToMainViewAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end

