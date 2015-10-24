//
//  STAnnotation.h
//  Axiz Brain Blue
//
//  Created by 左藤樹洋 on 2014/06/19.
//  Copyright (c) 2014年 Tatsuhiro Sato. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface STAnnotation : NSObject <MKAnnotation>{
    
    CLLocationCoordinate2D coordinate;
    NSString *title;
    
}

@property(nonatomic)CLLocationCoordinate2D coordinate;
@property(nonatomic, copy) NSString *title;

-(id)initWithCoordinate:(CLLocationCoordinate2D)co;

@end