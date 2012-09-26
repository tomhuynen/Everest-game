//
//  TimeWindow.m
//  everest game
//
//  Created by Tom Huynen on 9/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MaterialChoice.h"

@interface MaterialChoice (PrivateMethods)
-(void)display;
-(void)setup;
@end;

@implementation MaterialChoice

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


@end
