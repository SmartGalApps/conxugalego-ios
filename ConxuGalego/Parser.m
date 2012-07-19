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
//  Parser.m
//  ConxuGalego
//
//  Created by Xurxo Méndez Pérez on 06/01/12.
//  Copyright (c) 2012 ninguna. All rights reserved.
//

#import "Parser.h"
#import "Verbaltime.h"

@implementation Parser
@synthesize delegate;

-(void)parse:(NSString *) text {
    NSArray *split1 = [text componentsSeparatedByString:@"\n"];
    
    int badTimes = 0;
    for (NSString* s in split1) {
        if ([s isEqualToString:@"Não foi reconhecido como verbo. Tente de novo"]) {
            badTimes++;
        }
    }
    
    NSMutableArray * theResult = [[NSMutableArray alloc] initWithCapacity:[split1 count] - badTimes];
    
    for (int i = 0; i < [split1 count]; i++) {
        NSString *verbalTimeString = [split1 objectAtIndex:i];
        NSArray *split2 = [verbalTimeString componentsSeparatedByString:@":"];
        NSMutableArray *vTimes = [[NSMutableArray alloc] initWithCapacity:[split2 count] -1];
        for (int j = 1; j < [split2 count]; j++) {
            [vTimes insertObject:[split2 objectAtIndex:j] atIndex:j - 1];
        }
        if ([vTimes count] != 0) {
            VerbalTime *verbalTime = [[VerbalTime alloc] initWithName:[split2 objectAtIndex:0] times:vTimes];
            [theResult insertObject:verbalTime atIndex:i];
        }
        
    }
    
    [theResult sortUsingSelector:@selector(compare:)];
    if ([theResult count] == 0)
    {
        [self.delegate doOnNotFound];
        return;
    }
    [self.delegate doOnSuccess:theResult];
}

@end

