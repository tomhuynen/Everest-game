//
//  Climber.h
//  everest game
//
//  Created by Tom Huynen on 9/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Utils.h"

@interface Climber : CCSprite
{
    Utils *utils;
    
    int climberId;
    int condition;
    int campId;
    int campPositionId;
    int panelPosition;
    int diameter;
    int radius;
    BOOL isInArray;
    CGPoint startDragPosition;
    CGPoint leftPanelPosition;
    CGPoint positionOnStartMove;
    
    CCSprite *image;
}

-(void)scaleUp;
-(void)scaleDown;
-(id)initWithId:(int)i campPositionId: (int)cp;

@property (nonatomic, retain) CCSprite *image;
@property int campId;
@property int campPositionId;
@property int diameter;
@property int radius;
@property BOOL isInArray;
@property CGPoint positionOnStartMove;
@property CGPoint startDragPosition;
@property CGPoint leftPanelPosition;

@end
