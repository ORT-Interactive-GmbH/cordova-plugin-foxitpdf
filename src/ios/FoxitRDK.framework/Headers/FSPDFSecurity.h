/* ----------------------------------------------------------------------------
 * This file was automatically generated by SWIG (http://www.swig.org).
 * Version 2.0.6
 *
 * This file is not intended to be easily readable and contains a number of
 * coding conventions designed to improve portability and efficiency. Do not make
 * changes to this file unless you know what you are doing--modify the SWIG
 * interface file instead.
 * ----------------------------------------------------------------------------- */

/**
 * @file	FSPDFSecurity.h
 * @brief	This file contains definitions of object-c APIs for Foxit PDF SDK.
 */

#import "FSCommon.h"
/**
 * @brief	Enumeration for encryption type.
 *
 * @details	Values of this enumeration should be used alone.
 */
typedef NS_ENUM(NSInteger, FSEncryptType) {
    /** @brief	Unknown encryption type. */
    e_encryptUnknown = -1,
    /** @brief	No encryption pattern. */
    e_encryptNone	 = 0,
    /** @brief	Encryption type: password, which is the standard encryption. */
    e_encryptPassword,
    /** @brief	Encryption type: digital certificate encryption. */
    e_encryptCertificate,
    /** @brief	Encryption type: Foxit DRM encryption. */
    e_encryptFoxitDRM,
    /** @brief	Encryption type: customized encryption. */
    e_encryptCustom,
    /** @brief	Encryption type: Microsoft RMS encryption. */
    e_encryptRMS
};

/**
 * @brief	Class to represent the base class for other concrete security callback object.
 *
 * @note	This is just a base class. User should not inherit this class directly when implementing a security callback for any type of decryption and encryption.
 *			User should inherit any derived callback class of this base class.
 */
@interface FSSecurityCallback : NSObject
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
/** @brief Default initialization. */
-(id)init;
/**
 * @brief	Get the encryption type of current security handler.
 *
 * @return	The encryption type.
 *			Please refer to {@link FSEncryptType::e_encryptPassword FSEncryptType::e_encryptXXX} values and this would be one these values.
 */
-(FSEncryptType) getSecurityType;

/** @brief Free the object. */
-(void)dealloc;

@end

/**
 * @brief	Class to represent a callback object for certificate decryption.
 *
 * @note	User should inherit this callback class and implement the pure virtual functions (as callback functions).
 *			User can register their own certificate security callback object to Foxit PDF SDK, by function [FSLibrary registerSecurityCallback] with <i>filter</i> "Adobe.PubSec".
 *			Function [FSLibrary unregisterSecurityCallback] can be called to unregister the security callback object with the registered filter name.
 */
@interface FSCertificateSecurityCallback : FSSecurityCallback
-(id)init;
/**
 * @brief	Get the encryption type of current security callback.
 *
 * @note	Caller should not override this function, otherwise there will be unexpected behavior.
 *
 * @return	The encryption type. It would always be {@link FSEncryptType::e_encryptCertificate}.
 */
-(FSEncryptType) getSecurityType;

/**
 * @brief	Get the PKCS12 format data buffer, usually it's a .pfx file.
 *
 * @param[in]  envelope    The PKCS#7 object which is referred to as the enveloped data.
 *
 * @return  The PKCS12 format data buffer.
 */
-(NSData *)getPKCS12: (NSData*)envelope;

/**
 * @brief	Get the password for the PKCS12 format data.
 *
 * @param[in]  pkcs12    The PKCS12 format data buffer.
 *
 * @return	The password string used to parse the PKCS12 object.
 */
-(NSString *)getPasswordForPKCS12: (NSData*)pkcs12;

-(void)dealloc;
@end

/**
 * @brief   Enumeration for Encryption Algorithm.
 *
 * @details Values of this enumeration should be used alone.
 */
typedef NS_ENUM(NSUInteger, FSCipherType) {
    /** @brief  Not use encryption algorithm. */\
    e_cipherNone = 0,
    /** @brief  Use RC4 encryption algorithm, with the key length between 5-bytes and 16-bytes. */\
    e_cipherRC4,
    /** @brief  Use AES encryption algorithm, with the key length be 16-bytes or 32-bytes. */\
    e_cipherAES
};


/**
 * @brief	Class to represent a security handler, used for encrypting PDF document.
 *
 * @details	Class ::FSSecurityHandler is the base class. It has following derived classes:
 *			<ul>
 *			<li> Class ::FSStdSecurityHandler is used for password encryption. </li>
 *			<li> Class ::FSCertificateSecurityHandler is used for certificate encryption.</li>
 *			</ul>
 *			To set a security handler to a PDF document, please call function {@link FSPDFDoc::setSecurityHandler:}, then the security handler will take effect during next saving process.
 *			To get the security handler used for a PDF document, please call function {@link FSPDFDoc::setSecurityHandler:}.
 */
