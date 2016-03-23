#import "AXZSettingViewController.h"
#import "AXZBlueToothViewController.h"
#import "AXZAsset.h"
#import "UIView+AXZUI.h"
#import "UILabel+AXZUI.h"

@interface AXZSettingViewController ()<UIImagePickerControllerDelegate, UITextFieldDelegate, UIGestureRecognizerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) IBOutlet UIButton *userImage;
@property (strong, nonatomic) IBOutlet UIImageView *subView;
@property (strong, nonatomic) IBOutlet UIImageView *userImageView;
@property (strong, nonatomic) IBOutlet UITextField *userNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *machineNameTextField;
@property (strong, nonatomic) UIImagePickerController *imagePicker;
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (strong, nonatomic) IBOutlet UIButton *bluetoothButton;
@property (weak, nonatomic) IBOutlet UIImageView *settingInterfaceImage;
@property (strong, nonatomic) AXZAsset *asset;
@property (nonatomic) CGRect windowSize;

@end

@implementation AXZSettingViewController

- (void)initalize
{
    self.asset = [AXZAsset new];

    self.userNameTextField.delegate = self;
    self.userNameTextField.translatesAutoresizingMaskIntoConstraints = YES;
    self.userNameTextField.frame = [UIView settingUserNameLabelRect];
    [self updateUserNameTextField];

    self.machineNameTextField.delegate = self;
    self.machineNameTextField.translatesAutoresizingMaskIntoConstraints = YES;
    self.machineNameTextField.frame = [UIView settingUserMachineNameLabelRect];
    [self updateMachineNameTextField];

    self.subView.hidden = YES;
    self.subView.backgroundColor = [UIColor blackColor];

    self.settingInterfaceImage = self.asset.settingInterfaceImageView;

    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    gestureRecognizer.delegate = self;
    [self.view addGestureRecognizer:gestureRecognizer];
}

- (void)prepareNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:@"UIKeyboardWillShowNotification"
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:@"UIKeyboardDidHideNotification"
                                               object:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initalize];
    [self prepareNotifications];

    NSData* userImageData = [[NSUserDefaults standardUserDefaults]objectForKey:@"userImage"];

    self.userImage.translatesAutoresizingMaskIntoConstraints = YES;
    self.userImage.frame = [UIView settingUserImageRect];

    if (userImageData != NULL) {
        UIImage* userimage = [UIImage imageWithData:userImageData];
        [self.userImage setImage:userimage forState:UIControlStateNormal];
        CALayer* layer = [self.userImage layer];
        [layer setMasksToBounds:YES];
        [layer setCornerRadius:100];
        self.userImageView.image = userimage;
        self.userImageView.backgroundColor = [UIColor whiteColor];
        
        
    }
    self.subView.hidden = YES;
    self.subView.backgroundColor = [UIColor blackColor];
    [self.subView addSubview:self.userImageView];
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

- (void)registerUserImageIcon
{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        self.imagePicker = [[UIImagePickerController alloc]init];
        self.imagePicker.delegate = self;
        [self.imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [self.imagePicker setAllowsEditing:YES];

        [self presentViewController:self.imagePicker animated:YES completion:nil];
    } else {
        NSLog(@"photo library invalid.");
    }
}

//=============================================================
#pragma UserImageIcon
//=============================================================

- (IBAction)userImageChange:(id)sender
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"title" message:@"message" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *displayProfileImageAction = [UIAlertAction actionWithTitle:@"Display profile image"
                                                                        style:UIAlertActionStyleDefault
                                                                      handler:^(UIAlertAction *action) {
                                                                          self.subView.hidden = NO;
                                                                      }];

    UIAlertAction *changeIconImageAction = [UIAlertAction actionWithTitle:@"Register profile image"
                                                                    style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction *action) {
                                                                      [self registerUserImageIcon];
                                                                  }];

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertController addAction:displayProfileImageAction];
    [alertController addAction:changeIconImageAction];
    [alertController addAction:cancelAction];

    [self presentViewController:alertController animated:YES completion:nil];
}

//=============================================================
#pragma Action
//=============================================================

- (IBAction)closeView:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)BluetoothButtonAction:(id)sender
{
    AXZBlueToothViewController *bluetoothView = [[AXZBlueToothViewController alloc] init];
    [self presentViewController:bluetoothView animated:YES completion:nil];
}

//=============================================================
#pragma UIGestureRecognizerDelegate
//=============================================================

- (void)tapped:(UIGestureRecognizer *)sender
{
    if (self.userNameTextField.isFirstResponder) {
        [self.userNameTextField resignFirstResponder];
    } else if (self.machineNameTextField.isFirstResponder) {
        [self.machineNameTextField resignFirstResponder];
    } else {
        self.subView.hidden = YES;
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if (self.userNameTextField.isFirstResponder || self.machineNameTextField.isFirstResponder || self.subView.hidden == NO) {
        return YES;
    } else {
        return NO;
    }
}

//=============================================================
#pragma UITextFieldDelegate
//=============================================================

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.userNameTextField) {
        [[NSUserDefaults standardUserDefaults] setObject:textField.text forKey:@"userNameTextKey"];
    } else if (textField == self.machineNameTextField) {
        [[NSUserDefaults standardUserDefaults] setObject:textField.text forKey:@"machineNameTextKey"];
    }
}

- (void)updateMachineNameTextField
{
    NSString* machineName = [[NSUserDefaults standardUserDefaults]stringForKey:@"machineNameTextKey"];

    if (machineName != NULL) {
        self.machineNameTextField.text = machineName;
    } else {
        self.machineNameTextField.text = @"NoName";
    }
}

- (void)updateUserNameTextField
{
    NSString *userName = [[NSUserDefaults standardUserDefaults]stringForKey:@"userNameTextKey"];

    if (userName != NULL) {
        self.userNameTextField.text = userName;
    } else {
        self.userNameTextField.text = @"NoName";
    }
}

//=============================================================
#pragma UITextFieldKeybord
//=============================================================

- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    CGSize keybordSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;

    CGRect userNameTextFieldFrame = self.userNameTextField.frame;
    userNameTextFieldFrame.origin.y -= keybordSize.height;

    CGRect machineNameTextFieldFrame = self.machineNameTextField.frame;
    machineNameTextFieldFrame.origin.y -= keybordSize.height;

    [UIView animateWithDuration:0.3 animations:^{
        self.userNameTextField.frame = userNameTextFieldFrame;
        self.machineNameTextField.frame = machineNameTextFieldFrame;
    }];
}

- (void)keyboardDidHide:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    CGSize keybordSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;

    CGRect userNameTextFieldFrame = self.userNameTextField.frame;
    userNameTextFieldFrame.origin.y += keybordSize.height;

    CGRect machineNameTextFieldFrame = self.machineNameTextField.frame;
    machineNameTextFieldFrame.origin.y += keybordSize.height;

    [UIView animateWithDuration:0.3 animations:^{
        self.userNameTextField.frame = userNameTextFieldFrame;
        self.machineNameTextField.frame = machineNameTextFieldFrame;
    }];
}

//=============================================================
#pragma Setting
//=============================================================

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscapeLeft;
}

@end
