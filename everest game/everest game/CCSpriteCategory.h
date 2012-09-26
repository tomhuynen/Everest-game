#import "cocos2d.h"


@interface CCSprite (Touch)

- (BOOL)containsTouchLocation:(UITouch *)touch;

@property(nonatomic, readonly) CGRect rect;
@property(nonatomic, readonly) CGRect rectInPixels;

@end
