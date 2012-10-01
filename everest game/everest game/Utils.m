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
        CGSize size = [[CCDirector sharedDirector] winSize];
        sw = size.width;
        sh = size.height;
	}
	
    return self;
}

+(Utils*) current
{
    if (current == nil)
    {
        current = [[Utils alloc] init];
    }
    
    return current;
}


-(CGPoint)relativePointByCoordinates:(int)x ypos:(int)y
{
    int wOriginal = 1024;
    int hOriginal = 768;
    
    float newX = (x * sw) / wOriginal;
    float newY = (y * sh) / hOriginal;

    return CGPointMake(newX, newY);
}

-(float)relativeDistance:(int)d horizontal:(BOOL)h
{
    if(h == YES)
    {
        int hOriginal = 768;
        float newY = (d * sh) / hOriginal;
        return newY;
    }
    else
    {
        int wOriginal = 1024;
        float newX = (d * sw) / wOriginal;
        return newX;
    }
}


@end





