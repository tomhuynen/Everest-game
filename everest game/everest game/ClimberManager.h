//
//  ClimberManager.h
//  everest game
//
//  Created by Tom Huynen on 9/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "TimeNotifiableProtocol.h"
#import "Utils.h"
#import "Climber.h"

@interface ClimberManager : CCLayer <TimeNotifiableProtocol>
{
    Utils *utils;
    NSMutableArray *climbers;
    CCSpriteBatchNode *climberBatch;
    Climber *movingClimber;
    int climberSpacing;
}

-(void)positionInCamp:(int)id;
-(void)makeRoomInCamp:(int)id;
-(void)calculateCondition:(int)id;
-(void)summitAttempt;
-(void)removeClimber:(int)id;


@end
