//
//  TimeWindow.m
//  everest game
//
//  Created by Tom Huynen on 9/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "TimeWindow.h"

@interface TimeWindow (PrivateMethods)
-(void)display;
-(void)setup;
@end;

@implementation TimeWindow

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

-(void)calculate
{
    //formule hierzo
}

@end
