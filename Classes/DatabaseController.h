//
//  DatabaseController.h
//  SmartWidget
//
//  Created by Shahil Shah on 02/07/12.
//  Copyright (c) 2012 kraftwebsolutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DatabaseController : NSObject 

- (NSMutableArray*)selectFromEscala:(NSString*)sql;
- (NSMutableArray*)selectFromPreguntas:(NSString*)sql;
- (NSDictionary*)getResultString:(NSString*)sql;
- (NSString*)getTestDescription:(NSString*)sql;
@end
