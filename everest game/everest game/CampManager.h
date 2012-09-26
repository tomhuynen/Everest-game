//
//  CampManager.h
//  everest game
//
//  Created by Tom Huynen on 9/24/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "utils.h"
#import "TimeNotifiableProtocol.h"

@interface CampManager : CCLayer <TimeNotifiableProtocol>
{
    
    int campIdBeforeClimberMove;
    int campIdAfterClimberMove;
    
    NSArray *positions;
    NSArray *heights;
    NSArray *distances;
    NSArray *boxRights;
    NSArray *panelPositions;
    
    Utils *utils;
}

@property (nonatomic, retain) NSArray *positions;
@property (nonatomic, retain) NSArray *panelPositions;

+(CampManager *)current;

@end
