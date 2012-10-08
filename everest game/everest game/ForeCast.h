//
//  ForeCast.h
//  everest game
//
//  Created by Tom Huynen on 9/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "TimeNotifiableProtocol.h"
#import "Utils.h"

@interface ForeCast : CCLayer <TimeNotifiableProtocol>
{
    NSArray *weather;
    NSArray *weatherTypes;
    BOOL dragging;
    Utils *utils;
    int w;
    int h;
    int sliderMinPos;
    int sliderMaxPos;
    CCSprite *background;
    CCSprite *weatherHolder;
    CCSprite *sliderHolder;
    CCSprite *slider;
    CCSpriteBatchNode *forCastBatch;
}



@end
