#import "AXZSettingViewController.h"
#import "AXZBlueToothViewController.h"
#import "AXZAsset.h"
#import "UIView+AXZUI.h"
#import "UILabel+AXZUI.h"

@interface AXZSettingViewController ()<UINavigationControllerDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate>

- (IBAction)userImageChange:(id)sender;
- (IBAction)closeView:(id)sender;
- (IBAction)settingButtonAction:(id)sender;
- (IBAction)BluetoothButtonAction:(id)sender;
- (IBAction)machineTextFieldAction:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *userImage;
@property UIView* subView;
@property UIImage* userImageView;
@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong,nonatomic) NSUserDefaults* textUserDef;
@property (strong,nonatomic) NSUserDefaults* textMachineDef;
@property (strong,nonatomic) UIImagePickerController *imagePicker;
@property (strong, nonatomic) IBOutlet UITextField *machineTextField;
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (strong, nonatomic) IBOutlet UIButton *bluetoothButton;
@property (strong, nonatomic) AXZAsset *asset;
@property (nonatomic) CGRect windowSize;

@end

@implementation AXZSettingViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundImageView.image = self.asset.settingBackgroundImage;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.asset = [AXZAsset new];
   
    NSNotificationCenter *notification = [NSNotificationCenter defaultCenter];
    [notification addObserver:self selector:@selector(keyboardWiiShow:) name:UIKeyboardWillShowNotification object:nil];
    [notification addObserver:self selector:@selector(keyboardDismissMode:) name:UIKeyboardWillHideNotification object:nil];
    
    self.textField.delegate = self;
    self.machineTextField.delegate = self;

    self.subView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 568, 320)];
    self.subView.hidden = YES;
    self.subView.backgroundColor = [UIColor blackColor];

    
    NSString* userNameStr = [[NSUserDefaults standardUserDefaults]stringForKey:@"userName"];
    NSString* userMachine = [[NSUserDefaults standardUserDefaults]stringForKey:@"userMachine"];
    NSData* userImageData = [[NSUserDefaults standardUserDefaults]objectForKey:@"userImage"];
    
    UIButton* closeButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 320, 568)];
    [closeButton addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    UIImageView* userImageView = [[UIImageView alloc]initWithFrame:CGRectMake(120, 0, 320, 300)];
    [self.view addSubview:self.subView];

    self.userImage.frame = [UIView settingUserImageRect];
    self.textField.frame = [UIView settingUserNameLabelRect];
    self.machineTextField.frame = [UIView settingUserMachineNameLabelRect];

    if (userNameStr != NULL) {
        self.textField.text = userNameStr;
    } else {
        self.textField.text = @"NoName";
        
    }
    if (userMachine != NULL) {
        self.machineTextField.text = userMachine;
    } else {
        self.machineTextField.text = @"NoName";
    }

    if (userImageData != NULL) {
        UIImage* userimage = [UIImage imageWithData:userImageData];
        [self.userImage setImage:userimage forState:UIControlStateNormal];
        CALayer* layer = [self.userImage layer];
        [layer setMasksToBounds:YES];
        [layer setCornerRadius:100];
        userImageView.image = userimage;
        
    }
    self.subView.hidden = YES;
    self.subView.backgroundColor = [UIColor blackColor];
    [self.subView addSubview:closeButton];
    [self.view addSubview:self.subView];
    [self.subView addSubview:userImageView];
}

