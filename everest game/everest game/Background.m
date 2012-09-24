//
//  Background.m
//  everest game
//
//  Created by Tom Huynen on 9/23/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Background.h"
#import "Utils.h"

@interface Background (PrivateMethods)
-(void) display;
@end


@implementation Background


-(id) init
{
	if( (self=[super init])) {
		
        //utils = [Utils current];
        
        [self display];
	}
	return self;
}

-(void)display
{
    bgHolder = [CCSprite node];
    fgHolder = [CCSprite node];
    bgDay = [CCSprite spriteWithFile:@"mountainDay.jpg"];
    bgNight = [CCSprite spriteWithFile:@"mountainNight.jpg"];
    
    bgDay.anchorPoint = ccp(0, 0);
    bgNight.anchorPoint = ccp(0, 0);
    
    [fgHolder addChild: bgDay];
    [fgHolder addChild: bgNight];
    [self addChild:bgHolder];
    [self addChild:fgHolder];
    
    
}

@end
