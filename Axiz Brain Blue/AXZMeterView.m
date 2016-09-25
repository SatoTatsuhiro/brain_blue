#import "AXZMeterView.h"
#import "AXZAsset.h"
#import "UIView+AXZUI.h"
#import "UILabel+AXZUI.h"

typedef NS_ENUM(NSInteger, AXZSpeedButtonType) {
    AXZSpeedButtonTypeKm,
    AXZSpeedButtonTypeMph,
};

@interface AXZMeterView ()

@property (nonatomic) AXZAsset *asset;
@property (nonatomic) NSInteger speedButtonType;
@property (weak, nonatomic) IBOutlet UILabel *speedLabel;
@property (weak, nonatomic) IBOutlet UIImageView *speedPinImageView;


@end

@implementation AXZMeterView

- (void)awakeFromNib
{
    self.innerCircleImageView.translatesAutoresizingMaskIntoConstraints = YES;
    self.bankLabel.translatesAutoresizingMaskIntoConstraints = YES;
    self.slopeLabel.translatesAutoresizingMaskIntoConstraints = YES;
    self.speedLabel.translatesAutoresizingMaskIntoConstraints = YES;
    self.speedButton.translatesAutoresizingMaskIntoConstraints = YES;
    self.speedPinImageView.translatesAutoresizingMaskIntoConstraints = YES;

    self.asset = [AXZAsset new];
    [self setImages];
    self.speedButtonType = AXZSpeedButtonTypeKm;
    self.speedLabel.font = [UILabel mainLabelFont];
    self.bankLabel.font = [UILabel mainLabelFont];
    self.slopeLabel.font = [UILabel mainLabelFont];

    self.innerCircleImageView.frame = [UIView mainInnerCircleImageViewRect];
    self.speedLabel.frame = [UIView mainSpeedLabelRect];
    self.bankLabel.frame = [UIView mainBankLabelRect];
    self.slopeLabel.frame = [UIView mainSlopeLabelRect];
    self.speedButton.frame = [UIView mainSpeedTypeButtonRect];
    self.speedPinImageView.frame = [UIView mainSpeedPinRect];
    self.speedPinImageView.transform = CGAffineTransformMakeRotation(4.2);
}

- (void)setImages
{
    self.backgroundImageView.image = self.asset.backgroundImages[self.index];
    self.innerCircleImageView.image = self.asset.kmInnerCircleImages[self.index];
    [self.speedButton setImage:self.asset.kmButtonImages[self.index] forState:UIControlStateNormal];
    [self.speedButton setImage:self.asset.kmButtonHoverImages[self.index] forState:UIControlStateHighlighted];
    [self.interfaceImageView setImage:self.asset.meterInterfaceImages[self.index]];
}

//=============================================================
#pragma UpdateLabels
//=============================================================

- (void)updateSpeedLabelWithSpeed:(float)speed
{
    if (self.speedButtonType == AXZSpeedButtonTypeKm) {
        self.speedLabel.text = [NSString stringWithFormat:@"%.0f",speed * 3.6];
    } else {
        self.speedLabel.text = [NSString stringWithFormat:@"%.0f",speed * 2.4];
    }
}

- (void)updateBankLabelWithBank:(float)bank
{
    if (-bank > 90) {
        bank = -90;
    } else if (-bank < -90) {
        bank = 90;
    }

    if (bank > 45 || bank < -45) {
        [self.bankLabel setTextColor:[UIColor redColor]];
    } else {
        [self.bankLabel setTextColor:[UIColor whiteColor]];
    }

    if (-bank > 0) {
        self.bankLabel.text = [NSString stringWithFormat:@"+%.0f°",-bank];
    } else if (-bank < 0){
        self.bankLabel.text = [NSString stringWithFormat:@"%.0f°",-bank];
    } else {
        self.bankLabel.text = [NSString stringWithFormat:@"0°"];
    }
}

- (void)updateSlopeLabelWithSpeed:(float)slope
{
    if (slope > 90) {
        slope = 90;
    } else if (slope < -90) {
        slope = -90;
    }

    if (slope > 45 || slope < -45) {
        [self.slopeLabel setTextColor:[UIColor redColor]];
    } else {
        [self.slopeLabel setTextColor:[UIColor whiteColor]];
    }

    if (slope > 0) {
        self.slopeLabel.text = [NSString stringWithFormat:@"+%.0f°",slope];
    } else if (slope < 0) {
        self.slopeLabel.text = [NSString stringWithFormat:@"%.0f°",slope];
    } else {
        self.slopeLabel.text = [NSString stringWithFormat:@"0°"];
    }
}

//=============================================================
#pragma UpdateSpeedPin
//=============================================================

- (void)updateSpeedPinWithSpeed:(float)speed
{
    float speedRadian = speed * M_PI / 180;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:3];
    self.speedPinImageView.transform = CGAffineTransformMakeRotation(speedRadian -(2 * M_PI /3));
    [UIView commitAnimations];
}
//=============================================================
#pragma UIAction
//=============================================================

- (IBAction)arrowLeftAction:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(arrowLeftButtonDidTapped:)]) {
        [self.delegate arrowLeftButtonDidTapped:self];
    }
}

- (IBAction)arrowRightAction:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(arrowRightButtonDidTapped:)]) {
        [self.delegate arrowRightButtonDidTapped:self];
    }
}

- (IBAction)resetButtonAction:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(resetButtonDidTapped:)]) {
        [self.delegate resetButtonDidTapped:self];
    }
}

- (IBAction)userButtonAction:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(userButtonDidtapped:)]) {
        [self.delegate userButtonDidtapped:self];
    }
}

- (IBAction)infoButtonAction:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(infoButtonDidTapped:)]) {
        [self.delegate infoButtonDidTapped:self];
    }
}

- (IBAction)homeButtonAction:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(homeButtonDidtapped:)]) {
        [self.delegate homeButtonDidtapped:self];
    }
}

- (IBAction)SpeedButtonAction:(id)sender
{
    if (self.speedButtonType == AXZSpeedButtonTypeKm) {
        [self.speedButton setImage:self.asset.mphButtonImages[self.index] forState:UIControlStateNormal];
        [self.speedButton setImage:self.asset.mphButtonHoverImages[self.index] forState:UIControlStateHighlighted];
        [self.innerCircleImageView setImage:self.asset.mphInnerCircleImages[self.index]];
        self.speedButtonType = AXZSpeedButtonTypeMph;
    } else {
        [self.speedButton setImage:self.asset.kmButtonImages[self.index] forState:UIControlStateNormal];
        [self.speedButton setImage:self.asset.kmButtonHoverImages[self.index] forState:UIControlStateHighlighted];
        [self.innerCircleImageView setImage:self.asset.kmInnerCircleImages[self.index]];
        self.speedButtonType = AXZSpeedButtonTypeKm;
    }
}

@end
