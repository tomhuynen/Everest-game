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

-(id)initWithId:(int)i
{
    if(self = [super init])
    {
        climberId = i;
        
        [self setup];
        [self display];
    }
    
    return self;
}

-(void)setup
{
    
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