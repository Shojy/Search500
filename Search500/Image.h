//
//  Image.h
//  Search500
//
//  Created by offline on 06/11/2015.
//  Copyright © 2015 moon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@import UIKit;

@interface Image : NSObject
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *author;
@property (strong, nonatomic) UIImage *thumbnailImage;
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) NSURL *thumbnailUrl;
@property (strong, nonatomic) NSURL *imageUrl;
@property (strong, nonatomic) NSString *imageId;

+ (void)searchForImagesWithTerms:(NSString *)searchTerms andSuccessBlock:(void (^)(AFHTTPRequestOperation *, NSDictionary *))callbackSuccessBlock;

+ (void)searchForImagesWithTerms:(NSString *)searchTerms andSuccessBlock:(void (^)(AFHTTPRequestOperation *, NSDictionary *))callbackSuccessBlock andPageNumber:(NSInteger)pageNumber;

+ (void)searchForImagesWithTerms:(NSString *)searchTerms andSuccessBlock:(void (^)(AFHTTPRequestOperation *, NSDictionary *))callbackSuccessBlock andFailureBlock:(void (^)(NSError *))callbackFailureBlock;

+ (void)searchForImagesWithTerms:(NSString *)searchTerms andSuccessBlock:(void (^)(AFHTTPRequestOperation *, NSDictionary *))callbackSuccessBlock andFailureBlock:(void (^)(NSError *))callbackFailureBlock andPageNumber:(NSInteger)pageNumber;

- (void)getDetailsWithSuccessBlock:(void (^)(AFHTTPRequestOperation *, NSDictionary *))callbackSuccessBlock andFailureBlock:(void (^)(NSError *))callbackFailureBlock;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
