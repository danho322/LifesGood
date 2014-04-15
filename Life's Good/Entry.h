//
//  Entry.h
//  Life's Good
//
//  Created by Daniel on 4/11/14.
//  Copyright (c) 2014 Worthless Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@interface Entry : NSObject

@property EntryType entryType;
@property (nonatomic, strong) NSString* entryText;
@property (nonatomic, strong) NSArray* peopleArray;

@end
