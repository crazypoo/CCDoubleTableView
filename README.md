# CCDoubleTableView
一个简易外卖界面
只需要导入CCDoubleTableview,并在界面用SB或者代码初始化界面，传入数据即可
数据的格式为
[
{[数组]:@"title",[数组]:@"content"},
{[数组]:@"title",[数组]:@"content"},
{[数组]:@"title",[数组]:@"content"},
];
即一个数组包括多个字典，字典分title：Section名，和content：每个Section的子数据
content内装TakeOutModel,每个model有
* 食品标题
 * 食品id
 * 已经售出的份数
 * 价格
 * 图像地址
 等属性，您也可以自己添加属性并进行扩展
 这是我的第一个项目，可能会有问题，还请您多包涵，多多指正。
