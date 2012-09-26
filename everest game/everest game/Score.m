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
    value = 0;
}

-(void)display
{

}

-(void)addAmount:(int)v
{
    value += v;
}

@end
