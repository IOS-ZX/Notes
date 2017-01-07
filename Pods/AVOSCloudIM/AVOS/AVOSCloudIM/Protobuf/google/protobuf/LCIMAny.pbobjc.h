// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: google/protobuf/any.proto

// This CPP symbol can be defined to use imports that match up to the framework
// imports needed when using CocoaPods.
#if !defined(LCIM_USE_PROTOBUF_FRAMEWORK_IMPORTS)
 #define LCIM_USE_PROTOBUF_FRAMEWORK_IMPORTS 0
#endif

#if LCIM_USE_PROTOBUF_FRAMEWORK_IMPORTS
 #import <Protobuf/LCIMProtocolBuffers.h>
#else
 #import "LCIMProtocolBuffers.h"
#endif

#if GOOGLE_PROTOBUF_OBJC_GEN_VERSION != 30001
#error This file was generated by a different version of protoc which is incompatible with your Protocol Buffer library sources.
#endif

// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

CF_EXTERN_C_BEGIN

NS_ASSUME_NONNULL_BEGIN

#pragma mark - LCIMAnyRoot

/// Exposes the extension registry for this file.
///
/// The base class provides:
/// @code
///   + (LCIMExtensionRegistry *)extensionRegistry;
/// @endcode
/// which is a @c LCIMExtensionRegistry that includes all the extensions defined by
/// this file and all files that it depends on.
@interface LCIMAnyRoot : LCIMRootObject
@end

#pragma mark - LCIMAny

typedef GPB_ENUM(LCIMAny_FieldNumber) {
  LCIMAny_FieldNumber_TypeURL = 1,
  LCIMAny_FieldNumber_Value = 2,
};

/// `Any` contains an arbitrary serialized protocol buffer message along with a
/// URL that describes the type of the serialized message.
///
/// Protobuf library provides support to pack/unpack Any values in the form
/// of utility functions or additional generated methods of the Any type.
///
/// Example 1: Pack and unpack a message in C++.
///
///     Foo foo = ...;
///     Any any;
///     any.PackFrom(foo);
///     ...
///     if (any.UnpackTo(&foo)) {
///       ...
///     }
///
/// Example 2: Pack and unpack a message in Java.
///
///     Foo foo = ...;
///     Any any = Any.pack(foo);
///     ...
///     if (any.is(Foo.class)) {
///       foo = any.unpack(Foo.class);
///     }
///
/// The pack methods provided by protobuf library will by default use
/// 'type.googleapis.com/full.type.name' as the type URL and the unpack
/// methods only use the fully qualified type name after the last '/'
/// in the type URL, for example "foo.bar.com/x/y.z" will yield type
/// name "y.z".
///
///
/// JSON
/// ====
/// The JSON representation of an `Any` value uses the regular
/// representation of the deserialized, embedded message, with an
/// additional field `\@type` which contains the type URL. Example:
///
///     package google.profile;
///     message Person {
///       string first_name = 1;
///       string last_name = 2;
///     }
///
///     {
///       "\@type": "type.googleapis.com/google.profile.Person",
///       "firstName": <string>,
///       "lastName": <string>
///     }
///
/// If the embedded message type is well-known and has a custom JSON
/// representation, that representation will be embedded adding a field
/// `value` which holds the custom JSON in addition to the `\@type`
/// field. Example (for message [google.protobuf.Duration][]):
///
///     {
///       "\@type": "type.googleapis.com/google.protobuf.Duration",
///       "value": "1.212s"
///     }
@interface LCIMAny : LCIMMessage

/// A URL/resource name whose content describes the type of the
/// serialized protocol buffer message.
///
/// For URLs which use the schema `http`, `https`, or no schema, the
/// following restrictions and interpretations apply:
///
/// * If no schema is provided, `https` is assumed.
/// * The last segment of the URL's path must represent the fully
///   qualified name of the type (as in `path/google.protobuf.Duration`).
///   The name should be in a canonical form (e.g., leading "." is
///   not accepted).
/// * An HTTP GET on the URL must yield a [google.protobuf.Type][]
///   value in binary format, or produce an error.
/// * Applications are allowed to cache lookup results based on the
///   URL, or have them precompiled into a binary to avoid any
///   lookup. Therefore, binary compatibility needs to be preserved
///   on changes to types. (Use versioned type names to manage
///   breaking changes.)
///
/// Schemas other than `http`, `https` (or the empty schema) might be
/// used with implementation specific semantics.
@property(nonatomic, readwrite, copy, null_resettable) NSString *typeURL;

/// Must be a valid serialized protocol buffer of the above specified type.
@property(nonatomic, readwrite, copy, null_resettable) NSData *value;

@end

NS_ASSUME_NONNULL_END

CF_EXTERN_C_END

#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