@interface FSSecurityHandler : NSObject
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
 * @brief	Get the encryption type of current security handler.
 *
 * @return	The encryption type.
 *			Please refer to {@link FSEncryptType::e_encryptPassword FSEncryptType::e_encryptXXX} values and this would be one these values.
 */
-(FSEncryptType) getSecurityType;

/** @brief Free the object. */
-(void)dealloc;

@end

/**
 * @brief	Class to represent a security handler, used for encrypting PDF document.
 *
 * @details	Class ::FSSecurityHandler is the base class. It has following derived classes:
 *			<ul>
 *			<li> Class ::FSStdSecurityHandler is used for password encryption. </li>
 *			<li> Class ::FSCertificateSecurityHandler is used for certificate encryption.</li>
 *			</ul>
 *			To set a security handler to a PDF document, please call function {@link FSPDFDoc::setSecurityHandler:}, then the security handler will take effect during next saving process.
 *			To get the security handler used for a PDF document, please call function {@link FSPDFDoc::setSecurityHandler:}.
 */
@interface FSStdSecurityHandler : FSSecurityHandler

-(id)init;
/**
 * @brief Initialize the standard security handler.
 *
 * @param[in]	userPermissions		The user permissions, see {@link FSUserPermissions::e_permPrint FSUserPermissions::e_permXXX} values and this would be one or combination of its values.
 * @param[in]	userPassword		The user password, which is used to open the PDF document.
 * @param[in]	ownerPassword		The owner password, which is used to take ownership of the PDF document.
 * @param[in]	cipher				See {FSCipherType::e_cipherXXX} values. e_cipherNone is not allowed.
 * @param[in]	keyLen				The key length, in bytes.
 *									For FSCommonDefines::e_cipherRC4 cipher, this value should be between 5 and 16. The prefered one should be 16.
 *									For FSCommonDefines::e_cipherAES cipher, this value should be 16 or 32.
 * @param[in]	encryptMetadata		Whether to encrypt metadata or not.
 *
 * @return YES if initialize successfully, else NO.
 */
-(BOOL)initialize:(unsigned int)userPermissions userPassword:(NSString*)userPassword ownerPassword:(NSString*)ownerPassword cipher:(FSCipherType)cipher keyLen:(int)keyLen encryptMetadata:(BOOL)encryptMetadata;

@end


/**
 * @brief	Class to represent a certificate security handler, used for certificate encryption.
 *
 * @see	FSSecurityHandler
 */
@interface FSCertificateSecurityHandler : FSSecurityHandler

/**
 * @brief	Create a certificate security handler object.
 *
 * @return	A new certificate security handler object.
 */
-(id)init;

/**
 * @brief	Initialize current certificate security handler.
 *
 * @param[in]	x509Certificates	An array which each element specifies the binary buffer of x509 certificates.
 * @param[in]	cipher				Cipher type.
 *									Please refer to {FSCipherType::e_cipherXXX} values and this should be one of these values,
 *									except {@link FSCipherType::e_cipherNone}.
 * @param[in]	encryptMetadata		A boolean value that indicates whether to encrypt metadata or not.<br>
 *									<b>YES</b> means to encrypt metadata, and <b>NO</b> means not to encrypt metadata.
 *
 * @return	<b>YES</b> means success, while <b>FASLE</b> means failure.
 *
 * @exception	e_errParam		Value of input parameter is invalid.
 */
-(BOOL)initialize: (NSArray<NSData*>*)x509Certificates cipher: (FSCipherType)cipher encryptMetadata: (BOOL)encryptMetadata;

-(void)dealloc;

@end

/**
 * @brief Class to represent a callback object for custom decryption and encryption.
 *
 * @details User should inherit this callback class and implement the pure virtual functions (as callback functions).
 *          User can register their own custom security callback object to Foxit PDF SDK, by function
 *          {@link FSLibrary::RegisterSecurityCallback} with any custom filter name (following the PDF name
 *          conventions). Function {@link FSLibrary::UnregisterSecurityCallback} can be called to unregister
 *          the security callback object with the registered filter name.
 */
@interface FSCustomSecurityCallback : FSSecurityCallback
/** @brief SWIG proxy related function, it's deprecated to use it. */
-(void*)getCptr;
/** @brief SWIG proxy related function, it's deprecated to use it. */
-(id)initWithCptr: (void*)cptr swigOwnCObject: (BOOL)ownCObject;
-(id)init;
/**
 * @brief Get the encryption type of security callback.
 *
 * @note User should not override this function, otherwise there will be unexpected behavior.
 *
 * @return The encryption type. It would always be {@link FSEncryptType::e_encryptCustom FSEncryptType::e_encryptCustom}.
 */
