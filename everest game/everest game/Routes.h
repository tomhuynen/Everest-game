//
//  Routes.h
//  everest game
//
//  Created by Tom Huynen on 9/23/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Utils.h"

@interface Routes : CCLayer {
    
    Utils *utils;
    NSArray *routes;
    
    CCSprite *routesHolder;
    CCSprite *blockHolder;
    
    int blockedIdex;
    
}

@end
