/*
 * This file is part of ConxuGalego.

 * ConxuGalego is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.

 * ConxuGalego is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.

 * You should have received a copy of the GNU General Public License
 * along with ConxuGalego.  If not, see <http://www.gnu.org/licenses/>.
 */
//
//  VerbalTime.m
//  ConxuGalego
//
//  Created by Xurxo Méndez Pérez on 06/01/12.
//  Copyright (c) 2012 ninguna. All rights reserved.
//

#import "VerbalTime.h"

@implementation VerbalTime
@synthesize name;
@synthesize order;
@synthesize times;

- (id) initWithName: (NSString *)aName times: (NSArray *) theTimes {
    if (self = [super init])
    {
        self.name = aName;
        self.times = theTimes;
        if ([name isEqualToString:@"PI"]) {
            self.order = [NSNumber numberWithInt:0];
        }
        else if ([name isEqualToString:@"EI"]) {
            self.order = [NSNumber numberWithInt:1];
        }
        else if ([name isEqualToString:@"II"]) {
            self.order = [NSNumber numberWithInt:2];
        }
        else if ([name isEqualToString:@"MI"]) {
            self.order = [NSNumber numberWithInt:3];
        }
        else if ([name isEqualToString:@"FI"]) {
            self.order = [NSNumber numberWithInt:4];
        }
        else if ([name isEqualToString:@"TI"]) {
            self.order = [NSNumber numberWithInt:5];
        }
        else if ([name isEqualToString:@"PS"]) {
            self.order = [NSNumber numberWithInt:6];
        }
        else if ([name isEqualToString:@"IS"]) {
            self.order = [NSNumber numberWithInt:7];
        }
        else if ([name isEqualToString:@"FS"]) {
            self.order = [NSNumber numberWithInt:8];
        }
        else if ([name isEqualToString:@"IP"]) {
            self.order = [NSNumber numberWithInt:9];
        }
        else if ([name isEqualToString:@"IA"]) {
            self.order = [NSNumber numberWithInt:10];
        }
        else if ([name isEqualToString:@"IN"]) {
            self.order = [NSNumber numberWithInt:11];
        }
        else if ([name isEqualToString:@"FN"]) {
            self.order = [NSNumber numberWithInt:12];
        }
    }
    return self;
}

- (NSComparisonResult)compare:(VerbalTime *)otherObject {
    return [self.order compare:otherObject.order];
}

@end

