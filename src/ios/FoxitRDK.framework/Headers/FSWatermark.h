/* ----------------------------------------------------------------------------
 * This file was automatically generated by SWIG (http://www.swig.org).
 * Version 2.0.6
 *
 * This file is not intended to be easily readable and contains a number of
 * coding conventions designed to improve portability and efficiency. Do not make
 * changes to this file unless you know what you are doing--modify the SWIG
 * interface file instead.
 * ----------------------------------------------------------------------------- */

#import "FSCommon.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * @brief Enumeration for watermark position in a PDF page.
 *
 * @details Values of this enumeration should be used alone.
 *          This is used in class FSWatermarkSettings for constructing a watermark.
 */
typedef NS_OPTIONS(NSUInteger, FSWatermarkPosition) {
    /** @brief Watermark position: top left. */
    e_watermarkPosTopLeft = 0,
    /** @brief Watermark position: top center. */
    e_watermarkPosTopCenter = 1,
    /** @brief Watermark position: top right. */
    e_watermarkPosTopRight = 2,
    /** @brief Watermark position: center left. */
    e_watermarkPosCenterLeft = 3,
    /** @brief Watermark position: center. */
    e_watermarkPosCenter = 4,
    /** @brief Watermark position: center right. */
    e_watermarkPosCenterRight = 5,
    /** @brief Watermark position: bottom left. */
    e_watermarkPosBottomLeft = 6,
    /** @brief Watermark position: bottom center. */
    e_watermarkPosBottomCenter = 7,
    /** @brief Watermark position: bottom right. */
    e_watermarkPosBottomRight = 8
};

/**
 * @brief Enumeration for watermark setting flags.
 *
 * @details Values of this enumeration can be used alone or in combination.
 *          This is used in class FSWatermarkSettings for constructing a watermark.
 */
typedef NS_OPTIONS(NSUInteger, FSWatermarkFlags) {
    /** @brief If set, the watermark will be a part of page content when inserted to a PDF page. */
    e_watermarkFlagASPageContents = 0x0000,
    /** @brief If set, the watermark will be an annotation when inserted to a PDF page. */
    e_watermarkFlagASAnnot = 0x0001,
    /** @brief If set, show watermark above other page content. */
    e_watermarkFlagOnTop = 0x0002,
    /** @brief If set, do not print a watermark. */
    e_watermarkFlagNoPrint = 0x0004,
    /** @brief If set, do not display a watermark. */
    e_watermarkFlagInvisible = 0x0008
};

/**
 * @brief Enumeration for watermark font style.
 *
 * @details Values of this enumeration should be used alone.
 *          This is used in class FSWatermarkTextProperties for constructing a watermark from text.
 */
typedef NS_OPTIONS(NSUInteger, FSWatermarkFontStyle) {
    /** @brief Watermark font style: normal. */
    e_watermarkFontStyleNormal = 0,
    /** @brief Watermark font style: with underline. */
    e_watermarkFontStyleUnderline = 1
};

/**
 * @brief Enumeration for watermark text alignment.
 *
 * @details Values of this enumeration should be used alone.
 *          This is used in class FSWatermarkTextProperties for constructing a watermark from text.
 */
typedef NS_OPTIONS(NSUInteger, FSWatermarkTextAlignment) {
    /** @brief Text watermark alignment: left. */
    e_watermarkTextAlignmentLeft = 0,
    /** @brief Text watermark alignment: center. */
    e_watermarkTextAlignmentCenter = 1,
    /** @brief Text watermark alignment: right. */
    e_watermarkTextAlignmentRight = 2
};

@class FSWatermarkSettings;
@class FSWatermarkTextProperties;

/**
 * @brief Class to construct a watermark with specified parameters, and then inert to PDF page.
 * The watermark object can be constructed from text, bitmap or image, and PDF page.
 */
