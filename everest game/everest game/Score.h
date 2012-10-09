//
//  Score.h
//  everest game
//
//  Created by Tom Huynen on 9/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Utils.h"

@interface Score : CCNode
{
    int value;
    
    Utils *utils;
    CCSprite *background;
    CCLabelBMFont *scoretxt;
}

-(void)addAmount:(int)v;

@end
