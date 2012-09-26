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
#import "TimeNotifiableProtocol.h"

@interface Routes : CCLayer <TimeNotifiableProtocol>
{
    
    Utils *utils;
    NSMutableArray *blockedRoutes;
    
    CCSprite *routesHolder;
    CCSprite *blockHolder;
    
    int blockedIndex;
}

-(void)blockRoute:(int)index;
-(BOOL)getPermissionToCross:(int)route;

@end