@interface FSWatermark : NSObject
{
    /** @brief SWIG proxy related property, it's deprecated to use it. */
    void *swigCPtr;
    /** @brief SWIG proxy related property, it's deprecated to use it. */
    BOOL swigCMemOwn;
}
/** @brief SWIG proxy related function, it's deprecated to use it. */
-(void*)getCptr;
/** @brief SWIG proxy related function, it's deprecated to use it. */
-(id)initWithCptr: (void*)cptr swigOwnCObject: (BOOL)ownCObject;
/**
 * @brief Construct a watermark object from specified text content.
 *
 * @param[in] document    A PDF document object, for which the constructed watermark will be used.
 *                        It should not be <b>NULL</b>.
 * @param[in] text        A text string, in UTF-8 encoding. This will be used as the content of the new watermark.
 *                        It should not be <b>NULL</b> or empty.
 * @param[in] properties  Text properties for watermark.
 * @param[in] settings    Watermark settings, containing layout setting.
 */
-(id)initWithDocument: (FSPDFDoc*)document text: (NSString *)text properties: (FSWatermarkTextProperties*)properties settings: (FSWatermarkSettings*)settings;
/**
 * @brief Get the width of current watermark.
 *
 * @return Watermark width.
 */
-(float)getWidth;
/**
 * @brief Get the height of current watermark.
 *
 * @return Watermark height.
 */
-(float)getHeight;
/**
 * @brief Insert current watermark into a PDF page.
 *
 * @details If current watermark is treated as page content (which is specified by @link FSWatermarkSettings::flags}
 *          when current watermark is constructed), Foxit PDF SDK will generate content for the input PDF page
 *          by default after the watermark is inserted successfully. In this case , if user wants to render
 *          the PDF page correctly after this function has been called successfully, user is recommended to
 *          call function {@link FSPDFPage::StartParse} with parameter <i>isReparse</i> <b>true</b>
 *          before rendering; otherwise, the page content may not be rendered as expected.
 *
 * @param[in] page  A PDF page, to which current watermark would be inserted. This page should belong to
 *                  the same document as current watermark belongs to. And the page should have been already parsed.
 *
 * @return <b>true</b> means success, while <b>false</b> means failure.
 */
-(BOOL)insertToPage: (FSPDFPage*)page;

-(void)dealloc;

@end

/**
 * @brief Class representing the watermark settings used to construct a watermark object from any supported resource.
 */
@interface FSWatermarkSettings : NSObject
{
    /** @brief SWIG proxy related property, it's deprecated to use it. */
    void *swigCPtr;
    /** @brief SWIG proxy related property, it's deprecated to use it. */
    BOOL swigCMemOwn;
}
/**
 * @brief Watermark position.
 *
 * @details Please refer to {@link FSWatermarkPosition::e_watermarkPosTopLeft FSWatermarkPosition::e_watermarkPosXXX} and this
 *          should be one of these macros.
 */
@property (nonatomic) FSWatermarkPosition position;
/** @brief Horizontal offset, in points. */
@property (nonatomic) float offset_x;
/** @brief Vertical offset, in points. */
@property (nonatomic) float offset_y;
/**
 * @brief Watermark flags.
 *
 * @details Please refer to {@link FSWatermarkFlags::e_watermarkFlagASPageContents FSWatermarkFlags::e_watermarkFlagXXX} and
 *          this can be one or a combination of these macros.
 */
@property (nonatomic) FSWatermarkFlags flags;
/** @brief Horizontal scale coefficient. It should be greater than 0.001f. */
@property (nonatomic) float scale_x;
/** @brief Vertical scale coefficient. It should be greater than 0.001f. */
@property (nonatomic) float scale_y;
/** @brief Rotation angle in degrees. */
@property (nonatomic) float rotation;
/** @brief Opacity in percents. Valid range: from 0 to 100. 0 for transparent and 100 for opaque. */
@property (nonatomic) int opacity;

