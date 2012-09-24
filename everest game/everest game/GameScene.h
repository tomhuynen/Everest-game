//
//  HelloWorldLayer.h
//  everest game
//
//  Created by Tom Huynen on 9/21/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "Background.h"
#import "Routes.h"
#import "Utils.h"

// HelloWorldLayer
@interface GameScene : CCLayer
{
    Utils *utils;
    Background *background;
    Routes *routes;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
