//
//  GoodsShonp_DB.h
//  嘀嘀点呗
//
//  Created by xgy on 2018/5/29.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabaseQueue.h"
#import "FMDatabase.h"
#import "GoodsShopModel.h"

@interface GoodsShonp_DB : NSObject

@property (nonatomic,strong)NSString *m_dbPath;

@property (retain, nonatomic) FMDatabase *m_db;

@property(nonatomic,retain) FMDatabaseQueue *dbQueue;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *menuName;

+ (instancetype)shareInstance;

- (NSString *)getDbPath;

- (BOOL)DeleteAll;

-(BOOL)dropTable;

- (BOOL)createDBWithPath:(NSString*)path withTablename:(NSString *)name;

- (BOOL)createMemuDBWithPath:(NSString*)path withTablename:(NSString *)name;

@end

@interface GoodsShonp_DB (goodshop_footprint)

- (BOOL)addFootprintInfoWtihDict:(NSDictionary *)dict;

- (BOOL)deleteFootprintInfo:(GoodsShopModel *)info;

- (NSMutableArray *)getFootprintInfoArray;

- (NSMutableArray *)getFootprintGoodsforAttriteInfoArrayforkey:(NSString *)goodid andstorid:(NSString *)storeid;

- (NSMutableArray *)getFootprintSpecsforAttriteInfoArrayforkey:(NSString *)goodid  andSpecid:(NSString *)specid  AttributeName:(NSString *) attributename  storeid:(NSString *)storeid;

- (NSMutableArray *)getFootprintGoodsforstoreInfoArrayforkey:(NSString *)storeid;

- (NSMutableArray *)getFootprintGoodsforMarkingInfoArrayforkey:(NSString *)marking;

@end
