//
//  Climber.m
//  everest game
//
//  Created by Tom Huynen on 9/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Climber.h"

@interface Climber (PrivateMethods)
-(void)display;
-(void)setup;
@end

@implementation Climber

@synthesize image;
@synthesize campId;
@synthesize positionOnStartMove;
@synthesize campPositionId;
@synthesize diameter;
@synthesize radius;
@synthesize startDragPosition;
@synthesize leftPanelPosition;
@synthesize isInArray;


-(id)initWithId:(int)i campPositionId: (int)cp
{
    if(self = [super init])
    {
        climberId = i;
        campPositionId = cp;
        
        [self setup];
        [self display];
    }
    
    return self;
}

-(void)setup
{
    isInArray = YES;
    utils = [Utils node];
    campId = 0;
    diameter = [utils relativeDistance:50 horizontal:YES];
    radius = [utils relativeDistance:27 horizontal:YES];
}

-(void)display
{
    image = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"climber%d.png", climberId]];
    [self addChild:image];
}

-(void)scaleUp
{

}

-(void)scaleDown
{

}

@end