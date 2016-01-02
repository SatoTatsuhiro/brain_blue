#import "AXZBlueToothViewController.h"
#import "AXZAsset.h"

@interface AXZBlueToothViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *bluetoothImageView;

- (IBAction)closeViewAction:(id)sender;

@end

@implementation AXZBlueToothViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    AXZAsset *asset = [AXZAsset new];
    self.bluetoothImageView = asset.blueToothBackgroundImageView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)closeViewAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(BOOL)shouldAutorotate
{
    return YES;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscapeLeft;
}

@end
