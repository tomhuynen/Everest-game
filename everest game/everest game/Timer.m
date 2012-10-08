//
//  TimeWindow.m
//  everest game
//
//  Created by Tom Huynen on 9/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Timer.h"

@interface Timer (PrivateMethods)
-(void)display;
-(void)setup;
@end;

@implementation Timer

static Timer* current;

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
    users = [[NSMutableArray alloc] init];
}

-(void)display
{
    
}

-(void)registerUser: (CCNode*)user
{
    [users addObject:user];
}

-(void)removeUser: (CCNode*)userToRemove
{
    for(id user in users) {
        if([user isEqual:userToRemove]) {
            [users removeObject:user];
            break;
        }
    }
}

-(void)notifyTurn
{

}

-(void)notifyTime
{

}

+(Timer*) current
{
    if (current == nil)
    {
        current = [[Timer alloc] init];
    }
    
    return current;
}

-(void)dealloc
{
    [super dealloc];
    [users release];
    
    //onderzoeken of objecten die in deze array komen ook gereleased moeten worden;
}


@end
