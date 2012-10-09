//
//  SummitCamp.m
//  everest game
//
//  Created by Tom Huynen on 9/25/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "SummitCamp.h"
#import "Camp.h"

@interface SummitCamp (PrivateMethods)
-(void) display;
@end

@implementation SummitCamp

-(void) display
{
    [super display];
    
    bar = [Bar node];
    [boxHolder addChild:bar];
    bar.position = ccp(0, -[utils relativeDistance:15 horizontal:NO]);
}

@end
