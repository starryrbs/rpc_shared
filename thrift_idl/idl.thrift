// ==============注释==========

/*
* 多行注释
* */

// 单行注释
# 单行注释

// ==============描述==========

//Thrift文件的描述跟一般语言一样在文件顶部通过注释来表述服务的内容等等信息

// ==============文档==========

include 'baseType.thrift'

// 定义部分包括 Const 、 Typedef 、 Enum 、 Senum 、 Struct 、 Union 、 Exception 、 Service
const i32 INT_CONST = 1234
const map<string,string> MAP_CONST = {"test":"hello world"}

// 自定义类型
typedef i32 MyInteger

// 枚举类型

//Thrift枚举类型只支持单个32位int类型数据，第一个元素如果没有给值那么默认是0，之后的元素如果没有给值，则是在前一个元素基础上加1

enum Number{
    ONE = 1,
    TWO, // 值是2,前一个元素+1
    THREE,
    FOUR = 4,
}
// 类似于C的struct，是一系列相关数据的封装，在OOP语言中会转换为类(class)，struct的每个元素包括一个唯一的数字标识、一个数据类型、一个名称和一个可选的默认值。
struct MyStruct{
    1: string string_thing,
    4: required i8 byte_thing,
    16: optional string optional_thing = 'default value'
}
/*
* required:
1、写：必须字段始终写入，并且应该设置这些字段。
2、读：必须字段始终读取，并且它们将包含在输入流中
3、默认值：始终写入
注意：如果一个必须字段在读的时候丢失，则会抛出异常或返回错误，所以在版本控制的时候，要严格控制字段的必选和可选，必须字段如果被删或者改为可选，那将会造成版本不兼容。
*
* */

/*
* optional:
1、写：可选字段仅在设置时写入
2、读：可选字段可能是也可能不是输入流的一部分
3、默认值：在设置了isset标志时写入
Thrift使用所谓的“isset”标志来指示是否设置了特定的可选字段， 仅设置了此标志的字段会写入，相反，仅在从输入流中读取字段值时才设置该标志。
*
* */

/*
*default:
1、写：理论上总是写入，但是有一些特例
2、读：跟optional一样
3、默认值：可能不会写入
默认类型是required和optional的结合，可选输入（读），必须输出（写）。
*
* */


//Union：类似于C++的union，成员默认全部是optional类型，语法
union SomeUnion{
    2: string string_thing,
    3: i32 i32_thing
}

// Exception：异常跟struct类似，会跟目标语言本地异常集成，语法：


exception MyException{
    1:i32 errorCode,
    2:string message
}

// Service：service是Thrift 服务器提供的一系列功能列表接口，在客户端就是调用这些接口来完成操作

service MyService{
    void testVoid(),
    bool testBool(1: bool thing),
    map<i32,i32> testMap(1: map<i32,i32> thing),
}