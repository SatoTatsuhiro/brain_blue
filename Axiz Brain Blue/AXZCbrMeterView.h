#import <UIKit/UIKit.h>

@protocol AXZCbrMeterViewDelegate <NSObject>

- (void)resetButtonDidTapped:(id)sender;
- (void)infoButtonDidTapped:(id)sender;
- (void)homeButtonDidtapped:(id)sender;
- (void)userButtonDidtapped:(id)sender;
- (void)arrowLeftButtonDidTapped:(id)sender;
- (void)arrowRightButtonDidTapped:(id)sender;

@end

@interface AXZCbrMeterView : UIView

- (void)updateSpeedLabelWithSpeed:(float)speed;
- (void)updateBankLabelWithBank:(float)bank;
- (void)updateSlopeLabelWithSpeed:(float)slope;

@property (weak) id<AXZCbrMeterViewDelegate> delegate;

@end