-(void)keyboardWiiShow:(NSNotification*)notification
{
    NSDictionary *dic = [notification userInfo];
    
    CGRect keyboardRect         = [[dic objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSTimeInterval duration     = [[dic objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve curve  = [[dic objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    void (^animations)(void);
    animations = ^(void) {
        self.textField.frame = CGRectMake(self.textField.frame.origin.x,
                                     self.textField.frame.origin.y - keyboardRect.size.width+58,
                                     self.textField.frame.size.width,
                                     self.textField.frame.size.height);
        self.machineTextField.frame = CGRectMake(self.machineTextField.frame.origin.x,
                                          self.machineTextField.frame.origin.y - keyboardRect.size.width+58,
                                          self.machineTextField.frame.size.width,
                                          self.machineTextField.frame.size.height);
    };
    
    [UIView animateWithDuration:duration
                         delay:0.0f
                       options:curve
                    animations:animations
                    completion:nil];
    
}

-(void)keyboardDismissMode:(NSNotification*)notification
{
    NSDictionary *dic = [notification userInfo];
    CGRect keyboardRect         = [[dic objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSTimeInterval duration     = [[dic objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve curve  = [[dic objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    void (^animations)(void);
    animations = ^(void) {
        self.textField.frame = CGRectMake(self.textField.frame.origin.x,
                                          self.textField.frame.origin.y + keyboardRect.size.width-58,
                                          self.textField.frame.size.width,
                                          self.textField.frame.size.height);
        self.machineTextField.frame = CGRectMake(self.machineTextField.frame.origin.x,
                                                 self.machineTextField.frame.origin.y + keyboardRect.size.width-58,
                                                 self.machineTextField.frame.size.width,
                                                 self.machineTextField.frame.size.height);
    };
    
    [UIView animateWithDuration:duration
                          delay:0.0f
                        options:curve
                     animations:animations
                     completion:nil];

    NSUserDefaults* userNameDef = [NSUserDefaults standardUserDefaults];
    NSUserDefaults* userMachineDef = [NSUserDefaults standardUserDefaults];
    [userNameDef setObject:self.textField.text forKey:@"userName"];
    [userMachineDef setObject:self.machineTextField.text forKey:@"userMachine"];
    [userNameDef synchronize];
    [userMachineDef synchronize];

}
- (BOOL)textFieldShouldReturn:(UITextField *)targetTextField {
    
    [targetTextField resignFirstResponder];
    return YES;
}


-(IBAction)textfieldDoneEditing:(id)sender
{
    [sender resignFirstResponder];
    
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	UIImage *originalImage = (UIImage *)[info objectForKey:UIImagePickerControllerOriginalImage];
	UIImage *editedImage = (UIImage *)[info objectForKey:UIImagePickerControllerEditedImage];
	UIImage *saveImage;
	
	if(editedImage) {
		saveImage = editedImage;
	} else {
		saveImage = originalImage;
	}
    
    self.userImageView = saveImage;
    [self.userImage setImage:self.userImageView forState:UIControlStateNormal];
    CALayer* layer = [self.userImage layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:100];
    
    NSData* userImageData = UIImagePNGRepresentation(self.userImageView);
    
    [[NSUserDefaults standardUserDefaults]setObject:userImageData forKey:@"userImage"];

    UIImageWriteToSavedPhotosAlbum(saveImage, nil, nil, nil);
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            self.subView.hidden = NO;
            break;
        case 1:
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
            {
                UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
                [imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
                [imagePickerController setAllowsEditing:YES];
                [imagePickerController setDelegate:self];
                
                [self presentViewController:imagePickerController animated:YES completion:nil];
            }
            else
            {
                NSLog(@"photo library invalid.");
            }
            
            break;
        default:
            break;
    }
}

- (IBAction)userImageChange:(id)sender
{
    UIActionSheet* actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Display profile image",@"Register profile image", nil];
    [actionSheet showInView:[[[[UIApplication sharedApplication] keyWindow] subviews] lastObject]];
}

- (IBAction)closeView:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)settingButtonAction:(id)sender
{
    
}

- (IBAction)BluetoothButtonAction:(id)sender
{
    AXZBlueToothViewController *bluetoothView = [[AXZBlueToothViewController alloc] init];
    [self presentViewController:bluetoothView animated:YES completion:nil];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskLandscapeLeft;
}

-(void)closeAction{
    self.subView.hidden = YES;
    
}
- (IBAction)machineTextFieldAction:(id)sender{
    
}

-(void)viewWillDisappear:(BOOL)animated
{
        NSNotificationCenter *center;
        center = [NSNotificationCenter defaultCenter];
        [center
         removeObserver:self
         name:UIKeyboardWillShowNotification
         object:nil];
        [center
         removeObserver:self
         name:UIKeyboardWillHideNotification
         object:nil];
}

@end
