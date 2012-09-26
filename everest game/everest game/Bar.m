//
//  Bar.m
//  everest game
//
//  Created by Tom Huynen on 9/25/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Bar.h"

@interface Bar (PrivateMethods)
-(void)display;
-(void)setup;
@end;


@implementation Bar

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
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"bar.plist"];
    barBatch = [CCSpriteBatchNode batchNodeWithFile:@"bar.png"];
}

-(void)display
{
    holder = [CCSprite spriteWithSpriteFrameName:@"bar4.png"];
    [self addChild:holder];
}

@end
