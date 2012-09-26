//
//  TimeWindow.m
//  everest game
//
//  Created by Tom Huynen on 9/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ForeCast.h"

@interface ForeCast (PrivateMethods)
-(void)display;
-(void)setup;
@end;

@implementation ForeCast

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
    
}

-(void)display
{
    
}

-(void)updateTime:(int)time
{

}

-(void)updateTurn:(int)turn
{

}

@end
