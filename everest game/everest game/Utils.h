//
//  Utils.h
//  everest game
//
//  Created by Tom Huynen on 9/23/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Utils : CCNode {
    
    uint sw;
    uint sh;
}

+(Utils*) current;
-(CGPoint) relativePointByCoordinates:(int)x  ypos:(int)y;


@end
