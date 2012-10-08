//
//  Routes.m
//  everest game
//
//  Created by Tom Huynen on 9/23/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Camp.h"
#import "Utils.h"
#import "CampManager.h"

@interface Camp (PrivateMethods)
-(void) setup;
@end


@implementation Camp
@synthesize campId;
@synthesize material;

-(id) initWithId:(int)i height:(int)h distance:(int)d boxRight:(int)br
{
    if( (self=[super init]))
    {
        utils = [Utils current];
        
        campId = i;
        height = h;
        distance = d;
        boxRight = br;
        
        [self display];
	}
	return self;
}

-(void)display
{
    imgHolder = [CCSprite node];
    imgNight = [CCSprite node];
    imgDay = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"camp%d.png", campId]];
    boxHolder = [CCSprite node];
    box = [CCSprite spriteWithSpriteFrameName:@"box1.png"];
    
    boxHolder.position = ccp(boxRight * [[[CampManager current].spaceCampToBox objectAtIndex:campId] integerValue], 0);
    
    [self addChild:imgHolder];
    [imgHolder addChild:imgNight];
    [imgHolder addChild:imgDay];
    [imgHolder addChild:boxHolder];
    [boxHolder addChild:box];
}

- (void) setup
{
    
}

-(void) dealloc
{
    [super dealloc];
}

@end