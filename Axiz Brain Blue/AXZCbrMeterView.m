#import "AXZCbrMeterView.h"
#import "UIView+AXZUI.h"
#import "UILabel+AXZUI.h"

@interface AXZCbrMeterView ()

@property (strong, nonatomic) IBOutlet UIImageView *speedPinImageView;
@property (strong, nonatomic) IBOutlet UIImageView *engineRotationPinImageView;

@property (strong, nonatomic) IBOutlet UILabel *speedLabel;
@property (strong, nonatomic) IBOutlet UILabel *bankLabel;
@property (strong, nonatomic) IBOutlet UILabel *slopeLabel;

@end

@implementation AXZCbrMeterView

- (void)awakeFromNib
{
    self.speedPinImageView.translatesAutoresizingMaskIntoConstraints = YES;
    self.speedPinImageView.frame = [UIView cbrSpeedPinRect];

    self.engineRotationPinImageView.translatesAutoresizingMaskIntoConstraints = YES;
    self.engineRotationPinImageView.frame = [UIView cbrEnginePinRect];

    self.speedPinImageView.transform = CGAffineTransformMakeRotation(3.13);
    self.engineRotationPinImageView.transform = CGAffineTransformMakeRotation(3.13);

    self.speedLabel.translatesAutoresizingMaskIntoConstraints = YES;
    self.speedLabel.frame = [UIView cbrSpeedLabelRect];
    self.speedLabel.font = [UILabel cbrLabelsFont];

    UILabel *kmLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.speedLabel.frame.origin.x + 50, self.speedLabel.frame.origin.y + 3, self.speedLabel.frame.size.width, self.speedLabel.frame.size.height)];
    kmLabel.font = [UIFont systemFontOfSize:17];
    kmLabel.text = @"km/h";
    kmLabel.textColor = [UIColor whiteColor];
    [self addSubview:kmLabel];

    self.bankLabel.translatesAutoresizingMaskIntoConstraints = YES;
    self.bankLabel.frame = [UIView cbrBankLabelRect];
    self.bankLabel.font = [UILabel cbrLabelsFont];

    self.slopeLabel.translatesAutoresizingMaskIntoConstraints = YES;
    self.slopeLabel.frame = [UIView cbrSlopeLabelRect];
    self.slopeLabel.font = [UILabel cbrLabelsFont];
}

//=============================================================
#pragma UpdateLabels
//=============================================================

- (void)updateSpeedLabelWithSpeed:(float)speed
{
    self.speedLabel.text = [NSString stringWithFormat:@"%.0f",speed * 3.6];
}

- (void)updateBankLabelWithBank:(float)bank
{
    if (bank > 45 || bank < -45) {
        [self.bankLabel setTextColor:[UIColor redColor]];
    } else {
        [self.bankLabel setTextColor:[UIColor whiteColor]];
    }

    if (bank > 0) {
        self.bankLabel.text = [NSString stringWithFormat:@"+%.0f°",bank];
    } else {
        self.bankLabel.text = [NSString stringWithFormat:@"%.0f°",bank];
    }
}

- (void)updateSlopeLabelWithSpeed:(float)slope
{
    if (slope > 45 || slope < -45) {
        [self.slopeLabel setTextColor:[UIColor redColor]];
    } else {
        [self.slopeLabel setTextColor:[UIColor whiteColor]];
    }

    if (slope > 0) {
        self.slopeLabel.text = [NSString stringWithFormat:@"+%.0f°",slope];
    } else {
        self.slopeLabel.text = [NSString stringWithFormat:@"%.0f°",slope];
    }
}

//=============================================================
#pragma UpdateSpeedPin
//=============================================================

- (void)updateSpeedPinWithSpeed:(float)speed
{
    float speedRadian = speed * M_PI / 140;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:3];
    self.speedPinImageView.transform = CGAffineTransformMakeRotation(speedRadian - (3 * M_PI /3));
    self.engineRotationPinImageView.transform = CGAffineTransformMakeRotation(speedRadian -(3 * M_PI /3));
    [UIView commitAnimations];
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

- (IBAction)userButtonAction:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(userButtonDidtapped:)]) {
        [self.delegate userButtonDidtapped:self];
    }

}

- (IBAction)resetButtonAction:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(resetButtonDidTapped:)]) {
        [self.delegate resetButtonDidTapped:self];
    }
}

@end
