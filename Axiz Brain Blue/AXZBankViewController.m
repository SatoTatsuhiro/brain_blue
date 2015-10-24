#import "AXZBankViewController.h"
#import "AXZWebViewController.h"
#import "AXZSettingViewController.h"
#import "AXZAsset.h"
#import "UIView+AXZUI.h"
#import "UILabel+AXZUI.h"

@interface AXZBankViewController ()

- (IBAction)resetButton:(id)sender;
- (IBAction)backToMainViewAction:(id)sender;
- (IBAction)infoAction:(id)sender;
- (IBAction)userButtonAction:(id)sender;

@property double Bank;
@property (strong, nonatomic) IBOutlet UILabel *bankLabel;
@property (strong,nonatomic)CMAttitude *currentAttitude;
@property (strong, nonatomic) IBOutlet UIImageView *backGraundImage;
@property (strong, nonatomic) IBOutlet UIButton *infoButton;
@property (strong, nonatomic) IBOutlet UIButton *backToMainButton;
@property (nonatomic) float revisebank;
@property (weak, nonatomic) IBOutlet UIImageView *BankRider;
@property (nonatomic) AXZAsset *asset;

@end

@implementation AXZBankViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self startBankRider];
    
    self.self.revisebank = 0;

    self.asset = [AXZAsset new];

    self.backGraundImage = self.asset.bankBackgroundImageView;
    self.bankLabel.frame = [UIView bankLabelRect];
    self.bankLabel.font = [UILabel bankLabelFont];
}

- (void)startBankRider
{
    self.BankRiderManager = [[CMMotionManager alloc] init];
    self.BankRiderManager.deviceMotionUpdateInterval = 1.0/60.0;
    
    NSOperationQueue * queue = [NSOperationQueue mainQueue];
    [self.BankRiderManager startDeviceMotionUpdatesToQueue:queue withHandler:^(CMDeviceMotion *motion, NSError *error) {
        
        self.currentAttitude = motion.attitude;

        self.Bank = self.currentAttitude.pitch - self.revisebank;
        int pitchDegree = round(180 * (self.currentAttitude.pitch - self.revisebank) / M_PI);
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.1];
        _BankRider.transform = CGAffineTransformMakeRotation(-self.Bank);
        [UIView commitAnimations];
        self.bankLabel.text = [NSString stringWithFormat:@"%d°",-pitchDegree];
    }];
}

- (IBAction)resetButton:(id)sender
{
    self.revisebank = self.currentAttitude.pitch;
}

- (IBAction)backToMainViewAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)infoAction:(id)sender
{
    AXZWebViewController* webViewCtl = [[AXZWebViewController alloc]init];
    [self presentViewController:webViewCtl animated:YES completion:nil];
}

- (IBAction)userButtonAction:(id)sender
{
    AXZSettingViewController *settingViewCtl = [[AXZSettingViewController alloc] init];
    [self presentViewController:settingViewCtl animated:YES completion:nil];
}
- (IBAction)arrowRightAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
@end
