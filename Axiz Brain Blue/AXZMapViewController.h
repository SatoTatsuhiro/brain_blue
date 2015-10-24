#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@interface AXZMapViewController : UIViewController
@property double latitude;  //緯度
@property double longitude; //経度

@property (strong, nonatomic) IBOutlet UITextField *AdressStrTextField;
@property (nonatomic, retain) CLLocationManager *locationManager;

-(void) onResume;
-(void) onPause;



@end
