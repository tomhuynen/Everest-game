//
//  MaterialChoice.h
//  everest game
//
//  Created by Tom Huynen on 9/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Utils.h"
#import "CampManager.h"

@interface MaterialChoice : CCLayer {
    
    Utils *utils;
    CampManager *campManager;
    
    int lastAmountChoosen;
    int materialFromCampId;
    int materialToCampId;
    BOOL amountIsChosen;
    BOOL isActive;
    
    CCSprite *fade;
    CCSprite *holder;
    
    int rectWidth;
    int rectHeight;
    
    CGRect bb0;
    CGRect bb1;
    CGRect bb2;
    CGRect bb3;
    
    NSArray *bbs;
    NSArray *materialAmounts;
}

+(MaterialChoice*) current;
-(void)show: (int)campFrom targetCamp:(int)campTo;

@property int lastAmountChoosen;

@end
