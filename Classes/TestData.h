//
//  TestData.h
//  WindowBasedApplication
//
//  Created by Shahil Shah on 16/07/12.
//  Copyright (c) 2012 kraftwebsolutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#define TOTAL_ROWS 7
@interface TestData : NSObject {
    int _escala_id, *_v, _orden, _multiple, *_isSelected;
    NSString *_pregunta, *_imageName;
    NSString *_r1, *_r2, *_r3, *_r4, *_r5, *_r6, *_r7;
}

@property(nonatomic, copy)NSString *pregunta, *imageName;
@property(nonatomic)int *isSelected;
@property(nonatomic, copy)NSString *r1, *r2, *r3, *r4, *r5, *r6, *r7;
//@property(nonatomic)int escala_id, v[0], v[1], v[2], v[3], v[4], v[5], v[6], orden, multiple;
@property(nonatomic)int escala_id, *v, orden, multiple;


- (int)getTotalValidOptions;
@end
