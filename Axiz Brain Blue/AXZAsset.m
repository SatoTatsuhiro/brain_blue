#import "AXZAsset.h"

@interface AXZAsset ()

@property (nonatomic) CGRect screenRect;

@end

@implementation AXZAsset

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.screenRect = [[UIScreen mainScreen] bounds];
    }
    return self;
}

- (NSMutableArray *)backgroundImages
{
    NSMutableArray *backgroundImages = [[NSMutableArray alloc] init];

    [backgroundImages addObject:[UIImage imageNamed:@"df_bk_bg"]];
    [backgroundImages addObject:[UIImage imageNamed:@"xspeed_bg"]];
    [backgroundImages addObject:[UIImage imageNamed:@"bikers_bg"]];
    [backgroundImages addObject:[UIImage imageNamed:@"kkk_bg"]];
    [backgroundImages addObject:[UIImage imageNamed:@"motomoto_bg"]];
    [backgroundImages addObject:[UIImage imageNamed:@"motochamp_bg"]];

    return backgroundImages;
}

- (NSMutableArray *)meterInterfaceImages    
{
    NSMutableArray *meterInterfaceImages = [[NSMutableArray alloc] init];

    if (self.screenRect.size.width == 736 && self.screenRect.size.height == 414) {
        [meterInterfaceImages addObject:[UIImage imageNamed:@"df_red_if"]];
        [meterInterfaceImages addObject:[UIImage imageNamed:@"xspeed_if"]];
        [meterInterfaceImages addObject:[UIImage imageNamed:@"bikers_if"]];
        [meterInterfaceImages addObject:[UIImage imageNamed:@"kkk_if"]];
        [meterInterfaceImages addObject:[UIImage imageNamed:@"mmw_if"]];
        [meterInterfaceImages addObject:[UIImage imageNamed:@"mmw_if"]];
    } else {
        [meterInterfaceImages addObject:[UIImage imageNamed:@"df_red_if_55"]];
        [meterInterfaceImages addObject:[UIImage imageNamed:@"xspeed_if_55"]];
        [meterInterfaceImages addObject:[UIImage imageNamed:@"bikers_if_55"]];
        [meterInterfaceImages addObject:[UIImage imageNamed:@"kkk_if_55"]];
        [meterInterfaceImages addObject:[UIImage imageNamed:@"mmw_if"]];
        [meterInterfaceImages addObject:[UIImage imageNamed:@"mmw_if"]];
    }

    return meterInterfaceImages;
}

- (NSMutableArray *)kmButtonImages
{
    NSMutableArray *kmButtonImages = [[NSMutableArray alloc] init];
    
    [kmButtonImages addObject:[UIImage imageNamed:@"km_type3_55"]];
    [kmButtonImages addObject:[UIImage imageNamed:@"km_type1_55"]];
    [kmButtonImages addObject:[UIImage imageNamed:@"km_type2_55"]];
    [kmButtonImages addObject:[UIImage imageNamed:@"km_type1_55"]];
    [kmButtonImages addObject:[UIImage imageNamed:@"km_type2_55"]];
    [kmButtonImages addObject:[UIImage imageNamed:@"km_type2_55"]];

    return kmButtonImages;
}

- (NSMutableArray *)kmButtonHoverImages
{
    NSMutableArray *kmButtonHoverImages = [[NSMutableArray alloc] init];
    
    [kmButtonHoverImages addObject:[UIImage imageNamed:@"km_hover_type3_55"]];
    [kmButtonHoverImages addObject:[UIImage imageNamed:@"km_hover_type1_55"]];
    [kmButtonHoverImages addObject:[UIImage imageNamed:@"km_hover_type2_55"]];
    [kmButtonHoverImages addObject:[UIImage imageNamed:@"km_hover_type1_55"]];
    [kmButtonHoverImages addObject:[UIImage imageNamed:@"km_hover_type2_55"]];
    [kmButtonHoverImages addObject:[UIImage imageNamed:@"km_hover_type2_55"]];

    return kmButtonHoverImages;
}

- (NSMutableArray *)kmInnerCircleImages
{
    NSMutableArray *innerCircleImages = [[NSMutableArray alloc] init];
    
    [innerCircleImages addObject:[UIImage imageNamed:@"inner_circle_km_red"]];
    [innerCircleImages addObject:[UIImage imageNamed:@"inner_circle_km_red"]];
    [innerCircleImages addObject:[UIImage imageNamed:@"inner_circle_km_red"]];
    [innerCircleImages addObject:[UIImage imageNamed:@"inner_circle_km_red"]];
    [innerCircleImages addObject:[UIImage imageNamed:@"inner_circle_km_red"]];
    [innerCircleImages addObject:[UIImage imageNamed:@"inner_circle_km_red"]];

    return innerCircleImages;
}

