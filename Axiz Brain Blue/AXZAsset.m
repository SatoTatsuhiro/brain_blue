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
    //TODO: 画像を設定する.
    NSMutableArray *backgroundImages = [[NSMutableArray alloc] init];

    if (self.screenRect.size.width == 480 && self.screenRect.size.height == 320) {

        [backgroundImages addObject:[UIImage imageNamed:@"default_red_35_background"]];
        [backgroundImages addObject:[UIImage imageNamed:@"default_red_35_background"]];
        [backgroundImages addObject:[UIImage imageNamed:@"default_red_35_background"]];
        [backgroundImages addObject:[UIImage imageNamed:@"default_red_35_background"]];
        [backgroundImages addObject:[UIImage imageNamed:@"default_red_35_background"]];

    } else if (self.screenRect.size.width == 568 && self.screenRect.size.height == 320) {

        [backgroundImages addObject:[UIImage imageNamed:@"red_background_4"]];
        [backgroundImages addObject:[UIImage imageNamed:@"red_background_4"]];
        [backgroundImages addObject:[UIImage imageNamed:@"red_background_4"]];
        [backgroundImages addObject:[UIImage imageNamed:@"red_background_4"]];
        [backgroundImages addObject:[UIImage imageNamed:@"red_background_4"]];

    } else if (self.screenRect.size.width == 667 && self.screenRect.size.height == 375) {

        [backgroundImages addObject:[UIImage imageNamed:@"red_background_4"]];
        [backgroundImages addObject:[UIImage imageNamed:@"red_background_4"]];
        [backgroundImages addObject:[UIImage imageNamed:@"red_background_4"]];
        [backgroundImages addObject:[UIImage imageNamed:@"red_background_4"]];
        [backgroundImages addObject:[UIImage imageNamed:@"red_background_4"]];

    } else if (self.screenRect.size.width == 736 && self.screenRect.size.height == 414) {

        [backgroundImages addObject:[UIImage imageNamed:@"red_background_4"]];
        [backgroundImages addObject:[UIImage imageNamed:@"red_background_4"]];
        [backgroundImages addObject:[UIImage imageNamed:@"red_background_4"]];
        [backgroundImages addObject:[UIImage imageNamed:@"red_background_4"]];
        [backgroundImages addObject:[UIImage imageNamed:@"red_background_4"]];

    }

    return backgroundImages;
}

- (NSMutableArray *)kmButtonImages
{
    NSMutableArray *kmButtonImages = [[NSMutableArray alloc] init];
    
    [kmButtonImages addObject:[UIImage imageNamed:@"button_km_red"]];
    [kmButtonImages addObject:[UIImage imageNamed:@"button_km_red"]];
    [kmButtonImages addObject:[UIImage imageNamed:@"button_km_red"]];
    [kmButtonImages addObject:[UIImage imageNamed:@"button_km_red"]];
    [kmButtonImages addObject:[UIImage imageNamed:@"button_km_red"]];
    
    return kmButtonImages;
}

- (NSMutableArray *)kmButtonHoverImages
{
    NSMutableArray *kmButtonHoverImages = [[NSMutableArray alloc] init];
    
    [kmButtonHoverImages addObject:[UIImage imageNamed:@"button_km_hover_red"]];
    [kmButtonHoverImages addObject:[UIImage imageNamed:@"button_km_hover_red"]];
    [kmButtonHoverImages addObject:[UIImage imageNamed:@"button_km_hover_red"]];
    [kmButtonHoverImages addObject:[UIImage imageNamed:@"button_km_hover_red"]];
    [kmButtonHoverImages addObject:[UIImage imageNamed:@"button_km_hover_red"]];

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

    return innerCircleImages;
}

- (NSMutableArray *)mphButtonImages
{
    NSMutableArray *mphButtonImages = [[NSMutableArray alloc] init];
    
    [mphButtonImages addObject:[UIImage imageNamed:@"button_mph_red"]];
    [mphButtonImages addObject:[UIImage imageNamed:@"button_mph_red"]];
    [mphButtonImages addObject:[UIImage imageNamed:@"button_mph_red"]];
    [mphButtonImages addObject:[UIImage imageNamed:@"button_mph_red"]];
    [mphButtonImages addObject:[UIImage imageNamed:@"button_mph_red"]];

    return mphButtonImages;
}

- (NSMutableArray *)mphButtonHoverImages
{
    NSMutableArray *mphButtonHoverImages = [[NSMutableArray alloc] init];
    
    [mphButtonHoverImages addObject:[UIImage imageNamed:@"button_mph_hover_red"]];
    [mphButtonHoverImages addObject:[UIImage imageNamed:@"button_mph_hover_red"]];
    [mphButtonHoverImages addObject:[UIImage imageNamed:@"button_mph_hover_red"]];
    [mphButtonHoverImages addObject:[UIImage imageNamed:@"button_mph_hover_red"]];
    [mphButtonHoverImages addObject:[UIImage imageNamed:@"button_mph_hover_red"]];
    
    return mphButtonHoverImages;
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

- (UIImageView *)slopeBackgroundImageView
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

- (UIImage *)settingBackgroundImage
{
    if (self.screenRect.size.width == 480 && self.screenRect.size.height == 320) {
        return [UIImage imageNamed:@"user_red_background"];
    } else if (self.screenRect.size.width == 568 && self.screenRect.size.height == 320) {
        return [UIImage imageNamed:@"user_red_background"];
    } else if (self.screenRect.size.width == 667 && self.screenRect.size.height == 375) {
        return [UIImage imageNamed:@"user_red_background"];
    } else if (self.screenRect.size.width == 736 && self.screenRect.size.height == 414) {
        return [UIImage imageNamed:@"user_red_background"];
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

@end
