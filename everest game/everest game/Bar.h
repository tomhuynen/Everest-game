//
//  Bar.h
//  everest game
//
//  Created by Tom Huynen on 9/25/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Bar : CCNode
{
    float percentage;
    CCSprite *holder;
    CCSpriteBatchNode *barBatch;
}

@end