- (NSMutableArray *)mphInnerCircleImages
{
    NSMutableArray *innerCircleImages = [[NSMutableArray alloc] init];

    [innerCircleImages addObject:[UIImage imageNamed:@"inner_circle_mph_red"]];
    [innerCircleImages addObject:[UIImage imageNamed:@"inner_circle_mph_red"]];
    [innerCircleImages addObject:[UIImage imageNamed:@"inner_circle_mph_red"]];
    [innerCircleImages addObject:[UIImage imageNamed:@"inner_circle_mph_red"]];
    [innerCircleImages addObject:[UIImage imageNamed:@"inner_circle_mph_red"]];
    [innerCircleImages addObject:[UIImage imageNamed:@"inner_circle_mph_red"]];

    return innerCircleImages;
}

- (NSMutableArray *)mphButtonImages
{
    NSMutableArray *mphButtonImages = [[NSMutableArray alloc] init];
    
    [mphButtonImages addObject:[UIImage imageNamed:@"mph_type3_55"]];
    [mphButtonImages addObject:[UIImage imageNamed:@"mph_type1_55"]];
    [mphButtonImages addObject:[UIImage imageNamed:@"mph_type2_55"]];
    [mphButtonImages addObject:[UIImage imageNamed:@"mph_type1_55"]];
    [mphButtonImages addObject:[UIImage imageNamed:@"mph_type2_55"]];
    [mphButtonImages addObject:[UIImage imageNamed:@"mph_type2_55"]];

    return mphButtonImages;
}

- (NSMutableArray *)mphButtonHoverImages
{
    NSMutableArray *mphButtonHoverImages = [[NSMutableArray alloc] init];
    
    [mphButtonHoverImages addObject:[UIImage imageNamed:@"mph_hover_type3_55"]];
    [mphButtonHoverImages addObject:[UIImage imageNamed:@"mph_hover_type1_55"]];
    [mphButtonHoverImages addObject:[UIImage imageNamed:@"mph_hover_type2_55"]];
    [mphButtonHoverImages addObject:[UIImage imageNamed:@"mph_hover_type1_55"]];
    [mphButtonHoverImages addObject:[UIImage imageNamed:@"mph_hover_type2_55"]];
    [mphButtonHoverImages addObject:[UIImage imageNamed:@"mph_hover_type2_55"]];

    return mphButtonHoverImages;
}

- (NSArray *)splashImages
{
    NSMutableArray *images = [[NSMutableArray alloc] init];

    [images addObject:[UIImage imageNamed:@"kiken"]];
    [images addObject:[UIImage imageNamed:@"red"]];

    return images;
}

- (UIImageView *)bankBackgroundImageView
{
    if (self.screenRect.size.width == 320) {
        return [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bank_35_background"]];
    } else if (self.screenRect.size.width == 480) {
        return [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bank_background"]];
    } else if (self.screenRect.size.width == 667) {
        return [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bank_background"]];
    } else if (self.screenRect.size.width == 736) {
        return [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bank_background"]];
    }
    return nil;
}

- (UIImageView *)slopeInterfaceImageView
{
    if (self.screenRect.size.width == 736) {
        return [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"slope_if_55"]];
    } else {
        return [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"slope_if"]];
    }
    return nil;
}

- (UIImageView *)settingInterfaceImageView
{
    if (self.screenRect.size.width == 736 && self.screenRect.size.height == 414) {
        return [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"user_red_if"]];
    } else {
        return [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"user_red_if_55"]];
    }
    return nil;
}

- (UIImageView *)settingUserImageView
{
    if (self.screenRect.size.width == 320) {
        return [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"slope_35_background"]];
    } else if (self.screenRect.size.width == 480) {
        return [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"slope_background"]];
    } else if (self.screenRect.size.width == 667) {
        return [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"slope_background"]];
    } else if (self.screenRect.size.width == 736) {
        return [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"slope_background"]];
    }
    return nil;
}

- (UIImageView *)blueToothImageView
{
    if (self.screenRect.size.width == 736 && self.screenRect.size.height == 414) {
        return [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bluetooth_if"]];
    } else {
        return [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bluetooth_if_55"]];
    }
    return nil;
}

- (UIImageView *)bankRiderImageView
{
    return [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rider_slope@2x"]];
}

- (UIImageView *)slopeRiderImageView
{
    return [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rider_slope@2x"]];
}

@end
