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
    NSArray *spaceCampToBox;
    NSMutableArray *camps;
    CCSpriteBatchNode *campBatch;
    CCSpriteBatchNode *boxBatch;
    
    Utils *utils;
}

@property (nonatomic, retain) NSArray *spaceCampToBox;
@property (nonatomic, retain) NSArray *positions;
@property (nonatomic, retain) NSArray *boxRights;
@property (nonatomic, retain) NSMutableArray *camps;
@property (nonatomic, retain) CCSpriteBatchNode *campBatch;

+(CampManager *)current;
-(void) addMaterial: (int)amount camp:(int)id;
-(void) removeMaterial: (int)amount camp:(int)id;

@end
