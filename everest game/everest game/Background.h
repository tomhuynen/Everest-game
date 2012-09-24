//
//  Background.h
//  everest game
//
//  Created by Tom Huynen on 9/23/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Utils.h"


@interface Background : CCLayer {
        
    Utils *utils;
    
    CCSprite *bgHolder;
    CCSprite *fgHolder;
    CCSprite *bgDay;
    CCSprite *bgNight;
    CCSprite *fgDay;
    CCSprite *fgNight;
}

@end