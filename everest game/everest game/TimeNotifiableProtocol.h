//
//  TimeNotifiableProtocol.h
//  everest game
//
//  Created by Tom Huynen on 9/26/12.
//
//

#import <Foundation/Foundation.h>

@protocol TimeNotifiableProtocol
-(void)updateTime:(int)time;
-(void)updateTurn:(int)turn;
@end
