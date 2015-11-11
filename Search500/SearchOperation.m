//
//  SearchOperation.m
//  Search500
//
//  Created by offline on 06/11/2015.
//  Copyright © 2015 moon. All rights reserved.
//

#import "SearchOperation.h"

@implementation SearchOperation

-(void) main
{
    NSLog(@"SEARCHING");
    sleep(1);
    if (![self isCancelled]) {
        self.runSearch(self.searchTerm);
    } else {
        NSLog(@"Cancelled");
    }
    
}

@end
