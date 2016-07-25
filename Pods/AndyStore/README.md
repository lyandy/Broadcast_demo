# AndyStore
use json、NSDictionary and NSUserDefaults to store、read、delete and clear data easily

__Use in pod:__ pod 'AndyStore'

__*First of all*__

- The AndyJsonStore Module is based on [AndyExtension](https://github.com/lyandy/AndyExtension). Don't worry, the AndyExtension core has been compiled in it. So the AndyStore is independent.

- Any data you get from AndyStore, you should convert its type to the type that you want manually by yourself.（PS:the AndyJsonStore is an exception. It can convert data type automatically.）

---


### *There are three main methods paragraph*

##### *一、AndyJsonStore*

In the module, it supports all Object-C types. It store data permanently.So everytime and everywhere in app, you can access you data easily.

__*Four methods:*__

`- (BOOL)setOrUpdateValue:(id)value ForKey:(NSString *)key;`

`- (instancetype)getValueForClass:(Class)valueClass ForKey:(NSString *)key DefaultValue:(id)defaultValue ;`

`- (BOOL)removeValueForKey:(NSString *)key;`

`- (BOOL)clear;`

##### *二、AndyDictStore*

Just like AndyJsonStore, it also supports all Object-C types. But it stores data temporarily. Once your app is closed , the data it stores will be destoryed. Since it's builded based on NSDictionary.

__*Four methods:*__

`- (BOOL)setOrUpdateValue:(id)value ForKey:(NSString *)key;`

`- (instancetype)getValueForKey:(NSString *)key DefaultValue:(id)defaultValue ;`

`- (BOOL)removeValueForKey:(NSString *)key;`

`- (BOOL)clear;`

##### *三、AndyUserDefaultsStore*

This Module is a little sepcial. Since it just supports the baseic Object-C types like NSNumber、NSInteger etc. Just like AndyDictStore, it stores data temporarily.

__*Four methods:*__

`- (BOOL)setOrUpdateValue:(id)value ForKey:(NSString *)key;`

`- (instancetype)getValueForKey:(NSString *)key DefaultValue:(id)defaultValue ;`

`- (BOOL)removeValueForKey:(NSString *)key;`

`- (BOOL)clear;`

---

### __*The last:*__

_Before you run, you need pod install first. :)_

_The version is 1.0.5_

_There are a lot of experience to improve_

_If you are also interest on it, just pull request_
