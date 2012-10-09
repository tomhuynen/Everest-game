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
#import "Camp.h"

@interface ClimberManager : CCLayer <TimeNotifiableProtocol>
{
    Utils *utils;
    NSMutableArray *climbers;
    CCSpriteBatchNode *climberBatch;
    Climber *movingClimber;
    CCSprite *platform;
    Camp *campLeftByClimber;
    
    int climberSpacing;
    int currentPanelId;
    CGRect panel0boundingBox;
    CGRect panel1boundingBox;
    CGRect panel2boundingBox;
    CGRect panel3boundingBox;
    CGRect panel4boundingBox;
    NSArray *panelBoundingBoxes;
    NSArray *panelRights;
    
    NSMutableArray *panelClimberCamp0;
    NSMutableArray *panelClimberCamp1;
    NSMutableArray *panelClimberCamp2;
    NSMutableArray *panelClimberCamp3;
    NSMutableArray *panelClimberCamp4;
    NSMutableArray *platFormPositions;
    NSArray *panelClimbers;
}

+(ClimberManager*) current;
-(void)calculateCondition:(int)id;
-(void)summitAttempt;
-(void)removeClimber:(int)id;




@end
