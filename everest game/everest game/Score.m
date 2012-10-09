//
//  Score.m
//  everest game
//
//  Created by Tom Huynen on 9/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Score.h"

@interface Score (PrivateMethods)
-(void)display;
-(void)setup;
@end;


@implementation Score

-(id)init
{
    if(self = [super init])
    {
        [self setup];
        [self display];
    }
    
    return self;
}

-(void)setup
{
    utils = [Utils current];
    value = 0;
}

-(void)display
{
    background = [CCSprite spriteWithFile:@"score.png"];
    scoretxt = [CCLabelBMFont labelWithString:@"0.00" fntFile:@"scoretxt.fnt"];
    
    self.position = [utils relativePointByCoordinates:926 ypos:664];
    
    
    [self addChild:background];
    [self addChild:scoretxt];
    

}

-(void)addAmount:(int)v
{
    value += v;
}

@end







