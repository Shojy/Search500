//
//  Image.m
//  Search500
//
//  Created by offline on 06/11/2015.
//  Copyright © 2015 moon. All rights reserved.
//

#import "Image.h"

@interface Image ()

@end

@implementation Image

+ (void)searchForImagesWithTerms:(NSString *)searchTerms andSuccessBlock:(void (^)(AFHTTPRequestOperation *, NSDictionary *))callbackSuccessBlock andPageNumber:(NSInteger)pageNumber
{
    [self searchForImagesWithTerms:searchTerms andSuccessBlock:callbackSuccessBlock andFailureBlock:nil andPageNumber:pageNumber];
}
+ (void)searchForImagesWithTerms:(NSString *)searchTerms andSuccessBlock:(void (^)(AFHTTPRequestOperation *, NSDictionary *))callbackSuccessBlock
{
    [self searchForImagesWithTerms:searchTerms andSuccessBlock:callbackSuccessBlock andFailureBlock:nil andPageNumber:1];
}

+ (void)searchForImagesWithTerms:(NSString *)searchTerms andSuccessBlock:(void (^)(AFHTTPRequestOperation *, NSDictionary *))callbackSuccessBlock andFailureBlock:(void (^)(NSError *))callbackFailureBlock
{
    [self searchForImagesWithTerms:searchTerms andSuccessBlock:callbackSuccessBlock andFailureBlock:callbackFailureBlock andPageNumber:1];
}

+ (void)searchForImagesWithTerms:(NSString *)searchTerms andSuccessBlock:(void (^)(AFHTTPRequestOperation *, NSDictionary *))callbackSuccessBlock andFailureBlock:(void (^)(NSError *))callbackFailureBlock andPageNumber:(NSInteger)pageNumber
{
    NSString *consumerKey = @"qgiGTQvdDCmI5gEJepu2WT0hVUxpdVyq4peZCrwQ";
    NSString *baseApiSearch = @"https://api.500px.com/v1/photos/search";
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    [dictionary setValue:consumerKey forKey:@"consumer_key"];
    [dictionary setValue:searchTerms forKey:@"term"];
    [dictionary setValue:[NSString stringWithFormat:@"%zd", pageNumber] forKey:@"page"];

    
    
    [manager GET:baseApiSearch
      parameters: dictionary
         success:callbackSuccessBlock
         failure:^(AFHTTPRequestOperation *operation, NSError *error){
             callbackFailureBlock(error);
         }];
    
}

- (void)getDetailsWithSuccessBlock:(void (^)(AFHTTPRequestOperation *, NSDictionary *))callbackSuccessBlock andFailureBlock:(void (^)(NSError *))callbackFailureBlock
{
    NSString *api = [NSString stringWithFormat:@"https://api.500px.com/v1/photos/%@", self.imageId];
    
    NSString *consumerKey = @"qgiGTQvdDCmI5gEJepu2WT0hVUxpdVyq4peZCrwQ";
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    [dictionary setValue:consumerKey forKey:@"consumer_key"];
    
    
    [manager GET:api
      parameters: dictionary
         success:callbackSuccessBlock

         failure:^(AFHTTPRequestOperation *operation, NSError *error){
         }];
}

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [self init];
    
    self.title = dictionary[@"name"];
    self.author = dictionary[@"user"][@"fullname"];
    self.thumbnailUrl = [NSURL URLWithString:dictionary[@"image_url"]];
    self.imageId = dictionary[@"id"];
    
    //[self getDetails];
    
    return self;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"%@, %@", self.title, self.author];
}

@end
