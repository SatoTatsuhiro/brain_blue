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

@end

@implementation AXZMeterView

- (void)awakeFromNib
{
    self.asset = [AXZAsset new];
    [self setImages];
    self.speedButtonType = AXZSpeedButtonTypeKm;
    self.speedLabel.font = [UILabel mainLabelFont];
    self.bankLabel.font = [UILabel mainLabelFont];
    self.slopeLabel.font = [UILabel mainLabelFont];
}

- (void)setImages
{
    self.backgroundImageView.image = self.asset.backgroundImages[self.index];
    self.innerCircleImageView.image = self.asset.kmInnerCircleImages[self.index];
    [self.speedButton setImage:self.asset.kmButtonImages[self.index] forState:UIControlStateNormal];
    [self.speedButton setImage:self.asset.kmButtonHoverImages[self.index] forState:UIControlStateHighlighted];
}

- (void)layoutSubviews
{
    self.innerCircleImageView.frame = [UIView mainInnerCircleImageViewRect];
    self.speedLabel.frame = [UIView mainSpeedTypeButtonRect];
    self.bankLabel.frame = [UIView mainBankLabelRect];
    self.slopeLabel.frame = [UIView mainSlopeLabelRect];
    self.speedButton.frame = [UIView mainSpeedTypeButtonRect];
}

//=============================================================
#pragma UpdateLabels
//=============================================================

- (void)updateSpeedLabelWithSpeed:(float)speed
{
    if (self.speedButtonType == AXZSpeedButtonTypeKm) {
        self.speedLabel.text = [NSString stringWithFormat:@"%.0f",speed * 3.6];
    } else {
        self.speedLabel.text = [NSString stringWithFormat:@"%.0f",speed];
    }
}

- (void)updateBankLabelWithBank:(float)bank
{
    self.bankLabel.text = [NSString stringWithFormat:@"%.0f°",bank];
}

- (void)updateSlopeLabelWithSpeed:(float)slope
{
    self.slopeLabel.text = [NSString stringWithFormat:@"%.0f°",slope];
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
