#import <UIKit/UIKit.h>

@protocol AXZMeterViewDelegate <NSObject>

- (void)resetButtonDidTapped:(id)sender;
- (void)infoButtonDidTapped:(id)sender;
- (void)homeButtonDidtapped:(id)sender;
- (void)userButtonDidtapped:(id)sender;
- (void)arrowLeftButtonDidTapped:(id)sender;
- (void)arrowRightButtonDidTapped:(id)sender;

@end

@interface AXZMeterView : UIView

- (void)setImages;

- (void)updateSpeedLabelWithSpeed:(float)speed;
- (void)updateBankLabelWithBank:(float)bank;
- (void)updateSlopeLabelWithSpeed:(float)slope;
- (void)updateSpeedPinWithSpeed:(float)speed;

@property (weak) id<AXZMeterViewDelegate> delegate;
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (strong, nonatomic) IBOutlet UIImageView *innerCircleImageView;
@property (strong, nonatomic) IBOutlet UIButton *speedButton;
@property (strong, nonatomic) IBOutlet UILabel *bankLabel;
@property (strong, nonatomic) IBOutlet UILabel *slopeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *interfaceImageView;

@property (nonatomic) NSInteger index;

@end