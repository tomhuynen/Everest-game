//
//  Timer.h
//  everest game
//
//  Created by Tom Huynen on 9/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Timer : CCNode
{
    NSMutableArray *users;
    int turn;
    int time;
}

-(void)registerUser: (CCNode*)user;
-(void)removeUser: (CCNode*)userToRemove;
-(void)notifyTurn;
-(void)notifyTime;



@end
