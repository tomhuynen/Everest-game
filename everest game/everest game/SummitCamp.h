//
//  SummitCamp.h
//  everest game
//
//  Created by Tom Huynen on 9/25/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Camp.h"
#import "Bar.h"

@interface SummitCamp : Camp {
    
    Bar *bar;
    float percentage;
}

@end