/** @brief SWIG proxy related function, it's deprecated to use it. */
-(void*)getCptr;
/** @brief SWIG proxy related function, it's deprecated to use it. */
-(id)initWithCptr: (void*)cptr swigOwnCObject: (BOOL)ownCObject;
-(id)init;
/** @brief Constructor with another FSWatermarkSettings. */
-(id)initWithSettings: (FSWatermarkSettings*)settings;
/**
 * @brief Set property values.
 */
-(void)set: (FSWatermarkPosition)position offset_x: (float)offset_x offset_y: (float)offset_y flags: (unsigned int)flags scale_x: (float)scale_x scale_y: (float)scale_y rotation: (float)rotation opacity: (int)opacity;

-(void)dealloc;

@end

/**
 * @brief Class representing the watermark text settings used to construct a watermark object from text.
 */
@interface FSWatermarkTextProperties : NSObject
{
    /** @brief SWIG proxy related property, it's deprecated to use it. */
    void *swigCPtr;
    /** @brief SWIG proxy related property, it's deprecated to use it. */
    BOOL swigCMemOwn;
}

/**
 * @brief Font used for the text. Currently, not support newly created font object by creating functions in FSFont.
 *
 * @note If font object is created by creating functions in class FSFont, user should ensure to release it when not
 *       use it any more.<br>
 *       If font object is retrieved from Foxit PDF SDK, user should not release it.
 */
@property (nonatomic, strong) FSFont* font;
/** @brief Font size in points. */
@property (nonatomic) float font_size;
/** @brief Text color. Format: 0xRRGGBB.*/
@property (nonatomic) unsigned int color;
/**
 * @brief Font style.
 *
 * @details It should be one of the following values:
 *          <ul>
 *          <li>{@link FSWatermarkFontStyle::e_watermarkFontStyleNormal FSWatermarkFontStyle::e_watermarkFontStyleNormal}</li>
 *          <li>{@link FSWatermarkFontStyle::e_watermarkFontStyleUnderline FSWatermarkFontStyle::e_watermarkFontStyleUnderline}</li>
 *          </ul>
 */
@property (nonatomic) FSWatermarkFontStyle font_style;
/**
 * @brief Space between vertical center of lines, in line heights.
 *
 * @details This value is used to specify the multiple of line heights for the space between vertical center of lines.
 *          Valid range: from 0 to 10 (not including 0 but including 10). If this value is above 10, 10 will be used
 *          as default for the text watermark.
 */
@property (nonatomic) float line_space;
/**
 * @brief Text horizontal alignment.
 *
 * @details It should be one of the following macro definitions:
 *          <ul>
 *          <li>
 *            {@link FSWatermarkTextAlignment::e_watermarkTextAlignmentLeft FSWatermarkTextAlignment::e_watermarkTextAlignmentLeft}
 *          </li>
 *          <li>
 *            {@link FSWatermarkTextAlignment::e_watermarkTextAlignmentCenter FSWatermarkTextAlignment::e_watermarkTextAlignmentCenter}
 *          </li>
 *          <li>
 *            {@link FSWatermarkTextAlignment::e_watermarkTextAlignmentRight FSWatermarkTextAlignment::e_watermarkTextAlignmentRight}
 *          </li>
 *          </ul>
 */
@property (nonatomic) FSWatermarkTextAlignment alignment;

/** @brief SWIG proxy related function, it's deprecated to use it. */
-(void*)getCptr;
/** @brief SWIG proxy related function, it's deprecated to use it. */
-(id)initWithCptr: (void*)cptr swigOwnCObject: (BOOL)ownCObject;
-(id)init;
/** @brief Constructor with another FSWatermarkTextProperties. */
-(id)initWithProperties: (FSWatermarkTextProperties*)properties;
/**
 * @brief Set property values.
 */
-(void)set: (FSFont*)font font_size: (float)font_size color: (unsigned int)color style: (FSWatermarkFontStyle)style line_space: (float)line_space alignment: (FSWatermarkTextAlignment)alignment;

-(void)dealloc;

@end


NS_ASSUME_NONNULL_END
