# AndyExtension
A fast, convenient and nonintrusive conversion for JSON to model. Your model class don't need to extend another base class. You don't need to modify any model file.

__use in pod:__ _pod 'AndyExtension'_

_AnyExtionsion aimed to Combine JSON to Model easily._

---

#### __*There are three methods paragraph:*__

###### __一、to JSON Model__

- `+ (instancetype)andy_objectWithFileName:(NSString *)fileName;`

    The argument is a file's name. The file is not only the plist file, also can be the common file like 'txt'.

    Attension:The file should be contained in the mainBundle.


- `+ (instancetype)andy_objectWithFilePath:(NSString *)filePath;`

    The argument is a file's path. The path should be combined by the mainBundle.

- `+ (instancetype)andy_objectWithString:(NSString *)jsonString;`

    The argument is some jsonString that is valid,otherwise it returns nil.

- `+ (instancetype)andy_objectWithKeyValues:(NSDictionary *)keyValues;`

  The argument is a dictionary. Just use Model Class call this method, you can get one model contains data as you define.


###### __二、to JSON Model Array__

- `+ (NSArray *)andy_objectArrayWithFileName:(NSString *)fileName;`

    The argument is a file's name. The file is not only the plist file, also can be the common file like 'txt'.

    Attension:The file should be contained in the mainBundle.

- `+ (NSArray *)andy_objectArrayWithFilePath:(NSString *)filePath;`

    The argument is a file's path. The path should be combined by the mainBundle.

- `+ (NSArray *)andy_objectArrayWithString:(NSString *)jsonString;`

    The argument is some jsonString that is valid,otherwise it returns nil.

- `+ (NSArray *)andy_objectArrayWithKeyValuesArray:(NSArray *)keyValuesArray;
`

    The argument is an array. JJust use Model Class call this method, you can get an arrary contains array data as you define.

###### __三、Model to jsonString__

- `- (NSString *)andy_JSONString;`

    Andy NSObject that called this method can be serialized to jsonString.That's easy to  processing data by it.

---

#### __*Another two Class methods for Model implementation:*__

- `+ (NSDictionary *)andy_replacedKeyFromPropertyName;`

    Use this method, you can replace the key in JSON to what you want to use in your Model.

    For instance, the `id` key in JSON, you can replace it to Model key `ID`.

+ `+ (NSDictionary *)andy_objectClassInArray`

    Use this method, you can replace the array type in JSON to an array according your Model that is containted in array.

---

#### _**Tips:**_

- Before you run, you need pod install first.(Since I use RAC and Masonry to reduce my codes.)

---



#### __*The last:*__

_The version is 1.0.3_

_There are a lot of experience to improve_

_If you are also interst on it, just pull request_
