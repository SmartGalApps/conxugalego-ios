//
//  VerbalTime.h
//  ConxuGalego
//
//  Created by Xurxo Méndez Pérez on 06/01/12.
//  Copyright (c) 2012 ninguna. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VerbalTime : NSObject {
    NSString *name;
    NSNumber *order;
    NSArray *times;
}

@property (retain) NSString *name;
@property (retain) NSNumber *order;
@property (retain) NSArray *times;

- (id) initWithName: (NSString *)name times: (NSArray *) times;

- (NSComparisonResult)compare:(VerbalTime *)otherObject;

@end