-(FSEncryptType)getSecurityType;

/**
 * @brief A callback function used to create context for encryption and decryption.
 *
 * @param[in] filter        The encryption filter of the PDF document.
 * @param[in] subFilter    The sub filter of the PDF document.
 * @param[in] encryptInfo  The encryption information of the PDF document.
 *
 * @note User should implement this callback function.
 *
 * @return The encryption context.
 */
-(void *)createContext: (NSString *)filter subFilter: (NSString *)subFilter encryptInfo: (NSString *)encryptInfo;

/**
 * @brief A callback function used to release the context for encryption and decryption.
 *
 * @param[in] context  The context for encryption and decryption, returned by callback function
 *                     {@link FSCustomSecurityCallback::CreateContext}.
 *
 * @note User should implement this callback function.
 *
 * @return <b>TRUE</b> means success, while <b>FALSE</b> means failure.
 */
-(BOOL)releaseContext: (void *)context;

/**
 * @brief A callback function used to get the user permissions.
 *
 * @param[in] context          The context for encryption and decryption, returned by callback function
 *                             {@link FSCustomSecurityCallback::CreateContext}.
 * @param[in] userPermission  Original permission settings of the document. Please refer to
 *                             {@link FSUserPermissions::e_permPrint FSUserPermissions::e_permXXX} values and this whould be
 *                             one or combination of its values.
 *
 * @note User should implement this callback function.
 *
 * @return The new user permissions. Please refer to {@link FSUserPermissions::e_permPrint FSUserPermissions::e_permXXX} values
 *         and this should be one or combination of its values.
 */
-(FSUserPermissions)getUserPermissions: (void *)context userPermission: (FSUserPermissions)userPermission;

/**
 * @brief A callback function used to check if current user is the owner of the PDF document.
 *
 * @param[in] context  The context for encryption and decryption, returned by callback function
 *                     {@link FSCustomSecurityCallback::CreateContext}.
 *
 * @note User should implement this callback function.
 *
 * @return <b>TRUE</b> means current user is the owner, and <b>FALSE</b> means current user is not the owner.
 */
-(BOOL)isOwner: (void *)context;

/**
 * @brief A callback function used to get the cipher type.
 *
 * @param[in] context  The context for encryption and decryption, returned by callback function
 *                     {@link FSCustomSecurityCallback::CreateContext}.
 *
 * @note User should implement this callback function.
 *
 * @return The cipher type. Please refer to {@link FSCipherType::e_cipherNone FSCipherType::e_cipherXXX} values and this
 *         should be one or combination of its values.
 */
-(FSCipherType)getCipher: (void *)context;

/**
 * @brief A callback function used to get the encryption key.
 *
 * @param[in] context  The context for encryption and decryption, returned by callback function
 *                     {@link FSCustomSecurityCallback::CreateContext}.
 *
 * @note User should implement this callback function.
 *
 * @return The encryption key.
 */
-(NSString *)getEncryptKey: (void *)context;

/**
 * @brief A callback function used to get the estimated decrypted data size.
 *
 * @param[in] context        The context for encryption and decryption, returned by callback function
 *                           {@link FSCustomSecurityCallback::CreateContext}.
 * @param[in] srcDataSize  Size of source data which is to be decrypted.
 *
 * @note User should implement this callback function.
 *
 * @return The estimated decrypted data size.
 */
-(unsigned int)getDecryptedSize: (void *)context srcDataSize: (unsigned int)srcDataSize;

/**
 * @brief A callback function used to start a decryption.
 *
 * @param[in] context  The context for encryption and decryption, returned by callback function
 *                     {@link FSCustomSecurityCallback::CreateContext}.
 * @param[in] objNum  The object number for a PDF object.
 * @param[in] genNum  The generation number for a PDF object.
 *
 * @note User should implement this callback function.
 *
 * @return A decryptor implemented and created by user.
 */
-(void *)startDecryptor: (void *)context objNum: (int)objNum genNum: (int)genNum;

/**
 * @brief A callback function used to decrypt the encrypted data.
 *
 * @param[in] decryptor           The decryptor implemented and created by user, returned by callback function
 *                                {@link FSCustomSecurityCallback::StartDecryptor}.
 * @param[in] encryptedData      The buffer which stores the encrypted data.
 * @param[in] encryptedDataLen  The length of encrypted data, in bytes.
 *
 * @note User should implement this callback function.
 *
 * @return The decrypted data content.
 */
