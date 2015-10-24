//
//  STAnnotation.m
//  Axiz Brain Blue
//
//  Created by 左藤樹洋 on 2014/06/19.
//  Copyright (c) 2014年 Tatsuhiro Sato. All rights reserved.
//

#import "STAnnotation.h"

@implementation STAnnotation

@synthesize coordinate;
@synthesize title;

-(id)initWithCoordinate:(CLLocationCoordinate2D)co{
    coordinate = co;
    return self;
}

@end