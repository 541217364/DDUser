

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,ColorType){
    ClearColor   = 0,
    GrayColor,
    WhithColor
};

@interface TRCommonView : UIView

@property (nonatomic) BOOL  tr_show;

@property (nonatomic,assign) int trp_type;

@property (nonatomic, copy) void (^callbackChangeState) ();

@property (nonatomic, copy) void (^callbackParams) (NSArray * array);

- (id)initWithFrame:(CGRect)frame withData:(NSArray *)paramData;
@end


