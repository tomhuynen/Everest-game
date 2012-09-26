//
//  Climber.h
//  everest game
//
//  Created by Tom Huynen on 9/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Climber : CCSprite
{
    int climberId;
    int condition;
    int campId;
    int panelPosition;
    
    CCSprite *image;
}

-(void)scaleUp;
-(void)scaleDown;
-(id)initWithId:(int)i;

@end
