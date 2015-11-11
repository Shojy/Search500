//
//  SearchOperation.h
//  Search500
//
//  Created by offline on 06/11/2015.
//  Copyright © 2015 moon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchOperation : NSOperation
@property (strong, nonatomic) NSString *searchTerm;
@property (nonatomic,copy)void (^runSearch)(NSString *searchTerm);
@end
