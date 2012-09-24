//
//  Utils.m
//  everest game
//
//  Created by Tom Huynen on 9/23/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Utils.h"


@implementation Utils

static Utils* current;

-(id) init
{
	if( (self=[super init]))
    {
        NSAssert1(current == nil, @"utils instance allready exists", NSStringFromClass([self class]));
        current = self;
        
        CGSize size = [[CCDirector sharedDirector] winSize];
        sw = size.width;
        sh = size.height;
	}
	
    return self;
}

+(Utils*) current
{
    NSAssert1(current == nil, @"utils not yet available", NSStringFromClass([self class]));
    
    return current;
}

-(CGPoint)relativePointByCoordinates:(int)x ypos:(int)y
{
    int w = 1024;
    int h = 786;
    
    float newX = (x * sw) / w;
    float newY = (y * sh) / h;
    
    return CGPointMake(newX, newY);
}


@end





