//
//  Camp.h
//  everest game
//
//  Created by Tom Huynen on 9/24/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Utils.h"

@interface Camp : CCNode {
    
    Utils *utils;
    
    int campId;
    int height;
    int material;
    int distance;
    int boxRight;
    
    CCSprite *imgHolder;
    CCSprite *imgNight;
    CCSprite *imgDay;
    CCSprite *boxHolder;
    CCSprite *box;
    CCLabelBMFont *materialtxt;
}

-(id) initWithId:(int)i height:(int)h distance:(int)d boxRight: (int)br;
-(void)display;
-(void)addMaterial:(int)amount;
-(void)removeMaterial:(int)amount;

@property int campId;
@property int material;

@end