-(NSString*)decryptData: (void *)decryptor encryptedData: (void *)encryptedData encryptedDataLen: (unsigned int)encryptedDataLen;

/**
 * @brief A callback function used to finish the decryption.
 *
 * @param[in] decryptor  The decryptor implemented and created by user, returned by callback function
 *                       {@link FSCustomSecurityCallback::StartDecryptor}.
 *
 * @note User should implement this callback function.
 *
 * @return The decrypted data content.
 */
-(NSString *)finishDecryptor: (void *)decryptor;

/**
 * @brief A callback function used to get the estimated encrypted size.
 *
 * @param[in] context       The context for encryption and decryption, returned by callback function
 *                          {@link FSCustomSecurityCallback::CreateContext}.
 * @param[in] objNum       The object number for a PDF object.
 * @param[in] genNum       The generation number for a PDF object.
 * @param[in] srcData      The buffer which stores the plain text to be encrypted.
 * @param[in] srcDataLen  The length of the buffer.
 *
 * @note User should implement this callback function.
 *
 * @return The estimated encrypted size.
 */
-(unsigned int)getEncryptedSize: (void *)context objNum: (int)objNum genNum: (int)genNum srcData: (void *)srcData srcDataLen: (unsigned int)srcDataLen;

/**
 * @brief A callback function used to get encrypted data.
 *
 * @param[in] context          The context for encryption and decryption, returned by callback function
 *                             {@link FSCustomSecurityCallback::CreateContext}.
 * @param[in] objNum          The object number for a PDF object.
 * @param[in] genNum          The generation number for a PDF object.
 * @param[in] srcData         The buffer which stores the plain text to be encrypted.
 * @param[in] srcDataLen     The length of the buffer.
 * @param[out] dstBuffer      Used to receives the encrypted content.
 * @param[out] dstBufferLen  Used to received the length of the encrypted data.
 *
 * @note User should implement this callback function.
 *
 * @return <b>TRUE</b> means success, while <b>FALSE</b> means failure.
 */
-(BOOL)encryptData: (void *)context objNum: (int)objNum genNum: (int)genNum srcData: (void *)srcData srcDataLen: (unsigned int)srcDataLen dstBuffer: (void *)dstBuffer dstBufferLen: (unsigned int *)dstBufferLen;

-(void)dealloc;

@end

/**
 * @brief Class to represent a custom security handler, used for custom encryption.
 *
 * @see FSSecurityHandler
 */
@interface FSCustomSecurityHandler : FSSecurityHandler
/** @brief SWIG proxy related function, it's deprecated to use it. */
-(void*)getCptr;
/** @brief SWIG proxy related function, it's deprecated to use it. */
-(id)initWithCptr: (void*)cptr swigOwnCObject: (BOOL)ownCObject;
-(id)init;

/**
 * @brief Get the encryption type of current security handler.
 *
 * @return The encryption type. It would always return
 *         {@link FSEncryptType::e_encryptPassword FSEncryptType::e_encryptCustom}.
 */
-(FSEncryptType)getSecurityType;

/**
 * @brief Initialize current custom security handler.
 *
 * @details If this function is successfully, Foxit PDF SDK will take over the input security callback object and
 *          user should not release this callback object directly anymore; otherwise unexpected crash may occurs
 *          later.<br>
 *
 * @param[in] filter               The filter of PDF document for encryption, in UTF-8 encoding.
 *                                 It should not be <b>NULL</b> or empty.
 * @param[in] subFilter           The sub filter of PDF document, in UTF-8 encoding.
 *                                 It should not be <b>NULL</b> or empty.
 * @param[in] encryptInfo         The encryption information,which will be stored to document encryption dictionary.
 *                                 This can be <b>NULL</b> or empty.
 * @param[in] isEncryptMetadata  A boolean value that indicates whether to encrypt metadata or not.<br>
 *                                 <b>TRUE</b> means to encrypt metadata, and <b>FALSE</b> means not to
 *                                 encrypt metadata.
 * @param[in] callback             A valid FSCustomSecurityCallback object, which is inherited and implemented
 *                                 by user for their own encryption and description algorithm.
 *                                 It should not be <b>NULL</b>.
 *
 * @return <b>TRUE</b> means success, while <b>FASLE</b> means failure.
 */
-(BOOL)initialize: (NSString *)filter subFilter: (NSString *)subFilter encryptInfo: (NSString *)encryptInfo isEncryptMetadata: (BOOL)isEncryptMetadata callback: (FSCustomSecurityCallback *)callback;

-(void)dealloc;

@end
